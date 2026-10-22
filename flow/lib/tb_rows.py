#!/usr/bin/env python3
"""Check the result rows of a testbench run against its limits file.

    python3 flow/lib/tb_rows.py <ngspice.log> <specs file> [--csv <rows.csv>]

Result rows are lines the testbench prints with `echo`:

    ROW <tag> key=value key=value ...          e.g.  ROW mirror var=1 kelvin=1 iref=2e-6 err_pct=-0.00079

A row whose value is empty (ngspice could not compute it, e.g. a failed operating point) fails
every limit that reads it.

Limits file, one limit per line ('#' starts a comment, SI suffixes allowed: f p n u m k meg g):

    <tag> <key> <min|-> <max|-> [filter key=value ...]
    mirror  err_pct  -0.01  0.01  kelvin=1     # every mirror row with kelvin=1
    noise   vdd_pp   -      30m                # every noise row

A limit that matches no row fails (a renamed key or a missing loop is not silently skipped).
Exit status: 0 all limits met, 1 a limit violated or unmatched, 2 usage error / no rows at all.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

SI = {"f": 1e-15, "p": 1e-12, "n": 1e-9, "u": 1e-6, "m": 1e-3, "k": 1e3, "meg": 1e6, "g": 1e9}


def num(text: str) -> float | None:
    m = re.fullmatch(r"([-+]?(?:\d+\.?\d*|\.\d+)(?:[eE][-+]?\d+)?)(meg|[fpnumkg])?", text.strip(), re.I)
    if not m:
        return None
    return float(m.group(1)) * SI.get((m.group(2) or "").lower(), 1.0)


def read_rows(log: Path) -> list[tuple[str, dict[str, str]]]:
    rows = []
    for line in log.read_text(errors="replace").splitlines():
        t = line.split()
        if len(t) >= 2 and t[0] == "ROW":
            kv = {}
            for tok in t[2:]:
                if "=" in tok:
                    k, v = tok.split("=", 1)
                    kv[k.lower()] = v
            rows.append((t[1].lower(), kv))
    return rows


def read_limits(path: Path):
    lims = []
    for n, raw in enumerate(path.read_text().splitlines(), 1):
        line = raw.split("#", 1)[0].strip()
        if not line:
            continue
        t = line.split()
        if len(t) < 4:
            raise ValueError(f"{path}:{n}: need '<tag> <key> <min|-> <max|-> [filters]': {raw}")
        lo = None if t[2] == "-" else num(t[2])
        hi = None if t[3] == "-" else num(t[3])
        if (t[2] != "-" and lo is None) or (t[3] != "-" and hi is None):
            raise ValueError(f"{path}:{n}: bad number: {raw}")
        filt = {}
        for f in t[4:]:
            if "=" not in f:
                raise ValueError(f"{path}:{n}: filter must be key=value: {f}")
            k, v = f.split("=", 1)
            filt[k.lower()] = v
        lims.append((t[0].lower(), t[1].lower(), lo, hi, filt, raw.strip()))
    return lims


def same(a: str, b: str) -> bool:
    x, y = num(a), num(b)
    return x == y if x is not None and y is not None else a.lower() == b.lower()


def fmt(x: float | None) -> str:
    return "-" if x is None else f"{x:.4g}"


def main(argv: list[str]) -> int:
    if len(argv) < 2:
        print(__doc__)
        return 2
    log, specs = Path(argv[0]), Path(argv[1])
    csv = Path(argv[argv.index("--csv") + 1]) if "--csv" in argv else None
    rows = read_rows(log)
    if csv:
        with csv.open("w") as f:
            for tag, kv in rows:
                f.write(tag + "," + ",".join(f"{k}={v}" for k, v in kv.items()) + "\n")
    if not rows:
        print("tb_rows: the run printed no ROW lines (see the ngspice log)")
        return 2
    if not specs.is_file():
        print(f"tb_rows: {len(rows)} result row(s), no limits file {specs} - nothing checked")
        return 0
    bad = 0
    for tag, key, lo, hi, filt, raw in read_limits(specs):
        sel = [kv for t, kv in rows if t == tag and all(k in kv and same(kv[k], v) for k, v in filt.items())]
        if not sel:
            print(f"  FAIL  {raw}   <- no matching row")
            bad += 1
            continue
        vals = [num(kv.get(key, "")) for kv in sel]
        missing = sum(v is None for v in vals)
        got = [v for v in vals if v is not None]
        out = [v for v in got if (lo is not None and v < lo) or (hi is not None and v > hi)]
        ok = not missing and not out
        bad += not ok
        rng = f"{fmt(min(got)) if got else '-'} .. {fmt(max(got)) if got else '-'}"
        why = "" if ok else (f"  <- {missing} row(s) without a value" if missing else f"  <- {len(out)} row(s) outside")
        filt_s = " ".join(f"{k}={v}" for k, v in filt.items())
        print(f"  {'PASS' if ok else 'FAIL'}  {tag:<10} {key:<12} [{fmt(lo)}, {fmt(hi)}]  {len(sel):>2} row(s): "
              f"{rng} {filt_s}{why}")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
