#!/usr/bin/env python3
"""Generate xschem symbols (.sym) for subcircuits that exist only as a SPICE netlist.

Typical use: PDK blocks shipped without xschem symbols, e.g. the sky130 IO/ESD cells in
libs.ref/sky130_fd_io/spice/sky130_fd_io.spice.

    python3 flow/lib/sym_from_subckt.py \
        --netlist $PDK_ROOT/$PDK/libs.ref/sky130_fd_io/spice/sky130_fd_io.spice \
        --out cells/_io/schematic \
        sky130_fd_io__top_lvclamp sky130_fd_io__top_analog_pad

    python3 flow/lib/sym_from_subckt.py --netlist <file> --list [REGEX]   # show names + pin counts

Design decisions
  * Pins are taken from the .subckt line, in order, so the symbol can never disagree with the
    netlist it calls. Parameters (tokens with '=') and continuation lines ('+') are handled.
  * type=primitive: xschem emits one instance line ("x1 <nets in pin order> <subckt>") and does
    not try to descend into a schematic, because none exists.
  * The symbol does NOT include the netlist. The testbench (or the parent) must .include the
    PDK file once; including it per symbol would define the same subcircuits several times
    when two different pad symbols are used together.
  * The file name is <subckt>.sym, so @symname equals the subcircuit name exactly.
  * Output is deterministic (same input -> byte-identical file), so regenerating causes no
    git diff and no needless re-verification.
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

PIN_PITCH = 20          # xschem units between pins (default xschem grid is 10)
STUB = 20               # pin stub length outside the body
CHAR_W = 6.5            # approx. width of one character at text size 0.2
MIN_HALF_W = 60


class SubcktError(Exception):
    pass


def read_subckts(netlist: Path) -> dict[str, list[str]]:
    """Return {subckt_name: [pins...]} for every .subckt in the file (case preserved)."""
    try:
        raw = netlist.read_text(errors="replace").splitlines()
    except OSError as e:
        raise SubcktError(f"cannot read {netlist}: {e}") from e

    # Join SPICE continuation lines ('+' at the start of the next line).
    lines: list[str] = []
    for line in raw:
        s = line.strip()
        if s.startswith("+") and lines:
            lines[-1] += " " + s[1:]
        else:
            lines.append(s)

    result: dict[str, list[str]] = {}
    for s in lines:
        if not s.lower().startswith(".subckt"):
            continue
        s = s.split("$", 1)[0]                     # inline comment (ngspice style)
        toks = s.split()
        if len(toks) < 2:
            continue
        name, pins = toks[1], []
        for t in toks[2:]:
            if "=" in t or t.lower() == "params:":
                break                              # parameters start here
            pins.append(t)
        if name in result and result[name] != pins:
            raise SubcktError(f"subckt {name} defined twice with different pins in {netlist}")
        result[name] = pins
    if not result:
        raise SubcktError(f"no .subckt found in {netlist}")
    return result


def esc(text: str) -> str:
    """Escape characters xschem treats specially inside {...} property strings."""
    return text.replace("\\", "\\\\").replace("{", "\\{").replace("}", "\\}")


def make_symbol(name: str, pins: list[str], source: str) -> str:
    if not pins:
        raise SubcktError(f"subckt {name} has no pins")
    dup = sorted({p for p in pins if pins.count(p) > 1})
    if dup:
        raise SubcktError(f"subckt {name} lists pin(s) more than once: {' '.join(dup)}")
    left = pins[: (len(pins) + 1) // 2]
    right = pins[(len(pins) + 1) // 2:]
    rows = max(len(left), len(right))
    longest = max(len(p) for p in pins)
    half_w = max(MIN_HALF_W, int(CHAR_W * longest) + 20)
    half_w = (half_w + 9) // 10 * 10                # keep on the 10-unit grid
    top = -(rows * PIN_PITCH) // 2 - 10
    bot = top + rows * PIN_PITCH + 20
    top, bot = top // 10 * 10, (bot + 9) // 10 * 10

    out = [
        "v {xschem version=3.4.5 file_version=1.2}",
        "G {}",
        "K {type=primitive",
        'format="@name @pinlist @symname"',
        'template="name=x1"',
        f"generated_from=\"{esc(source)}\"",
        "}",
        "V {}",
        "S {}",
        "E {}",
        f"B 4 {-half_w} {top} {half_w} {bot} {{}}",
    ]
    y0 = top + 20
    # Pins in netlist order: all left pins first, then right pins -> @pinlist order == .subckt order.
    for i, p in enumerate(left):
        y = y0 + i * PIN_PITCH
        x = -half_w - STUB
        out.append(f"L 4 {x} {y} {-half_w} {y} {{}}")
        out.append(f"B 5 {x - 2.5} {y - 2.5} {x + 2.5} {y + 2.5} {{name={esc(p)} dir=inout}}")
        out.append(f"T {{{esc(p)}}} {-half_w + 5} {y - 6} 0 0 0.2 0.2 {{}}")
    for i, p in enumerate(right):
        y = y0 + i * PIN_PITCH
        x = half_w + STUB
        out.append(f"L 4 {half_w} {y} {x} {y} {{}}")
        out.append(f"B 5 {x - 2.5} {y - 2.5} {x + 2.5} {y + 2.5} {{name={esc(p)} dir=inout}}")
        out.append(f"T {{{esc(p)}}} {half_w - 5} {y - 6} 0 1 0.2 0.2 {{}}")
    out.append(f"T {{@symname}} {-half_w} {top - 30} 0 0 0.25 0.25 {{}}")
    out.append(f"T {{@name}} {-half_w} {bot + 5} 0 0 0.2 0.2 {{}}")
    return "\n".join(out) + "\n"


def main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--netlist", required=True, type=Path)
    ap.add_argument("--out", type=Path, help="output folder for .sym files")
    ap.add_argument("--list", nargs="?", const=".*", metavar="REGEX",
                    help="list subckt names (filtered by REGEX) with pin counts, write nothing")
    ap.add_argument("cells", nargs="*", help="subckt names to turn into symbols")
    a = ap.parse_args(argv)

    try:
        subs = read_subckts(a.netlist)
        if a.list is not None:
            rx = re.compile(a.list, re.I)
            for n in sorted(subs):
                if rx.search(n):
                    print(f"{len(subs[n]):4d} pins  {n}")
            return 0
        if not a.cells or a.out is None:
            ap.error("give --out and at least one subckt name (or use --list)")
        missing = [c for c in a.cells if c not in subs]
        if missing:
            raise SubcktError("not found in netlist: " + ", ".join(missing)
                              + "  (use --list to see the available names)")
        a.out.mkdir(parents=True, exist_ok=True)
        # Record the netlist relative to $PDK_ROOT/$PDK when possible (never the versioned path).
        src = str(a.netlist)
        m = re.search(r"/(libs\.ref/.*)$", src)
        src = f"$PDK_ROOT/$PDK/{m.group(1)}" if m else src
        for c in a.cells:
            path = a.out / f"{c}.sym"
            text = make_symbol(c, subs[c], src)
            if path.exists() and path.read_text() == text:
                print(f"unchanged  {path}  ({len(subs[c])} pins)")
                continue
            path.write_text(text)
            print(f"wrote      {path}  ({len(subs[c])} pins: {' '.join(subs[c])})")
        return 0
    except SubcktError as e:
        print(f"sym_from_subckt: {e}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
