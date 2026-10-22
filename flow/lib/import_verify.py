#!/usr/bin/env python3
"""Check that imported schematics netlist back to the SPICE netlist they came from.

    python3 flow/lib/import_verify.py <netlist.spice> [SUBCKT ...]      (run from the project root)

For every .subckt of the netlist (or only the ones named) whose schematic exists in
cells/<NAME>/schematic/<NAME>.sch, the flow's own netlist stage writes cells/<NAME>/netlist/<NAME>.spice
with xschem, and that netlist is compared with the source, instance by instance:
ports (in order), terminals (in order), model, and the sizes W, L, nf, area, perim/pj, m/mult,
and the value of R/C/L/V/I. Names are compared case-insensitively (SPICE is case-insensitive).
Not compared: parameters the sky130 symbols compute themselves (ad, as, pd, ps, nrd, nrs, sa, sb,
sd), comments, and instance order. Array instances (A[3:0] drawn once) count as their units:
XA[3] is compared as XA3.

A difference means the schematic does not describe the source circuit: do not use it; report
the printed lines. Exit status: 0 all checked cells match, 1 a difference, 2 usage error.
"""
from __future__ import annotations

import re
import subprocess
import sys
from pathlib import Path

SIZES = ("w", "l", "nf", "area", "perim")
SCALE = {"a": 1e-18, "f": 1e-15, "p": 1e-12, "n": 1e-9, "u": 1e-6, "m": 1e-3,
         "k": 1e3, "meg": 1e6, "g": 1e9, "t": 1e12}


ARRAY = re.compile(r"\[(\d+)\]")


def logical_lines(path: Path) -> list[str]:
    out: list[str] = []
    for raw in path.read_text(errors="replace").splitlines():
        # instance arrays drawn as one symbol (A[3:0]) netlist as XA[3], XA[2] ...; a netlist
        # written unit by unit names them XA3, XA2 ...: the same devices, so compare them as such
        raw = ARRAY.sub(r"\1", raw)
        if raw.startswith("+") and out:
            out[-1] += " " + raw[1:]
        else:
            out.append(raw)
    return out


def num(v: str):
    v = v.strip("'\"").lower()
    m = re.match(r"^([-+]?(?:\d+\.?\d*|\.\d+)(?:e[-+]?\d+)?)(meg|[afpnumkgt])?[a-z]*$", v)
    if not m:
        return v
    return round(float(m.group(1)) * SCALE.get(m.group(2) or "", 1.0), 15)


def parse(path: Path) -> dict:
    subs, cur = {}, None
    for line in logical_lines(path):
        line = re.sub(r"\w+\s*=\s*expr\('[^']*'\)", "", line)          # xschem area formulas
        line = re.sub(r"""\w+\s*=\s*("[^"]*"|'[^']*')""", "", line)   # quoted formulas
        t = line.split()
        if not t or t[0].startswith("*") or t[0].startswith("$"):
            continue
        k = t[0].lower()
        if k == ".subckt":
            cur = t[1].upper()
            ports = [x.upper() for x in t[2:] if "=" not in x and x.lower() != "params:"]
            subs[cur] = {"ports": ports, "inst": {}}
            continue
        if k.startswith(".ends"):
            cur = None
            continue
        if cur is None or k.startswith("."):
            continue
        name = t[0].upper()
        pos = [x for x in t[1:] if "=" not in x]
        kv = {}
        for x in t[1:]:
            if "=" in x:
                a, b = x.split("=", 1)
                kv[a.lower()] = b
        kind = name[0]
        if kind in "XMD":
            nets, model = pos[:-1], pos[-1].lower()
        else:
            nets, model = pos[:2], str(num(" ".join(pos[2:]))) if len(pos) == 3 else " ".join(pos[2:]).lower()
        p = {}
        for a in SIZES:
            if a in kv:
                p[a] = num(kv[a])
        if "pj" in kv:
            p["perim"] = num(kv["pj"])
        p["m"] = num(kv.get("mult", kv.get("m", "1")))
        if kind == "D":
            name = "X" + name          # the sky130 diode symbol writes X<name> (PDK convention)
        subs[cur]["inst"][name] = ([n.upper() for n in nets], model, p)
    return subs


def compare(ref: dict, got: dict) -> list[str]:
    out = []
    if ref["ports"] != got["ports"]:
        out.append(f"ports: source {' '.join(ref['ports'])}")
        out.append(f"       schematic {' '.join(got['ports'])}")
    for n in sorted(set(ref["inst"]) | set(got["inst"])):
        a, b = ref["inst"].get(n), got["inst"].get(n)
        if a is None:
            out.append(f"{n}: only in the schematic: {b[1]} {' '.join(b[0])}")
            continue
        if b is None:
            out.append(f"{n}: missing in the schematic (source: {a[1]} {' '.join(a[0])})")
            continue
        if a[0] != b[0]:
            out.append(f"{n}: terminals source {' '.join(a[0])}  schematic {' '.join(b[0])}")
        if a[1] != b[1]:
            out.append(f"{n}: model source {a[1]}  schematic {b[1]}")
        for key in set(a[2]) | set(b[2]):
            if key in SIZES and key not in a[2]:
                continue                      # left to the symbol default (e.g. nf=1)
            if a[2].get(key, 1.0) != b[2].get(key, 1.0):
                out.append(f"{n}: {key} source {a[2].get(key)}  schematic {b[2].get(key)}")
    return out


def main() -> int:
    if len(sys.argv) < 2:
        print(__doc__)
        return 2
    src = Path(sys.argv[1])
    ref = parse(src)
    want = [s.upper() for s in sys.argv[2:]] or list(ref)
    cells = {p.name.upper(): p.name for p in Path("cells").iterdir() if p.is_dir()}
    bad = checked = 0
    for name in want:
        if name not in ref:
            print(f"import-check: {name}: no .subckt {name} in {src}")
            bad += 1
            continue
        cell = cells.get(name)
        if not cell or not (Path("cells") / cell / "schematic" / f"{cell}.sch").is_file():
            continue
        r = subprocess.run(["bash", "flow/stages/netlist.sh", cell, "lvs"], capture_output=True, text=True)
        net = Path("cells") / cell / "netlist" / f"{cell}.spice"
        if r.returncode != 0 or not net.is_file():
            print(f"import-check: {cell}: FAIL - xschem could not netlist the schematic "
                  f"(see cells/{cell}/reports/logs/netlist_lvs.log)")
            bad += 1
            continue
        got = parse(net).get(name)
        diffs = compare(ref[name], got) if got else [f"netlist has no .subckt {cell}"]
        checked += 1
        if diffs:
            bad += 1
            print(f"import-check: {cell}: FAIL - the schematic differs from {src.name}:")
            for d in diffs:
                print(f"    {d}")
        else:
            print(f"import-check: {cell}: PASS ({len(ref[name]['inst'])} devices, "
                  f"{len(ref[name]['ports'])} ports, same as {src.name})")
    if not checked and not bad:
        print("import-check: no imported schematic to check")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
