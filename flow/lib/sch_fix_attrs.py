#!/usr/bin/env python3
"""Repair schematics drawn by the netlist importer before update 9, in place.

    python3 flow/lib/sch_fix_attrs.py cells/<CELL>/schematic/<CELL>.sch [...]

Two defects of the older importer, harmless for LVS but fatal for simulation:

  1. PDK device instances carried only W/L/model. The sky130 symbols compute ad/as/pd/ps with
     expressions that use @nf, so the simulation netlist kept a literal '@nf' and ngspice stopped
     ("Syntax error: letter [@]"). Fix: add the symbol's plain defaults (nf=1, mult=1, sa=0 ...)
     that the instance does not set - exactly what xschem does when you place a symbol by hand.
  2. Supplies were drawn with devices/vdd.sym and devices/gnd.sym, which are GLOBAL labels: the
     cell's VDPWR/VGND became chip-wide nets, disconnected from what its pins are wired to (a
     testbench driving the VGND pin saw a floating ground). Fix: global=false on those symbols.

Only attributes are added; positions, wires and every existing value stay as they are, so manual
rearrangements are kept. Running it twice changes nothing. Needs PDK_ROOT and PDK (EDA box).
"""
from __future__ import annotations

import os
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from sch_from_spice import read_symbol  # noqa: E402

INST = re.compile(r"^(C \{([^}]+)\} \S+ \S+ \S+ \S+ \{)(.*)\}\s*$")
SUPPLY = ("devices/vdd.sym", "devices/gnd.sym")


def pdk_symbol_dir() -> Path:
    root, pdk = os.environ.get("PDK_ROOT"), os.environ.get("PDK")
    if not root or not pdk:
        sys.exit("sch_fix_attrs: PDK_ROOT and PDK are not set (run this in the EDA box)")
    d = Path(root) / pdk / "libs.tech" / "xschem"
    if not d.is_dir():
        sys.exit(f"sch_fix_attrs: PDK symbol library not found: {d}")
    return d


def keys_of(attr_text: str) -> set[str]:
    return {k.lower() for k in re.findall(r'(?:^|\s)([A-Za-z_]\w*)=', attr_text)}


def fix_file(path: Path, symdir: Path, cache: dict) -> list[str]:
    out, changes = [], []
    for line in path.read_text(errors="replace").splitlines():
        m = INST.match(line)
        if m:
            head, ref, attrs = m.group(1), m.group(2), m.group(3)
            have = keys_of(attrs)
            add = []
            if ref in SUPPLY and "global" not in have:
                add.append("global=false")
            elif ref.startswith("sky130_fd_pr/"):
                if ref not in cache:
                    f = symdir / ref
                    cache[ref] = read_symbol(f, ref).template if f.is_file() else None
                tmpl = cache[ref]
                if tmpl:
                    for k, v in tmpl.items():
                        if k.lower() in have or k.lower() in ("name", "spiceprefix") \
                                or "@" in v or "expr" in v:
                            continue
                        add.append(f"{k}={v}")
            if add:
                name = re.search(r"(?:^|\s)name=(\S+)", attrs)
                changes.append(f"{name.group(1) if name else ref}: +{' '.join(add)}")
                line = f"{head}{attrs} {' '.join(add)}}}"
        out.append(line)
    if changes:
        path.write_text("\n".join(out) + "\n")
    return changes


def main() -> int:
    files = [Path(a) for a in sys.argv[1:]]
    if not files:
        print(__doc__)
        return 2
    symdir, cache = pdk_symbol_dir(), {}
    total = 0
    for f in files:
        if not f.is_file():
            print(f"sch_fix_attrs: {f}: not found")
            return 2
        ch = fix_file(f, symdir, cache)
        total += bool(ch)
        print(f"sch_fix_attrs: {f}: {'%d instance(s) fixed' % len(ch) if ch else 'already fine'}")
    print(f"sch_fix_attrs: {total} of {len(files)} schematic(s) changed")
    return 0


if __name__ == "__main__":
    sys.exit(main())
