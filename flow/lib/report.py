#!/usr/bin/env python3
"""Aggregate stage status records into per-cell and project summaries.

usage: report.py [cell ...]          (default: every cell under cells/)
Writes cells/<c>/reports/summary.{md,json} and reports/summary.md; exits 1 if any applicable
stage is not PASS.

Status semantics
  PASS / FAIL  as written by the stage
  SKIPPED      stage not applicable (its source does not exist yet, or disabled)
  NOT_RUN      applicable but no record (upstream failed under make -k, or STRICT_GATE)
  STALE        a record exists but an input is newer than it — the record describes an
               OLD design state.
  BLOCKED      a record exists but an upstream stage is not PASS, so this stage was not
               re-run and its record (and outputs) belong to an older design state.
  Without STALE/BLOCKED, a stage skipped because its upstream failed would keep showing
  an old PASS — a false sign-off.
"""
import json
import os
import re
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def conf(key, default):
    if key in os.environ:
        return os.environ[key]
    m = re.search(rf"^\s*{key}\s*\?=\s*(.*?)\s*$", (ROOT / "flow.conf").read_text(), re.M)
    return m.group(1) if m else default


# stage -> (inputs relative to the cell dir; "{c}" = cell name)
STAGES = [
    ("netlist_lvs", ["schematic/{c}.sch"]),
    ("netlist_tb",  ["schematic/tb_{c}.sch"]),
    ("sim",         ["netlist/tb_{c}.spice", "sim/specs.txt"]),
    ("drc",         ["layout/{c}.gds"]),
    ("lvs",         ["layout/{c}.gds", "netlist/{c}.spice"]),
    ("pex",         ["layout/{c}.gds", "netlist/{c}.spice"]),
    ("postsim",     ["pex/{c}_pex.spice", "netlist/tb_{c}.spice", "sim/specs.txt"]),
]


# stage -> upstream stages whose PASS this stage's record presupposes
UPSTREAM = {
    "sim": ["netlist_tb"],
    "lvs": ["netlist_lvs"],
    "pex": ["netlist_lvs"],
    "postsim": ["pex", "netlist_tb"],
}


def applicable(stage, d, c):
    sch = (d / f"schematic/{c}.sch").exists()
    tb = (d / f"schematic/tb_{c}.sch").exists()
    gds = (d / f"layout/{c}.gds").exists()
    rules = {
        "netlist_lvs": (sch, "no schematic"),
        "netlist_tb":  (tb, "no testbench"),
        "sim":         (tb, "no testbench"),
        "drc":         (gds, "no layout"),
        "lvs":         (gds and sch, "needs layout + schematic"),
        "pex":         (gds and sch, "needs layout + schematic"),
        "postsim":     (gds and sch and tb and conf("POSTSIM", "1") == "1",
                        "needs layout + schematic + testbench (and POSTSIM=1)"),
    }
    return rules[stage]


def cell_report(c):
    d = ROOT / "cells" / c
    rows, ok, status_of = [], True, {}
    upstream = dict(UPSTREAM)
    if conf("STRICT_GATE", "1") == "1":
        upstream["pex"] = ["netlist_lvs", "lvs"]
    for stage, inputs in STAGES:
        appl, why = applicable(stage, d, c)
        rec_path = d / "reports" / f"{stage}.json"
        if not appl:
            rows.append({"stage": stage, "status": "SKIPPED", "message": why})
            status_of[stage] = "SKIPPED"
            continue
        if not rec_path.exists():
            rows.append({"stage": stage, "status": "NOT_RUN", "message": "upstream failed or gated"})
            status_of[stage] = "NOT_RUN"
            ok = False
            continue
        rec = json.loads(rec_path.read_text())
        t_rec = rec_path.stat().st_mtime
        newer = [i.format(c=c) for i in inputs
                 if (d / i.format(c=c)).exists() and (d / i.format(c=c)).stat().st_mtime > t_rec]
        status = rec.get("status", "FAIL")
        msg = rec.get("message", "")
        blocked = [u for u in upstream.get(stage, []) if status_of.get(u, "PASS") not in ("PASS", "SKIPPED")]
        if newer:
            status, msg = "STALE", f"inputs changed since last run ({', '.join(newer)}); was {rec.get('status')}: {msg}"
        elif blocked:
            status, msg = "BLOCKED", f"upstream {', '.join(blocked)} not PASS; last record ({rec.get('status')}) is outdated"
        if status != "PASS":
            ok = False
        status_of[stage] = status
        rows.append({"stage": stage, "status": status, "message": msg,
                     "duration_s": rec.get("duration_s"), "log": rec.get("log")})
    summary = {"cell": c, "pass": ok, "generated": time.strftime("%Y-%m-%dT%H:%M:%S%z"), "stages": rows}
    (d / "reports").mkdir(parents=True, exist_ok=True)
    (d / "reports" / "summary.json").write_text(json.dumps(summary, indent=2) + "\n")
    md = [f"## `{c}` — {'PASS' if ok else 'FAIL'}", "", "| stage | status | time | detail |", "|---|---|---|---|"]
    for r in rows:
        t = f"{r['duration_s']}s" if r.get("duration_s") is not None else ""
        md.append(f"| {r['stage']} | {r['status']} | {t} | {r['message'].replace('|', '/')} |")
    (d / "reports" / "summary.md").write_text("\n".join(md) + "\n")
    return ok, md


def main():
    cells = sys.argv[1:] or sorted(p.name for p in (ROOT / "cells").iterdir()
                                   if p.is_dir() and not p.name.startswith("_"))
    all_ok, out = True, [f"# Flow report — PDK {conf('PDK', '?')} — {time.strftime('%Y-%m-%d %H:%M')}", ""]
    for c in cells:
        if not (ROOT / "cells" / c).is_dir():
            print(f"report: unknown cell {c}", file=sys.stderr)
            all_ok = False
            continue
        ok, md = cell_report(c)
        all_ok &= ok
        out += md + [""]
    (ROOT / "reports").mkdir(exist_ok=True)
    (ROOT / "reports" / "summary.md").write_text("\n".join(out))
    print("\n".join(out))
    print("OVERALL:", "PASS" if all_ok else "FAIL")
    return 0 if all_ok else 1


if __name__ == "__main__":
    sys.exit(main())
