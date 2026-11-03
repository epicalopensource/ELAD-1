#!/usr/bin/env python3
"""Convert a flat gate-level Verilog netlist (sky130_fd_sc_hd cells) into a SPICE .subckt.

    python3 flow/lib/gl2spice.py <netlist.v> <module> <out.spice> \
        --stdcells $PDK_ROOT/$PDK/libs.ref/sky130_fd_sc_hd/spice/*.spice \
        [--name ELAD1_CONTROL] [--power VDPWR] [--ground VGND] [--embed] \
        [--sym cells/ELAD1_CONTROL/schematic/ELAD1_CONTROL.sym] [--lvs-out FILE]

Rules
  * Port order of the .subckt:
      --sym FILE given (always use it for a cell that has an xschem symbol): the symbol's pin
        order, buses expanded MSB first. xschem writes an instance line POSITIONALLY in symbol
        pin order and never looks at the .subckt it includes, so this is the only order that
        connects correctly. Every symbol pin must exist in the netlist and vice versa, else the
        script stops (a renamed or missing port can never be silently miswired).
      no --sym: the module header order, buses MSB first, then power and ground. Unsafe for
        place-and-route netlists: LibreLane/OpenROAD write the header in ALPHABETICAL order.
  * Cell pin order is read from the PDK SPICE library, so it can never disagree with it.
  * Cell supplies: VPWR, VPB -> power;  VGND, VNB -> ground.
  * 'assign' statements are refused: synthesize with 'insbuf' so every port is a real driver
    (two port names on one node cannot be expressed in a .subckt).
  * --embed copies the .subckt definitions of every cell type used into the output, so the
    file is self-contained (one .include is enough).
  * --lvs-out FILE additionally writes the same netlist with the PDK cell definitions exactly as
    shipped (reference for LVS). The main output is then the SIMULATION netlist, in which
    diode-containing cells (e.g. the antenna cell sky130_fd_sc_hd__diode_2) are rewritten:
      - area/perim given in the x1e12 / x1e6 convention (e.g. area=4.347e+11) are converted to
        um^2 / um (area=0.4347), which is what ngspice-47 with the PDK '.option scale=1u' expects;
        left as is, ngspice-47 simulates them as enormous diodes;
      - rs_int=0 is added (the PDK's own ESD wrappers do the same): the PDK series resistance
        becomes ~1e-10 ohm, a conductance so large that ngspice produces fake microamps.
    Antenna diodes are reverse-biased and inert in operation, so this changes nothing physical.
"""
import argparse
import re
import sys


def strip_comments(s):
    s = re.sub(r'/\*.*?\*/', '', s, flags=re.S)
    return re.sub(r'//[^\n]*', '', s)


def ident(tok):
    tok = tok.strip()
    if tok.startswith('\\'):
        tok = tok[1:].strip()
    return tok


def read_lib(path):
    pins, body = {}, {}
    cur = None
    for line in open(path):
        m = re.match(r'\.subckt\s+(\S+)\s+(.*)', line, re.I)
        if m:
            cur = m.group(1)
            pins[cur] = [p for p in m.group(2).split() if '=' not in p]
            body[cur] = [line]
            continue
        if cur:
            if line.startswith('+'):
                pins[cur] += [p for p in line[1:].split() if '=' not in p]
            body[cur].append(line)
            if re.match(r'\.ends', line, re.I):
                cur = None
    return pins, body


def read_sym_pins(path):
    """Pin names of an xschem symbol in netlist order (file order, or sim_pinnumber if present),
    buses 'a[7:0]' expanded MSB first exactly as xschem expands them."""
    pins = []
    for k, line in enumerate(open(path)):
        if not line.startswith('B 5 '):
            continue
        attrs = line[line.index('{') + 1:line.rindex('}')]
        m = re.search(r'(?:^|\s)name=(\S+)', attrs)
        if not m:
            continue
        n = re.search(r'sim_pinnumber=(\d+)', attrs)
        pins.append((int(n.group(1)) if n else 10**6 + k, m.group(1)))
    out = []
    for _, p in sorted(pins):
        b = re.fullmatch(r'(\w+)\[(\d+):(\d+)\]', p)
        if b:
            hi, lo = int(b.group(2)), int(b.group(3))
            step = -1 if hi >= lo else 1
            out += [f'{b.group(1)}[{i}]' for i in range(hi, lo + step, step)]
        else:
            out.append(p)
    if not out:
        sys.exit(f'gl2spice: no pins found in {path}')
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('netlist'); ap.add_argument('module'); ap.add_argument('out')
    ap.add_argument('--stdcells', required=True, nargs='+', help='one or more std-cell SPICE files (fd_sc_hd library, ef_sc_hd cells)')
    ap.add_argument('--name'); ap.add_argument('--power', default='VDPWR'); ap.add_argument('--ground', default='VGND')
    ap.add_argument('--embed', action='store_true')
    ap.add_argument('--sym', help='xschem symbol whose pin order the .subckt must follow')
    ap.add_argument('--lvs-out', help='also write the LVS reference netlist (PDK cell definitions unchanged)')
    a = ap.parse_args()

    src = strip_comments(open(a.netlist).read())
    m = re.search(r'\bmodule\s+' + re.escape(a.module) + r'\s*\((.*?)\)\s*;(.*?)\bendmodule', src, re.S)
    if not m:
        sys.exit(f'gl2spice: module {a.module} not found')
    header = [ident(p) for p in m.group(1).split(',')]
    body = m.group(2)
    if re.search(r'\bassign\b', body):
        sys.exit('gl2spice: netlist contains assign statements; re-synthesize with insbuf')

    width = {}
    for kind, rng, names in re.findall(r'\b(input|output|inout)\s*(\[\s*\d+\s*:\s*\d+\s*\])?\s*([^;]+);', body):
        for n in names.split(','):
            n = ident(n)
            if rng:
                hi, lo = map(int, re.findall(r'\d+', rng))
                width[n] = (hi, lo)
            else:
                width[n] = None
    ports = []
    for p in header:
        if width.get(p):
            hi, lo = width[p]
            step = -1 if hi >= lo else 1
            ports += [f'{p}[{i}]' for i in range(hi, lo + step, step)]
        else:
            ports.append(p)

    ports = [p for p in ports if p not in (a.power, a.ground)]   # supplies are appended below
    tail = [a.power, a.ground]
    if a.sym:
        sym_order = read_sym_pins(a.sym)
        missing = [p for p in sym_order if p not in ports and p not in tail]
        extra = [p for p in ports if p not in sym_order]
        nosup = [p for p in tail if p not in sym_order]
        if missing or extra or nosup:
            sys.exit(f'gl2spice: symbol {a.sym} and netlist ports differ:\n'
                     f'  in symbol only : {" ".join(missing + nosup) or "-"}\n'
                     f'  in netlist only: {" ".join(extra) or "-"}')
        ports, tail = sym_order, []
    order_src = f'symbol {a.sym.split("/")[-1]}' if a.sym else f'module header of {a.module}'

    libpins, libbody = {}, {}
    for f in a.stdcells:
        p_, b_ = read_lib(f)
        libpins.update(p_); libbody.update(b_)
    supply = {'VPWR': a.power, 'VPB': a.power, 'VGND': a.ground, 'VNB': a.ground}
    inst_re = re.compile(r'\b(sky130_(?:fd|ef)_sc_hd__\w+)\s+(\\?\S+)\s*\((.*?)\)\s*;', re.S)
    lines, used = [], set()
    for cell, iname, conns in inst_re.findall(body):
        if cell not in libpins:
            sys.exit(f'gl2spice: {cell} not in the --stdcells files')
        c = {pin: ident(net) for pin, net in re.findall(r'\.(\w+)\s*\(\s*(\\?[^()]*?)\s*\)', conns)}
        nets = []
        for pin in libpins[cell]:
            if pin in supply:
                nets.append(supply[pin])
            elif pin in c and c[pin] != '':
                if "'" in c[pin]:
                    sys.exit(f'gl2spice: constant on {iname}.{pin}; use hilomap/setundef')
                nets.append(c[pin])
            else:
                nets.append(f'nc_{ident(iname).strip("_")}_{pin}')   # unconnected output
        used.add(cell)
        lines.append(f'X{ident(iname).strip("_")} ' + ' '.join(nets) + f' {cell}')

    name = a.name or a.module
    out = [f'* {name}: generated by gl2spice.py from {a.netlist.split("/")[-1]} (module {a.module})',
           f'* {len(lines)} standard cells, {len(used)} cell types; port order from the {order_src}', '']
    out.append(f'.subckt {name} ' + ' '.join(ports + tail))
    out += lines
    out.append(f'.ends {name}')
    def sim_fix(line):
        t = line.split()
        if len(t) > 3 and t[0][0] in 'xXdD' and any('sky130_fd_pr__diode' in x for x in t):
            out_t, fixed = [], False
            for x in t:
                k, _, v = x.partition('=')
                if k.lower() in ('area', 'perim', 'pj') and v:
                    try:
                        f = float(v)
                    except ValueError:
                        out_t.append(x); continue
                    big = 1e6 if k.lower() == 'area' else 1e3
                    if f >= big:
                        f /= 1e12 if k.lower() == 'area' else 1e6
                        fixed = True
                    out_t.append(f'{k}={f:g}')
                else:
                    out_t.append(x)
            if not any(x.lower().startswith('rs_int=') for x in out_t):
                out_t.append('rs_int=0')
            return ' '.join(out_t), True
        return line, False

    nfix = 0
    sim, lvs = list(out), list(out)
    if a.embed:
        hdr = ['', '* ---- standard-cell definitions used above (copied from the PDK)']
        sim += hdr; lvs += hdr
        for cell in sorted(used):
            for l in libbody[cell]:
                l = l.rstrip('\n')
                lvs.append(l)
                l2, ch = sim_fix(l)
                nfix += ch
                sim.append(l2)
    if a.lvs_out:
        sim.insert(2, '* SIMULATION netlist: diode cells rewritten (see gl2spice.py docstring); LVS uses ' + a.lvs_out.split('/')[-1])
        open(a.lvs_out, 'w').write('\n'.join(lvs) + '\n')
        open(a.out, 'w').write('\n'.join(sim) + '\n')
        print(f'gl2spice: {nfix} diode line(s) rewritten for simulation; LVS reference -> {a.lvs_out}')
    else:
        open(a.out, 'w').write('\n'.join(lvs) + '\n')
    print(f'gl2spice: port order from the {order_src}')
    print(f'gl2spice: {name}: {len(ports) + len(tail)} ports, {len(lines)} cells, {len(used)} types -> {a.out}')


if __name__ == '__main__':
    main()
