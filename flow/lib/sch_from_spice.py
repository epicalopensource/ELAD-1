#!/usr/bin/env python3
"""Turn a SPICE netlist into xschem schematics (.sch) and symbols (.sym).

    # one cell, written into the flow's cell folder (cells/<name>/schematic/)
    python3 flow/lib/sch_from_spice.py ota.spice --cells

    # every .subckt in the file, plus the top level (testbench) if it has devices
    python3 flow/lib/sch_from_spice.py design.spice --all --cells

    # anywhere else
    python3 flow/lib/sch_from_spice.py ota.spice --out /tmp/import

What it does
  * Each .subckt becomes <name>.sch, drawn the way a designer would (--style pro, default):
    VDD at the top, ground at the bottom, PMOS above NMOS, series devices stacked in
    columns, differential pairs side by side with gates outward, current mirrors facing
    each other on one gate bar with the diode connection drawn, supply symbols and rails,
    bulk labels, inputs from the left and outputs to the right, passives between signal
    nets in a side column. Wires are drawn where they read well; far-away pins of a net
    get net labels (see sch_pretty.py). --style bus draws every net as a wire on a bus
    track; --style labels uses only net labels. Every style netlists back to exactly the
    same circuit.
  * Each .subckt also gets <name>.sym whose pins are in .subckt order, so xschem's netlist and
    LVS use the same port order as the original netlist.
  * A netlist with devices outside any .subckt (a testbench) becomes <file stem>.sch; its dot
    commands (.include, .param, .control ... .endc, ...) go into a code block.

Supported elements
  X<name> ... sky130_fd_pr__<device> params   -> the PDK symbol sky130_fd_pr/<device>.sym
  X<name> ... <subckt> params                -> <subckt>.sym (generated, or an existing project symbol)
  R C L V I                                   -> devices/res, capa, ind, vsource, isource
  E/G n+ n- nc+ nc- gain                      -> devices/vcvs, vccs
  E/G n+ n- vol=|cur='expr', B n+ n- V|I='expr' -> devices/bsource (behavioural; E/G are renamed B...)
  M<name> d g s b <model> params              -> sky130 symbol when <model> is a sky130_fd_pr__ fet
  D<name> anode cathode sky130_fd_pr__<diode> area= pj=   -> sky130_fd_pr/diode.sym (pj -> perim)
Anything else is reported and the run stops, rather than silently dropping a device.

Pin ports: '*.PININFO A:I B:O C:B' lines (Cadence style) set ipin/opin/iopin; otherwise every
port is an iopin. Symbols are looked up on --libpath (default: the PDK's xschem library, the
xschem system library and the project's cells/*/schematic folders).
"""
from __future__ import annotations

import argparse
import glob
import os
import re
import shutil
import sys
from dataclasses import dataclass, field
from pathlib import Path

GRID = 10
DERIVED = {"ad", "as", "pd", "ps", "nrd", "nrs", "sa", "sb", "sd"}   # sky130 template computes these
PRIMS = {"r": ("devices/res.sym", "R"), "c": ("devices/capa.sym", "C"),
         "l": ("devices/ind.sym", "L"), "v": ("devices/vsource.sym", "V"),
         "i": ("devices/isource.sym", "I")}


# controlled sources: linear E (voltage-controlled voltage) and G (voltage-controlled current) keep their
# own symbol; E/G written with an expression (vol=... / cur=...) become a B (behavioural) source.
LINEAR = {"e": "devices/vcvs.sym", "g": "devices/vccs.sym"}
BSRC = "devices/bsource.sym"


class ImportError_(Exception):
    pass


# ----------------------------------------------------------------------------------- netlist
@dataclass
class Element:
    name: str          # as in the netlist, e.g. XM1, R3
    nets: list[str]
    model: str         # model / subckt name / '' for R C L V I
    params: list[tuple[str, str]]
    value: str = ""    # R C L V I value text


@dataclass
class Subckt:
    name: str
    ports: list[str]
    params: list[tuple[str, str]] = field(default_factory=list)
    elements: list[Element] = field(default_factory=list)
    pininfo: dict[str, str] = field(default_factory=dict)
    extra: list[str] = field(default_factory=list)   # dot lines kept as code


def _join_lines(text: str) -> list[str]:
    out: list[str] = []
    for raw in text.splitlines():
        s = raw.rstrip()
        if s.lstrip().startswith("+") and out:
            out[-1] += " " + s.lstrip()[1:].strip()
        else:
            out.append(s)
    return out


def _split_params(tokens: list[str]) -> tuple[list[str], list[tuple[str, str]]]:
    """Separate positional tokens from key=value params (handles 'k = v' and quoted values)."""
    joined = " ".join(tokens)
    joined = re.sub(r"\s*=\s*", "=", joined)
    parts = re.findall(r"""[^\s=]+=(?:'[^']*'|"[^"]*"|\{[^}]*\}|\S+)|\S+""", joined)
    pos, kv = [], []
    for p in parts:
        if "=" in p and not p.startswith("="):
            k, v = p.split("=", 1)
            kv.append((k, v))
        else:
            pos.append(p)
    return pos, kv


def parse_netlist(text: str) -> tuple[dict[str, Subckt], Subckt]:
    subs: dict[str, Subckt] = {}
    top = Subckt("", [])
    cur = top
    in_control = False
    for line in _join_lines(text):
        s = line.strip()
        if not s:
            continue
        low = s.lower()
        if in_control:
            cur.extra.append(s)
            if low.startswith(".endc"):
                in_control = False
            continue
        if s.startswith("*"):
            m = re.match(r"\*\.pininfo\s+(.*)", s, re.I)
            if m:
                for item in m.group(1).split():
                    if ":" in item:
                        n, d = item.rsplit(":", 1)
                        cur.pininfo[n] = d.upper()
            continue
        if low.startswith(".subckt"):
            toks = s.split()[1:]
            if not toks:
                raise ImportError_(f"bad line: {s}")
            pos, kv = _split_params(toks[1:])
            pos = [p for p in pos if p.lower() != "params:"]
            cur = Subckt(toks[0], pos, kv)
            subs[cur.name] = cur
            continue
        if low.startswith(".ends"):
            cur = top
            continue
        if low.startswith(".end") and not low.startswith(".endc"):
            continue
        if low.startswith(".control"):
            in_control = True
            cur.extra.append(s)
            continue
        if s.startswith("."):
            cur.extra.append(s)
            continue
        cur.elements.append(_parse_element(s))
    return subs, top


def _parse_element(s: str) -> Element:
    toks = s.split()
    name, kind = toks[0], toks[0][0].lower()
    if kind == "x":
        pos, kv = _split_params(toks[1:])
        if len(pos) < 2:
            raise ImportError_(f"cannot read instance line: {s}")
        return Element(name, pos[:-1], pos[-1], kv)
    if kind == "m":
        pos, kv = _split_params(toks[1:])
        if len(pos) < 5:
            raise ImportError_(f"cannot read MOSFET line: {s}")
        return Element(name, pos[:4], pos[4], kv)
    if kind == "d":
        pos, kv = _split_params(toks[1:])
        if len(pos) != 3:
            raise ImportError_(f"cannot read diode line (D<name> anode cathode model params): {s}")
        return Element(name, pos[:2], pos[2], kv)
    if kind in LINEAR or kind == "b":
        body = s.split(None, 3)
        if len(body) < 4:
            raise ImportError_(f"cannot read controlled source: {s}")
        nets2, rest = body[1:3], body[3].strip()
        m = re.match(r"(vol|cur|value)\s*=\s*(.+)$", rest, re.I) if kind != "b" else \
            re.match(r"([vi])\s*=\s*(.+)$", rest, re.I)
        if m:                                              # behavioural: B<name> n+ n- V|I = 'expr'
            expr = m.group(2).strip()
            if len(expr) > 1 and expr[0] == expr[-1] and expr[0] in "'\"":
                expr = expr[1:-1]
            var = ("V" if kind == "e" else "I") if kind != "b" else m.group(1).upper()
            bname = name if kind == "b" else "B" + name[1:]
            return Element(bname, nets2, "", [("VAR", var)], expr)
        if kind == "b":
            raise ImportError_(f"B source needs V=... or I=...: {s}")
        parts = rest.split(None, 2)                        # E/G linear: n+ n- nc+ nc- gain
        if len(parts) != 3:
            raise ImportError_(f"cannot read {name} (expected: {name} n+ n- nc+ nc- gain): {s}")
        return Element(name, nets2 + parts[:2], "", [], parts[2].strip())
    if kind in PRIMS:
        nets = toks[1:3]
        rest = " ".join(toks[3:])
        # keep value text whole (e.g. PULSE(...), DC 1.8, 10f m=2)
        m = re.match(r"(.*?)(?:\s+(m|mult)\s*=\s*(\S+))?\s*$", rest, re.I)
        value = m.group(1).strip() if m else rest
        params = [("m", m.group(3))] if m and m.group(3) else []
        return Element(name, nets, "", params, value)
    raise ImportError_(f"element type '{toks[0][0]}' not supported: {s}")


# ----------------------------------------------------------------------------------- symbols
@dataclass
class SymInfo:
    ref: str                                   # as written in the .sch, e.g. sky130_fd_pr/nfet_01v8.sym
    pins: list[tuple[str, float, float]]       # (name, x, y) in @pinlist order
    template: dict[str, str]
    spiceprefix: str
    bbox: tuple[float, float, float, float]


def _prop(block: str, key: str) -> str | None:
    # a quote preceded by a backslash is part of the value (templates nest \\"...\\")
    m = re.search(rf'(?:^|\s){key}=("(?:[^"]|(?<=\\)")*"|\S+)', block, re.S)
    if not m:
        return None
    v = m.group(1)
    return v[1:-1] if v.startswith('"') else v


def read_symbol(path: Path, ref: str) -> SymInfo:
    text = path.read_text(errors="replace")
    kblock = re.search(r"^K \{(.*?)\n?\}\s*$", text, re.S | re.M)
    kb = kblock.group(1) if kblock else ""
    tmpl_txt = _prop(kb, "template") or ""
    template = {}
    for k, v in re.findall(r'([A-Za-z_][\w]*)=((?:\\"[^"]*\\"|"[^"]*"|\S)+)', tmpl_txt):
        template[k] = v
    pins, xs, ys = [], [], []
    for m in re.finditer(r"^B 5 (\S+) (\S+) (\S+) (\S+) \{([^}]*)\}", text, re.M):
        x1, y1, x2, y2 = map(float, m.group(1, 2, 3, 4))
        nm = re.search(r"name=(\S+)", m.group(5))
        pins.append((nm.group(1) if nm else "?", (x1 + x2) / 2, (y1 + y2) / 2))
    for m in re.finditer(r"^[LB] \d+ (\S+) (\S+) (\S+) (\S+)", text, re.M):
        a = list(map(float, m.group(1, 2, 3, 4)))
        xs += [a[0], a[2]]
        ys += [a[1], a[3]]
    bbox = (min(xs, default=-20), min(ys, default=-20), max(xs, default=20), max(ys, default=20))
    # @pinlist follows sim_pinnumber when every pin has one, else file order (xschem rule)
    sim = re.findall(r"^B 5 [^{]*\{[^}]*sim_pinnumber=(\d+)", text, re.M)
    if sim and len(sim) == len(pins):
        pins = [p for _, p in sorted(zip(map(int, sim), pins), key=lambda t: t[0])]
    return SymInfo(ref, pins, template, template.get("spiceprefix", ""), bbox)


class SymbolFinder:
    def __init__(self, libpath: list[Path]):
        self.libpath = [p for p in libpath if p.is_dir()]
        self.cache: dict[str, SymInfo | None] = {}

    def find(self, rel: str) -> SymInfo | None:
        if rel not in self.cache:
            self.cache[rel] = None
            for d in self.libpath:
                p = d / rel
                if p.is_file():
                    self.cache[rel] = read_symbol(p, rel)
                    break
        return self.cache[rel]


def default_libpath(project: Path | None) -> list[Path]:
    paths = []
    pdk = os.environ.get("PDK_ROOT"), os.environ.get("PDK")
    if all(pdk):
        paths.append(Path(pdk[0]) / pdk[1] / "libs.tech" / "xschem")
    exe = shutil.which("xschem")
    if exe:
        base = Path(exe).resolve().parent.parent / "share" / "xschem"
        paths += [base / "xschem_library", base / "xschem_library" / "devices"]
    paths += [Path("/foss/tools/xschem/share/xschem/xschem_library"),
              Path("/usr/local/share/xschem/xschem_library"),
              Path("/usr/share/xschem/xschem_library")]
    if project:
        paths.append(project / "cells")
        paths += sorted(Path(p) for p in glob.glob(str(project / "cells" / "*" / "schematic")))
    return paths


# -------------------------------------------------------------------------------- generation
def esc(v: str) -> str:
    return v.replace("\\", "\\\\").replace("{", "\\{").replace("}", "\\}")


def attr_value(v: str) -> str:
    if re.search(r"\s", v) and not (v.startswith('"') and v.endswith('"')):
        return '"' + v.replace('"', '\\"') + '"'
    return v


def make_cell_symbol(sub: Subckt) -> str:
    """Subcircuit symbol, pins in .subckt order: inputs/inouts left, outputs right."""
    kinds = {p: sub.pininfo.get(p, "B") for p in sub.ports}
    left = [p for p in sub.ports if kinds[p] != "O"]
    right = [p for p in sub.ports if kinds[p] == "O"]
    if not right and len(left) > 1:               # no direction info: split evenly
        half = (len(left) + 1) // 2
        left, right = left[:half], left[half:]
    rows = max(len(left), len(right), 1)
    w = max(60, (max((len(p) for p in sub.ports), default=4) * 7 + 30) // 10 * 10)
    top = -(rows * 20) // 2 // 10 * 10 - 10
    bot = top + rows * 20 + 10
    params = " ".join(f"{k}={v}" for k, v in sub.params)
    tmpl = "name=x1" + (" " + params if params else "")
    fmt = "@name @pinlist @symname" + "".join(f" {k}=@{k}" for k, _ in sub.params)
    out = ["v {xschem version=3.4.4 file_version=1.2}", "G {}",
           f'K {{type=subcircuit\nformat="{fmt}"\ntemplate="{tmpl}"\n}}',
           "V {}", "S {}", "E {}", f"B 4 {-w} {top} {w} {bot} {{}}"]
    dirs = {"I": "in", "O": "out", "B": "inout"}
    by_name = {}
    for i, p in enumerate(left):
        by_name[p] = (-w - 20, top + 20 + i * 20, 0)
    for i, p in enumerate(right):
        by_name[p] = (w + 20, top + 20 + i * 20, 1)
    for p in sub.ports:                            # file order == .subckt order == @pinlist order
        x, y, r = by_name[p]
        edge = -w if r == 0 else w
        out.append(f"L 4 {x} {y} {edge} {y} {{}}")
        out.append(f"B 5 {x - 2.5} {y - 2.5} {x + 2.5} {y + 2.5} {{name={esc(p)} dir={dirs[kinds[p]]}}}")
        tx = edge + 5 if r == 0 else edge - 5
        out.append(f"T {{{esc(p)}}} {tx} {y - 6} 0 {r} 0.2 0.2 {{}}")
    out.append(f"T {{@symname}} {-w} {top - 30} 0 0 0.25 0.25 {{}}")
    out.append(f"T {{@name}} {-w} {bot + 5} 0 0 0.2 0.2 {{}}")
    return "\n".join(out) + "\n"


def resolve(el: Element, finder: SymbolFinder, local: dict[str, Path]) -> tuple[SymInfo, dict[str, str], list[str]]:
    """Symbol for an element, the instance attributes, and notes about dropped params."""
    notes: list[str] = []
    kind = el.name[0].lower()
    if kind in PRIMS:
        ref, prefix = PRIMS[kind]
        sym = finder.find(ref)
        if sym is None:
            raise ImportError_(f"{ref} not found on the symbol path")
        attrs = {"name": el.name, "value": el.value}
        attrs.update({k.lower(): v for k, v in el.params})
        return sym, attrs, notes
    if kind in LINEAR:
        sym = finder.find(LINEAR[kind])
        if sym is None:
            raise ImportError_(f"{LINEAR[kind]} not found on the symbol path")
        return sym, {"name": el.name, "value": el.value}, notes
    if kind == "b":
        sym = finder.find(BSRC)
        if sym is None:
            raise ImportError_(f"{BSRC} not found on the symbol path")
        var = dict(el.params).get("VAR", "V")
        return sym, {"name": el.name, "VAR": var, "FUNC": "\"'" + el.value.replace('"', "'") + "'\"", "m": "1"}, notes
    model = el.model
    pdk = re.match(r"sky130_fd_pr__(\w+)$", model)
    if kind == "d":
        if not (pdk and "diode" in pdk.group(1)):
            raise ImportError_(f"{el.name}: diode model '{model}' is not a sky130_fd_pr__ diode")
        sym = finder.find("sky130_fd_pr/diode.sym")
        if sym is None:
            raise ImportError_(f"{el.name}: sky130_fd_pr/diode.sym not found on the symbol path")
        attrs = {"name": el.name, "model": pdk.group(1)}
        tkeys = {k.lower(): k for k in sym.template}
        for k, v in el.params:
            kl = {"pj": "perim"}.get(k.lower(), k.lower())   # SPICE pj = the symbol's perim
            if kl in tkeys:
                attrs[tkeys[kl]] = v
            else:
                notes.append(f"{el.name}: parameter {k}={v} has no attribute on {sym.ref}, dropped")
        return sym, attrs, notes
    if pdk:
        sym = finder.find(f"sky130_fd_pr/{pdk.group(1)}.sym")
        if sym is None:
            raise ImportError_(f"{el.name}: no symbol sky130_fd_pr/{pdk.group(1)}.sym for model {model}")
        attrs = {"model": pdk.group(1)}
    elif model in local:
        sym = read_symbol(local[model], f"{model}.sym")
        attrs = {}
    else:
        sym = finder.find(f"{model}.sym") or finder.find(f"{model}/schematic/{model}.sym")
        if sym is None:
            raise ImportError_(f"{el.name}: unknown model/subckt '{model}' (not a sky130_fd_pr device, "
                               "not defined in this netlist, no symbol on the path)")
        attrs = {}
    name = el.name
    if sym.spiceprefix and name.upper().startswith(sym.spiceprefix.upper()) and len(name) > 1:
        name = name[len(sym.spiceprefix):]
    attrs = {"name": name, **attrs}
    tkeys = {k.lower(): k for k in sym.template}
    for k, v in el.params:
        kl = k.lower()
        if kl in DERIVED and pdk:
            continue                                   # template formulas recompute them
        if kl == "m" and "m" not in tkeys:            # sky130 symbols print m from mult / MF
            alias = next((t for t in ("mult", "mf") if t in tkeys), None)
            if alias:
                given = {kk.lower(): vv for kk, vv in el.params}
                if alias in given:
                    if given[alias] != v:
                        notes.append(f"{el.name}: m={v} differs from {tkeys[alias]}={given[alias]}; "
                                     f"kept {tkeys[alias]}")
                    continue
                kl = alias
        if kl in tkeys or not pdk:
            attrs[tkeys.get(kl, k)] = v
        else:
            notes.append(f"{el.name}: parameter {k}={v} has no attribute on {sym.ref}, dropped")
    if pdk:
        _add_template_defaults(attrs, sym)
    return sym, attrs, notes


def _add_template_defaults(attrs: dict, sym) -> None:
    """Give a PDK instance the plain default attributes of its symbol (nf=1, mult=1, sa=0 ...),
    as xschem does when a symbol is placed by hand. The sky130 symbols compute ad/as/pd/ps with
    expressions such as expr('int((@nf + 1)/2) * @W / @nf * 0.29'); without nf on the instance
    the simulation netlist keeps a literal '@nf' and ngspice stops. Computed defaults (values
    with '@' or expr) stay in the symbol; only plain values are copied."""
    have = {k.lower() for k in attrs}
    for k, v in sym.template.items():
        if k.lower() in have or k.lower() in ("name", "spiceprefix") or "@" in v or "expr" in v:
            continue
        attrs[k] = v


def _snap(v: float) -> int:
    return int(round(v / GRID) * GRID)


PORT_SYM = {"I": "devices/ipin.sym", "O": "devices/opin.sym", "B": "devices/iopin.sym"}


def _lab(x, y, net, rot, flip, n):
    return (f"C {{devices/lab_pin.sym}} {x:g} {y:g} {rot} {flip} "
            f"{{name=l{n} sig_type=std_logic lab={esc(net)}}}")


def _inst(sym: SymInfo, attrs: dict[str, str], cx, cy) -> str:
    body = " ".join(f"{k}={esc(attr_value(v))}" for k, v in attrs.items())
    return f"C {{{sym.ref}}} {cx:g} {cy:g} 0 0 {{{body}}}"


def _labels_layout(placed, sub: Subckt, row_of) -> list[str]:
    """Every terminal gets a short wire and a net label; labels with equal names connect."""
    lines, n = [], 0
    rows: dict[int, list] = {}
    for item in placed:
        rows.setdefault(row_of(item[0], item[1]), []).append(item)
    y = 0
    for r in sorted(rows):
        x, height = 200, 0
        for el, sym, attrs in rows[r]:
            bx1, by1, bx2, by2 = sym.bbox
            cx, cy = _snap(x - bx1 + 60), _snap(y - by1 + 40)
            for (pname, px, py), net in zip(sym.pins, el.nets):
                ax, ay = cx + px, cy + py
                dx, dy = (px > 0) - (px < 0), (py > 0) - (py < 0)
                if abs(px) >= abs(py):
                    dy, dx = 0, (dx or -1)
                else:
                    dx = 0
                ex, ey = ax + 30 * dx, ay + 30 * dy
                lines.append(f"N {ax:g} {ay:g} {ex:g} {ey:g} {{lab={esc(net)}}}")
                rot, flip = {(-1, 0): (0, 0), (1, 0): (0, 1), (0, -1): (1, 0), (0, 1): (3, 0)}[(dx, dy)]
                n += 1
                lines.append(_lab(ex, ey, net, rot, flip, n))
            lines.append(_inst(sym, attrs, cx, cy))
            x = cx + bx2 + 140 + 6 * max((len(t) for t in el.nets), default=0)
            height = max(height, by2 - by1)
        y += _snap(height + 200)
    for i, p in enumerate(sub.ports):
        d = sub.pininfo.get(p, "B")
        px, py = -120, 20 + 40 * i
        lines.append(f"C {{{PORT_SYM[d]}}} {px} {py} 0 {0 if d == 'I' else 1} {{name=p{i + 1} lab={esc(p)}}}")
        lines.append(f"N {px} {py} {px + 40} {py} {{lab={esc(p)}}}")
        n += 1
        lines.append(_lab(px + 40, py, p, 0, 1, n))
    return lines


def _wired_layout(placed, sub: Subckt, row_of) -> list[str]:
    """Real wires. All parts sit in one row; every net gets its own horizontal bus track
    below the row, and every terminal is routed to its track on its own vertical lane.

    Why this cannot short two nets: lanes and drops have x positions unique to one terminal,
    tracks have y positions unique to one net, jogs above a part have heights unique to one
    terminal, and parts occupy disjoint x ranges. Wires of different nets therefore only
    ever cross mid-segment (xschem does not connect those); every intended junction is an
    endpoint-to-endpoint joint (tracks are split at each drop)."""
    lines: list[str] = []
    # blocks: ports first (pin at the origin, wired to the right), then the parts by row
    blocks = []
    if sub.ports:                       # one column of port pins, wired to the right
        ppins = [(p, 0.0, 4.0 * GRID * i, "R") for i, p in enumerate(sub.ports)]
        blocks.append(("ports", None, None, ppins, (-60.0, -10.0, 0.0, 4.0 * GRID * len(ppins)), 0))
    for el, sym, attrs in sorted(placed, key=lambda t: row_of(t[0], t[1])):
        pins = []
        for (pname, px, py), net in zip(sym.pins, el.nets):
            if abs(px) >= abs(py):
                side = "L" if px <= 0 else "R"
            else:
                side = "T" if py < 0 else "B"
            pins.append((net, px, py, side))
        blocks.append(("part", sym, attrs, pins, sym.bbox, 0))

    G = GRID
    x = 0
    segs: list[tuple[str, float, float, float, float]] = []      # (net, x1, y1, x2, y2)
    drops: list[tuple[str, float, float]] = []                   # (net, x, y where the drop starts)
    single_ends: list[tuple[str, float, float, int, int]] = []
    bottoms = []
    net_count: dict[str, int] = {}
    for blk in blocks:
        for net, *_ in blk[3]:
            net_count[net] = net_count.get(net, 0) + 1

    for kind, sym, attrs, pins, (bx1, by1, bx2, by2), flip in blocks:
        left = sorted([p for p in pins if p[3] == "L"], key=lambda p: p[2])      # top first
        right = sorted([p for p in pins if p[3] == "R"], key=lambda p: p[2])
        tops = sorted([p for p in pins if p[3] == "T"], key=lambda p: p[1])
        t_left = [p for p in tops if p[1] <= 0]
        t_right = [p for p in tops if p[1] > 0]
        xl = min([bx1] + [p[1] for p in pins])
        xr = max([bx2] + [p[1] for p in pins])
        nl, nr = len(left) + len(t_left), len(right) + len(t_right)
        span_l = 2 * G + G * nl
        cx = _snap(x + span_l - xl + G)
        cy = 0.0
        lane_l0 = (cx + xl) // G * G          # grid point at or left of the leftmost feature
        lane_r0 = -((-(cx + xr)) // G) * G    # grid point at or right of the rightmost feature
        if kind == "ports":
            for i, (p, _, py, _) in enumerate(pins):
                d = sub.pininfo.get(p, "B")
                lines.append(f"C {{{PORT_SYM[d]}}} {cx:g} {cy + py:g} 0 {0 if d == 'I' else 1} "
                             f"{{name=p{i + 1} lab={esc(p)}}}")
        else:
            lines.append(_inst(sym, attrs, cx, cy))
        top_y = cy + by1

        def route(net, pts):
            for (x1, y1), (x2, y2) in zip(pts, pts[1:]):
                if (x1, y1) != (x2, y2):
                    segs.append((net, x1, y1, x2, y2))
            drops.append((net, pts[-1][0], pts[-1][1]))

        # left/right pins: out to a lane (top pin = outermost lane), then down
        for i, (net, px, py, _) in enumerate(left):
            ax, ay = cx + px, cy + py
            lane = lane_l0 - G * (len(left) - i) - G
            if net_count[net] < 2:
                single_ends.append((net, ax, ay, -1, 0)); continue
            route(net, [(ax, ay), (lane, ay)])
        for i, (net, px, py, _) in enumerate(right):
            ax, ay = cx + px, cy + py
            lane = lane_r0 + G * (len(right) - i) + G
            if net_count[net] < 2:
                single_ends.append((net, ax, ay, 1, 0)); continue
            route(net, [(ax, ay), (lane, ay)])
        # top pins: up to a private jog height, sideways past the side lanes, then down
        for j, (net, px, py, _) in enumerate(tops):
            ax, ay = cx + px, cy + py
            jog = _snap(top_y) - 2 * G - G * j
            if net_count[net] < 2:
                single_ends.append((net, ax, ay, 0, -1)); continue
            if px <= 0:
                k = t_left.index((net, px, py, "T"))
                lane = lane_l0 - G * (len(left) + 1 + len(t_left) - k) - G
            else:
                k = t_right.index((net, px, py, "T"))
                lane = lane_r0 + G * (len(right) + 1 + len(t_right) - k) + G
            route(net, [(ax, ay), (ax, jog), (lane, jog)])
        # bottom pins: straight down (the drop itself)
        for net, px, py, _ in [p for p in pins if p[3] == "B"]:
            ax, ay = cx + px, cy + py
            if net_count[net] < 2:
                single_ends.append((net, ax, ay, 0, 1)); continue
            drops.append((net, ax, ay))
        bottoms.append(cy + by2)
        x = max(lane_r0 + G * (nr + 3), cx + xr + 6 * G) + (12 * G if kind == "part" else 0)   # room for the part's text

    # one track per net, ordered by first appearance; drops go straight down to it
    order: list[str] = []
    for net, _, _ in drops:
        if net not in order:
            order.append(net)
    base = _snap(max(bottoms + [0]) + 6 * G)
    track = {net: base + 2 * G * i for i, net in enumerate(order)}
    xs: dict[str, list[float]] = {}
    for net, dx, dy in drops:
        ty = track[net]
        if dy != ty:
            segs.append((net, dx, dy, dx, ty))
        xs.setdefault(net, []).append(dx)
    n = 0
    for net in order:
        pts = sorted(set(xs[net]))
        ty = track[net]
        for a, b in zip(pts, pts[1:]):
            segs.append((net, a, ty, b, ty))
        n += 1
        lines.append(_lab(pts[0], ty, net, 0, 0, n))          # net name at the left end
    for net, ax, ay, dx, dy in single_ends:                  # terminals with no partner
        ex, ey = ax + 3 * G * dx, ay + 3 * G * dy
        segs.append((net, ax, ay, ex, ey))
        rot, flip = {(-1, 0): (0, 0), (1, 0): (0, 1), (0, -1): (1, 0), (0, 1): (3, 0)}[(dx, dy)]
        n += 1
        lines.append(_lab(ex, ey, net, rot, flip, n))
    for net, x1, y1, x2, y2 in segs:
        lines.append(f"N {x1:g} {y1:g} {x2:g} {y2:g} {{lab={esc(net)}}}")
    return lines


def make_schematic(sub: Subckt, finder: SymbolFinder, local: dict[str, Path],
                   is_top: bool, style: str = "pro") -> tuple[str, list[str]]:
    notes: list[str] = []
    placed = []
    for el in sub.elements:
        sym, attrs, n = resolve(el, finder, local)
        notes += n
        if len(sym.pins) != len(el.nets):
            raise ImportError_(f"{el.name}: netlist has {len(el.nets)} terminals, {sym.ref} has "
                               f"{len(sym.pins)} pins ({' '.join(p[0] for p in sym.pins)})")
        placed.append((el, sym, attrs))

    def row_of(el, sym):
        r = sym.ref.lower()
        if "pfet" in r:
            return 0
        if "nfet" in r:
            return 1
        if r.startswith("devices/"):
            return 3 if el.name[0].lower() in "vi" else 2
        return 2

    lines = ["v {xschem version=3.4.4 file_version=1.2}", "G {}", "K {}", "V {}", "S {}", "E {}"]
    if style == "labels":
        lines += _labels_layout(placed, sub, row_of)
    elif style == "bus":
        lines += _wired_layout(placed, sub, row_of)
    else:
        sys.path.insert(0, str(Path(__file__).resolve().parent))
        import sch_pretty
        lines += sch_pretty.layout(
            placed, sub, lambda attrs: " ".join(f"{k}={esc(attr_value(v))}" for k, v in attrs.items()))
    if sub.extra:
        code = "\n".join(sub.extra)
        lines.append(f"C {{devices/code_shown.sym}} -400 {_snap(-100 - 20 * len(sub.extra))} 0 0 "
                     f"{{name=s1 only_toplevel=false value=\"{esc(code).replace(chr(34), chr(92) + chr(34))}\"}}")
    return "\n".join(lines) + "\n", notes


# -------------------------------------------------------------------------------------- main
def main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("netlist", type=Path)
    ap.add_argument("subckts", nargs="*", help="subckt names to import (default: the first one)")
    ap.add_argument("--all", action="store_true", help="import every .subckt, and the top level if it has devices")
    g = ap.add_mutually_exclusive_group()
    g.add_argument("--out", type=Path, help="write all files into this folder")
    g.add_argument("--cells", action="store_true",
                   help="write each subckt into cells/<name>/schematic/ of the project (flow layout)")
    ap.add_argument("--project", type=Path, default=Path(__file__).resolve().parents[2])
    ap.add_argument("--libpath", help="colon-separated symbol library folders (overrides the default)")
    ap.add_argument("--force", action="store_true", help="overwrite existing .sch/.sym files")
    ap.add_argument("--style", choices=("pro", "bus", "labels"), default="pro",
                    help="pro (default): drawn like a designer would - supplies top/bottom, stacked "
                         "columns, mirrors and pairs, wires where they read well, labels elsewhere; "
                         "bus: every net a wire on a bus track; labels: net labels only")
    ap.add_argument("--labels", action="store_true", help="same as --style labels")
    a = ap.parse_args(argv)

    written: list[Path] = []
    style = "labels" if a.labels else a.style
    try:
        subs, top = parse_netlist(a.netlist.read_text(errors="replace"))
        names = list(subs) if a.all else (a.subckts or list(subs)[:1])
        unknown = [n for n in names if n not in subs]
        if unknown:
            raise ImportError_(f"not in netlist: {', '.join(unknown)} (has: {', '.join(subs) or 'none'})")
        do_top = (a.all or not subs) and bool(top.elements)
        if not names and not do_top:
            raise ImportError_("nothing to import: no .subckt and no top-level devices")

        def folder(name: str) -> Path:
            if a.cells:
                cell = a.project / "cells" / name
                new_cell = a.project / "flow" / "new_cell.sh"
                if not cell.exists() and new_cell.is_file():
                    import subprocess
                    subprocess.run(["bash", str(new_cell), name], check=True,
                                   stdout=subprocess.DEVNULL)
                return cell / "schematic"
            return a.out or Path.cwd()

        libpath = [Path(p) for p in a.libpath.split(":")] if a.libpath else default_libpath(a.project)
        finder = SymbolFinder(libpath)
        # symbols first: subckts used by other subckts (or the top) need theirs
        local: dict[str, Path] = {}
        all_notes: list[str] = []
        for n in subs:
            if n not in names:
                continue
            d = folder(n)
            d.mkdir(parents=True, exist_ok=True)
            p = d / f"{n}.sym"
            if p.exists() and not a.force:
                print(f"kept       {p} (exists; --force to overwrite)")
            else:
                p.write_text(make_cell_symbol(subs[n]))
                written.append(p)
            local[n] = p
        for n in names:
            text, notes = make_schematic(subs[n], finder, local, False, style)
            all_notes += notes
            p = folder(n) / f"{n}.sch"
            if p.exists() and not a.force:
                print(f"kept       {p} (exists; --force to overwrite)")
            else:
                p.write_text(text)
                written.append(p)
        if do_top:
            # An .include whose subcircuits all became symbols would define them twice
            # (xschem expands the symbols' schematics); keep it as a comment instead.
            kept = []
            for line in top.extra:
                m = re.match(r"\.include\s+[\"']?([^\"'\s]+)", line, re.I)
                inc = (a.netlist.parent / m.group(1)) if m else None
                if inc and inc.is_file():
                    inc_subs, _ = parse_netlist(inc.read_text(errors="replace"))
                    if inc_subs and all(n in local or finder.find(f"{n}.sym") for n in inc_subs):
                        kept.append("* " + line + "   (now provided by the imported symbols)")
                        all_notes.append(f"top level: '{line}' commented out: {', '.join(inc_subs)} "
                                         "come from their symbols now")
                        continue
                kept.append(line)
            top.extra = kept
            stem = a.netlist.stem
            text, notes = make_schematic(top, finder, local, True, style)
            all_notes += notes
            # --cells: a testbench of exactly one cell goes next to it as tb_<cell>.sch
            used = sorted({e.model for e in top.elements if e.name[0].lower() == "x"
                           and (e.model in local or finder.find(f"{e.model}.sym"))})
            if a.cells and len(used) == 1:
                d, p_name = a.project / "cells" / used[0] / "schematic", f"tb_{used[0]}.sch"
            else:
                d, p_name = folder(stem), f"{stem}.sch"
            d.mkdir(parents=True, exist_ok=True)
            p = d / p_name
            if p.exists() and not a.force:
                print(f"kept       {p} (exists; --force to overwrite)")
            else:
                p.write_text(text)
                written.append(p)
        for p in written:
            print(f"wrote      {p}")
        for n in all_notes:
            print(f"note       {n}")
        return 0
    except (ImportError_, OSError) as e:
        for p in written:                 # all or nothing: no half-imported cell left behind
            p.unlink(missing_ok=True)
        print(f"sch_from_spice: {e}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
