#!/usr/bin/env python3
"""SPICE utilities used by the flow (stdlib only).

  fix-ports    Reconcile a magic PEX netlist with the schematic's .subckt:
               merge aliased nets, verify the port SET matches, force the port ORDER.
  swap-tb      Build a post-layout testbench: remove the DUT's .subckt from the
               schematic testbench and .include the PEX netlist instead.
  check-specs  Extract measurements from an ngspice log; check them against specs.txt.

SPICE is case-insensitive; every comparison here is too, while original spelling is kept.
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path


class FlowError(Exception):
    pass


# ---------------------------------------------------------------------------- parsing
def read_lines(path: str) -> list[str]:
    return Path(path).read_text(encoding="utf-8", errors="replace").splitlines()


def logical_spans(lines: list[str]):
    """Yield (first, last, text) per logical line, joining '+' continuation lines."""
    i, n = 0, len(lines)
    while i < n:
        first, text = i, lines[i]
        j = i + 1
        while j < n and lines[j].lstrip().startswith("+"):
            text += " " + lines[j].lstrip()[1:]
            j += 1
        yield first, j - 1, text
        i = j


def subckt_header(text: str):
    """Return (name, ports, params) if text is a .subckt line, else None."""
    toks = text.split()
    if len(toks) < 2 or toks[0].lower() != ".subckt":
        return None
    ports, params, in_params = [], [], False
    for t in toks[2:]:
        if in_params or "=" in t or t.lower() == "params:":
            in_params = True
            params.append(t)
        else:
            ports.append(t)
    return toks[1], ports, params


def find_subckt(lines: list[str], cell: str | None):
    """Locate .subckt <cell> (or the only .subckt when cell is None).
    Returns (first, last_header_line, ends_line, name, ports, params)."""
    hits = []
    for first, last, text in logical_spans(lines):
        h = subckt_header(text)
        if h and (cell is None or h[0].lower() == cell.lower()):
            hits.append((first, last, h))
    if not hits:
        return None
    if len(hits) > 1:
        raise FlowError(f"multiple .subckt definitions match {cell!r}")
    first, last, (name, ports, params) = hits[0]
    for k in range(last + 1, len(lines)):
        if re.match(r"^\s*\.ends\b", lines[k], re.I):
            return first, last, k, name, ports, params
    raise FlowError(f".subckt {name} has no matching .ends")


def format_subckt(name: str, ports: list[str], params: list[str], per_line: int = 10) -> list[str]:
    out = [f".subckt {name} " + " ".join(ports[:per_line])]
    for k in range(per_line, len(ports), per_line):
        out.append("+ " + " ".join(ports[k:k + per_line]))
    if params:
        out.append("+ " + " ".join(params))
    return out


def replace_token(line: str, old: str, new: str) -> str:
    """Replace whole whitespace-delimited tokens equal to `old` (case-insensitive)."""
    parts = re.split(r"(\s+)", line)
    low = old.lower()
    return "".join(new if p.lower() == low else p for p in parts)


# ---------------------------------------------------------------------------- fix-ports
def cmd_fix_ports(a) -> int:
    ref = find_subckt(read_lines(a.ref), a.cell)
    if ref is None:
        raise FlowError(f"reference netlist {a.ref} has no .subckt {a.cell}")
    ref_ports = ref[4]

    lines = read_lines(a.pex)
    loc = find_subckt(lines, a.cell)
    if loc is None:
        loc = find_subckt(lines, None)          # magic may name the flat cell differently
        if loc is None:
            raise FlowError(f"PEX netlist {a.pex} contains no .subckt")
        print(f"note: PEX subckt '{loc[3]}' renamed to '{a.cell}'")
    first, last, ends, _name, _ports, params = loc

    # 1) Aliases: a PEX-only net (e.g. magic's substrate VSUBS) is the same node as a
    #    schematic port. Renaming every occurrence inside the subckt merges them electrically.
    for spec in a.alias or []:
        if ":" not in spec:
            raise FlowError(f"bad --alias {spec!r}; expected FROM:TO")
        old, new = spec.split(":", 1)
        for k in range(first, ends + 1):
            if not lines[k].lstrip().startswith("*"):
                lines[k] = replace_token(lines[k], old, new)
        print(f"alias applied: {old} -> {new}")

    # Re-read the (possibly aliased) header; de-duplicate case-insensitively, keep order.
    header = " ".join([lines[first]] + [lines[k].lstrip()[1:] for k in range(first + 1, last + 1)])
    _, pex_ports_raw, params = subckt_header(header)
    spelling: dict[str, str] = {}
    for p in pex_ports_raw:
        spelling.setdefault(p.lower(), p)

    ref_low = [p.lower() for p in ref_ports]
    missing = [p for p in ref_ports if p.lower() not in spelling]
    extra = [spelling[k] for k in spelling if k not in ref_low]
    if missing or extra:
        msg = ["PEX ports do not match the schematic ports"]
        if missing:
            msg.append(f"  missing in layout : {' '.join(missing)}  (unlabelled pins / label on wrong layer?)")
        if extra:
            msg.append(f"  extra in layout   : {' '.join(extra)}  (merge with PEX_PORT_ALIAS, e.g. VSUBS:VSS)")
        msg.append(f"  schematic order   : {' '.join(ref_ports)}")
        raise FlowError("\n".join(msg))

    new_ports = [spelling[p.lower()] for p in ref_ports]
    if [p.lower() for p in pex_ports_raw] != ref_low:
        print(f"port order rewritten to schematic order: {' '.join(new_ports)}")
    lines[ends] = f".ends {a.cell}"                      # before the header edit shifts indices
    lines[first:last + 1] = format_subckt(a.cell, new_ports, params)

    out = ["* PEX netlist post-processed by flow/lib/spice_tools.py fix-ports",
           f"* port order forced to schematic: {' '.join(new_ports)}"] + lines
    Path(a.out).write_text("\n".join(out) + "\n", encoding="utf-8")

    if a.stats:
        loc2 = find_subckt(out, a.cell)
        body = [l.strip() for l in out[loc2[1] + 1:loc2[2]] if l.strip() and not l.lstrip().startswith("*")]
        first_char = [l[0].lower() for l in body]
        stats = {"ports": new_ports,
                 "devices": sum(c in "xmqdj" for c in first_char),
                 "capacitors": first_char.count("c"),
                 "resistors": first_char.count("r"),
                 "aliases": a.alias or []}
        Path(a.stats).write_text(json.dumps(stats, indent=2) + "\n", encoding="utf-8")
    return 0


# ---------------------------------------------------------------------------- swap-tb
def cmd_swap_tb(a) -> int:
    lines = read_lines(a.tb)
    loc = find_subckt(lines, a.cell)
    if loc is None:
        raise FlowError(f"testbench {a.tb} has no inline '.subckt {a.cell}' to replace "
                        "(is the DUT symbol of type 'subcircuit'?)")
    first, _last, ends, *_ = loc
    del lines[first:ends + 1]

    inst = False
    for _f, _l, text in logical_spans(lines):
        toks = text.split()
        if toks and toks[0][:1].lower() == "x":
            nodes = [t for t in toks[1:] if "=" not in t]
            if nodes and nodes[-1].lower() == a.cell.lower():
                inst = True
                break
    if not inst:
        print(f"warning: no X-instance of {a.cell} found in testbench", file=sys.stderr)

    pex = str(Path(a.pex).resolve())
    # Line 1 of a SPICE deck is ALWAYS the title — insert after it, never before.
    lines[1:1] = [f"* post-layout: DUT '{a.cell}' replaced by PEX netlist", f".include {pex}"]
    Path(a.out).write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"post-layout testbench written: {a.out}")
    return 0


# ---------------------------------------------------------------------------- check-specs
SI = [("meg", 1e6), ("mil", 25.4e-6), ("t", 1e12), ("g", 1e9), ("k", 1e3), ("m", 1e-3),
      ("u", 1e-6), ("n", 1e-9), ("p", 1e-12), ("f", 1e-15), ("a", 1e-18)]
NUM = r"[-+]?(?:\d+\.?\d*|\.\d+)(?:[eE][-+]?\d+)?"


def parse_value(s: str):
    s = s.strip().lower()
    if s in ("", "-", "none", "inf"):
        return None
    m = re.fullmatch(rf"({NUM})([a-z]*)", s)
    if not m:
        raise FlowError(f"cannot parse value {s!r}")
    num, suffix = float(m.group(1)), m.group(2)
    for pre, mult in SI:            # 'meg'/'mil' tested before 'm'; trailing unit letters ignored
        if suffix.startswith(pre):
            return num * mult
    return num


def parse_measurements(log_path: str) -> dict[str, float]:
    meas: dict[str, float] = {}
    pat = re.compile(rf"^\s*([A-Za-z_][\w.\[\]]*)\s*=\s*({NUM})(?![\w.])")
    for line in read_lines(log_path):
        m = pat.match(line)
        if m:
            meas[m.group(1).lower()] = float(m.group(2))   # last occurrence wins
    return meas


def cmd_check_specs(a) -> int:
    meas = parse_measurements(a.log)
    result = {"measurements": meas, "specs": [], "all_pass": True}
    if a.specs:
        for n, raw in enumerate(read_lines(a.specs), 1):
            line = raw.split("#", 1)[0].strip()
            if not line:
                continue
            f = line.split()
            if len(f) != 3:
                raise FlowError(f"{a.specs}:{n}: expected '<name> <min|-> <max|->'")
            name, lo, hi = f[0].lower(), parse_value(f[1]), parse_value(f[2])
            val = meas.get(name)
            if val is None:
                status = "MISSING"
            elif (lo is not None and val < lo) or (hi is not None and val > hi):
                status = "FAIL"
            else:
                status = "PASS"
            result["specs"].append({"name": name, "value": val, "min": lo, "max": hi, "status": status})
            if status != "PASS":
                result["all_pass"] = False
            print(f"spec {name:<20} {status:<7} value={val} min={lo} max={hi}")
    Path(a.out).write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    return 0 if result["all_pass"] else 1


# ---------------------------------------------------------------------------- main
def main(argv=None) -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)

    p = sub.add_parser("fix-ports")
    p.add_argument("--ref", required=True, help="schematic LVS netlist (port order authority)")
    p.add_argument("--pex", required=True)
    p.add_argument("--cell", required=True)
    p.add_argument("--alias", action="append", help="FROM:TO net merge (repeatable)")
    p.add_argument("--out", required=True)
    p.add_argument("--stats")
    p.set_defaults(fn=cmd_fix_ports)

    p = sub.add_parser("swap-tb")
    p.add_argument("--tb", required=True)
    p.add_argument("--cell", required=True)
    p.add_argument("--pex", required=True)
    p.add_argument("--out", required=True)
    p.set_defaults(fn=cmd_swap_tb)

    p = sub.add_parser("check-specs")
    p.add_argument("--log", required=True)
    p.add_argument("--specs")
    p.add_argument("--out", required=True)
    p.set_defaults(fn=cmd_check_specs)

    a = ap.parse_args(argv)
    try:
        return a.fn(a)
    except (FlowError, OSError) as e:
        print(f"error: {e}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
