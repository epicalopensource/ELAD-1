#!/usr/bin/env bash
# Interactive ngspice on a cell's testbench, with the waveforms opened in plot windows.
#
#   flow/view.sh <CELL>         e.g.  flow/view.sh ELAD1_INV      (the ELAD1_ prefix is optional)
#   flow/view.sh --list         the cells that have a testbench
#
# What it does: re-netlists the schematic + testbench (xschem, batch), copies the testbench into a
# private work dir with the PDK's ngspice settings (spinit), adds `plot` commands after the
# analyses, and starts ngspice WITHOUT -b. The testbench's own .control block runs first (the
# measurements print in the terminal), the plot windows open, and you are left at the
# `ngspice N ->` prompt to type your own commands (plot, print, setplot, display, quit).
# The .raw waveform file is written to /tmp/view_<CELL>/ (nothing is added to the repository).
#
# Needs a display: run it in the EDA box desktop's terminal, or `export DISPLAY=:1` first.
set -euo pipefail
ROOT=$(cd "$(dirname "$(readlink -f "$0")")/.." && pwd)
cd "$ROOT"

if [[ ${1:-} == --list || $# -ne 1 ]]; then
  echo "usage: flow/view.sh <CELL>   (cells with a testbench:)"
  for d in cells/*/schematic/tb_*.sch; do b=$(basename "$d" .sch); echo "  ${b#tb_}"; done
  exit 2
fi

c=${1^^}
[[ -d cells/$c ]] || c=ELAD1_$c
[[ -f cells/$c/schematic/tb_$c.sch ]] || { echo "view: no testbench cells/$c/schematic/tb_$c.sch"; exit 1; }
: "${PDK_ROOT:?PDK_ROOT is not set - run this in the EDA box}" "${PDK:?PDK is not set}"
init="$PDK_ROOT/$PDK/libs.tech/ngspice/spinit"
[[ -f $init ]] || { echo "view: $init not found"; exit 1; }
if [[ -z ${DISPLAY:-} ]]; then
  echo "view: DISPLAY is not set - the plot windows need the desktop (try: export DISPLAY=:1)"; exit 1
fi

echo "view: netlisting $c ..."
bash flow/stages/netlist.sh "$c" lvs >/dev/null || { echo "view: netlisting the cell failed (cells/$c/reports/logs)"; exit 1; }
bash flow/stages/netlist.sh "$c" tb  >/dev/null || { echo "view: netlisting the testbench failed (cells/$c/reports/logs)"; exit 1; }
net="cells/$c/netlist/tb_$c.spice"

work=/tmp/view_$c
rm -rf "$work"; mkdir -p "$work"
cp "$init" "$work/.spiceinit"
deck="$ROOT/cells/$c/netlist/.view_tb_$c.spice"      # next to the netlist: relative .include paths stay valid
trap 'rm -f "$deck"' EXIT

python3 - "$net" "$deck" "$c" <<'PY'
import sys, re
src, dst, cell = sys.argv[1:4]
# cell -> {analysis keyword: [(occurrence number, [plot commands after that analysis])]} and
# 'end': commands appended before .endc
PLOTS = {
 "ELAD1_AGGRESSOR": {"tran": [(1, ["plot v(agg_clk)", "plot -i(VSUP)", "plot v(VDPWR)"])]},
 "ELAD1_INV": {"tran": [(1, ["plot v(A) v(Y)"])], "dc": [(1, ["plot v(Y) v(A)"])]},
 "ELAD1_HEATER": {"dc": [(1, ["plot -i(VEXT)", "plot v(HIN)"])]},
 "ELAD1_MIRROR_GROUPED": {"dc": [(1, ["plot -i(VOUT)", "plot v(REF)"])]},
 "ELAD1_MIRROR_CC": {"dc": [(1, ["plot -i(VOUT)", "plot v(REF)"])]},
 "ELAD1_NUNIT": {"dc": [(1, ["plot v(D)"])]},
 "ELAD1_PAIR_GROUPED": {"dc": [(1, ["plot -i(VD1) -i(VD2)", "plot -i(VD1)+i(VD2)"])]},
 "ELAD1_PAIR_CC": {"dc": [(1, ["plot -i(VD1) -i(VD2)", "plot -i(VD1)+i(VD2)"])]},
 "ELAD1_PINPROT": {"dc": [(1, ["plot v(CORE) v(PAD)", "plot abs(i(VPAD))+1e-15 ylog"])]},
 "ELAD1_TGA": {"dc": [(1, ["plot v(A) v(B)", "plot abs((v(A)-v(B))/1e-6)+1e-3 ylog"])]},
 "ELAD1_TGB": {"dc": [(1, ["plot v(A) v(B)", "plot abs((v(A)-v(B))/1e-6)+1e-3 ylog"])]},
 "ELAD1_TSW": {"dc": [(1, ["plot v(A) v(B)", "plot abs((v(A)-v(B))/1e-6)+1e-3 ylog"])]},
 "ELAD1_VICTIM_BASELINE": {"ac": [(1, ["plot db(v(OUT))", "plot phase(v(OUT))"])],
                           "dc": [(1, ["plot v(OUT) v(VQUIET)"])]},
 "ELAD1_VICTIM_GUARDED": {"ac": [(1, ["plot db(v(OUT))", "plot phase(v(OUT))"])],
                          "dc": [(1, ["plot v(OUT) v(VQUIET)"])]},
 # operating-point benches: nothing to draw, so one extra sweep is added for the viewer only
 "ELAD1_CLAMP": {"end": ["dc VCLR 0 1.8 0.01", "plot v(NODE)"]},
}
lines = open(src).read().split("\n")
out, inctl, seen = [], False, {}
plan = PLOTS.get(cell, {})
for ln in lines:
    low = ln.strip().lower()
    if low == ".endc":
        out += plan.get("end", [])
        inctl = False
    out.append(ln)
    if low == ".control":
        inctl = True
    elif inctl:
        w = low.split()[0] if low.split() else ""
        if w in plan and w != "end":
            seen[w] = seen.get(w, 0) + 1
            for n, cmds in plan[w]:
                if n == seen[w]:
                    out += cmds
open(dst, "w").write("\n".join(out))
PY

if [[ $c == ELAD1_NDUMMY || $c == ELAD1_ANALOG_SELECTOR || $c == ELAD1_ANALOG_CORE ]]; then
  echo "view: $c is a DC operating-point bench: there is no waveform to draw."
  echo "      At the prompt use:  print all   |   print v(NODE)   |   display"
fi
echo "view: starting ngspice (type 'quit' to leave; plot windows close with it)"
cd "$work"
ngspice "$deck"
echo "view: waveform file(s) in $work"
