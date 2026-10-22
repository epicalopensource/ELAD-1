#!/usr/bin/env bash
# Interactive ngspice on a testbench, with the waveforms opened in plot windows.
#
#   flow/view.sh <CELL>              the cell's main testbench tb_<CELL>.sch   e.g. flow/view.sh ELAD1_INV
#   flow/view.sh <CELL> <TB>         another testbench of the cell, e.g. flow/view.sh ELAD1_ANALOG_CORE tb_top_noise
#   flow/view.sh --list              every testbench
# (the ELAD1_ prefix of the cell and the tb_ prefix of the testbench are optional)
#
# What it does: netlists the testbench (xschem, batch), copies it into a private work dir with the
# PDK's ngspice settings (spinit), adds `plot` commands after the analyses, and starts ngspice
# WITHOUT -b. The testbench's own .control block runs first (measurements and result rows print
# in the terminal), the plot windows open, and you are left at the `ngspice N ->` prompt to type
# your own commands (plot, print, setplot, display, quit). Files the testbench writes (.raw,
# wrdata) go to /tmp/view_<CELL>_<TB>/ - nothing is added to the repository.
#
# Needs a display: run it in the EDA box desktop's terminal, or `export DISPLAY=:1` first.
set -euo pipefail
ROOT=$(cd "$(dirname "$(readlink -f "$0")")/.." && pwd)
cd "$ROOT"

if [[ ${1:-} == --list || $# -lt 1 || $# -gt 2 ]]; then
  echo "usage: flow/view.sh <CELL> [<TB>]   testbenches:"
  for d in cells/*/schematic/tb_*.sch; do
    cell=$(basename "$(dirname "$(dirname "$d")")"); tb=$(basename "$d" .sch)
    if [[ $tb == "tb_$cell" ]]; then echo "  $cell"; else echo "  $cell $tb"; fi
  done
  exit 2
fi

c=${1^^}
[[ -d cells/$c ]] || c=ELAD1_$c
[[ -d cells/$c ]] || { echo "view: no cell cells/$1 or cells/$c"; exit 1; }
tb=${2:-tb_$c}
[[ $tb == tb_* ]] || tb=tb_$tb
[[ -f cells/$c/schematic/$tb.sch ]] || { echo "view: no testbench cells/$c/schematic/$tb.sch (see: flow/view.sh --list)"; exit 1; }
: "${PDK_ROOT:?PDK_ROOT is not set - run this in the EDA box}" "${PDK:?PDK is not set}"
init="$PDK_ROOT/$PDK/libs.tech/ngspice/spinit"
[[ -f $init ]] || { echo "view: $init not found"; exit 1; }
if [[ -z ${DISPLAY:-} ]]; then
  echo "view: DISPLAY is not set - the plot windows need the desktop (try: export DISPLAY=:1)"; exit 1
fi

echo "view: netlisting $c / $tb ..."
if [[ $tb == "tb_$c" ]]; then           # the flow's own testbench: use the flow's netlist stages
  bash flow/stages/netlist.sh "$c" lvs >/dev/null || { echo "view: netlisting the cell failed (cells/$c/reports/logs)"; exit 1; }
  bash flow/stages/netlist.sh "$c" tb  >/dev/null || { echo "view: netlisting the testbench failed (cells/$c/reports/logs)"; exit 1; }
else
  bash flow/lib/tb_netlist.sh "$c" "$tb" || { echo "view: netlisting $tb failed"; exit 1; }
fi
net="cells/$c/netlist/$tb.spice"

work=/tmp/view_${c}_$tb
rm -rf "$work"; mkdir -p "$work"
cp "$init" "$work/.spiceinit"
deck="$ROOT/cells/$c/netlist/.view_$tb.spice"      # next to the netlist: relative .include paths stay valid
trap 'rm -f "$deck"' EXIT

python3 - "$net" "$deck" "$tb" <<'PY'
import sys
src, dst, tb = sys.argv[1:4]
# testbench -> {analysis command: [(occurrence number, [plot commands after it])]};
# 'end': commands appended before .endc
PLOTS = {
 "tb_ELAD1_AGGRESSOR": {"tran": [(1, ["plot v(agg_clk)", "plot -i(VSUP)", "plot v(VDPWR)"])]},
 "tb_ELAD1_INV": {"tran": [(1, ["plot v(A) v(Y)"])], "dc": [(1, ["plot v(Y) v(A)"])]},
 "tb_ELAD1_HEATER": {"dc": [(1, ["plot -i(VEXT)", "plot v(HIN)"])]},
 "tb_ELAD1_MIRROR_GROUPED": {"dc": [(1, ["plot -i(VOUT)", "plot v(REF)"])]},
 "tb_ELAD1_MIRROR_CC": {"dc": [(1, ["plot -i(VOUT)", "plot v(REF)"])]},
 "tb_ELAD1_NUNIT": {"dc": [(1, ["plot v(D)"])]},
 "tb_ELAD1_PAIR_GROUPED": {"dc": [(1, ["plot -i(VD1) -i(VD2)", "plot -i(VD1)+i(VD2)"])]},
 "tb_ELAD1_PAIR_CC": {"dc": [(1, ["plot -i(VD1) -i(VD2)", "plot -i(VD1)+i(VD2)"])]},
 "tb_ELAD1_PINPROT": {"dc": [(1, ["plot v(CORE) v(PAD)", "plot abs(i(VPAD))+1e-15 ylog"])]},
 "tb_ELAD1_TGA": {"dc": [(1, ["plot v(A) v(B)", "plot abs((v(A)-v(B))/1e-6)+1e-3 ylog"])]},
 "tb_ELAD1_TGB": {"dc": [(1, ["plot v(A) v(B)", "plot abs((v(A)-v(B))/1e-6)+1e-3 ylog"])]},
 "tb_ELAD1_TSW": {"dc": [(1, ["plot v(A) v(B)", "plot abs((v(A)-v(B))/1e-6)+1e-3 ylog"])]},
 "tb_ELAD1_VICTIM_BASELINE": {"ac": [(1, ["plot db(v(OUT))", "plot phase(v(OUT))"])],
                              "dc": [(1, ["plot v(OUT) v(VQUIET)"])]},
 "tb_ELAD1_VICTIM_GUARDED": {"ac": [(1, ["plot db(v(OUT))", "plot phase(v(OUT))"])],
                             "dc": [(1, ["plot v(OUT) v(VQUIET)"])]},
 # operating-point bench: nothing to draw, so one extra sweep is added for the viewer only
 "tb_ELAD1_CLAMP": {"end": ["dc VCLR 0 1.8 0.01", "plot v(NODE)"]},
 # top-level tests of ELAD1_ANALOG_CORE (tran started by 'run')
 "tb_top_noise": {"run": [(1, ["plot v(P3) v(P4)", "plot v(P3)-v(P4)", "plot v(VDPWR)", "plot v(AGG_CLK)"])]},
 "tb_top_transition": {"run": [(1, ["plot v(P0) v(P3) v(P2)", "plot i(VM4)",
                                    "plot v(xcore.ref_g) v(xcore.ref_c)", "plot v(EN_MG) v(EN_MC)"])]},
}
lines = open(src).read().split("\n")
out, inctl, seen = [], False, {}
plan = PLOTS.get(tb, {})
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

case $tb in
  tb_ELAD1_NDUMMY|tb_ELAD1_ANALOG_SELECTOR|tb_ELAD1_ANALOG_CORE|tb_top_mirror|tb_top_pair)
    echo "view: $tb is made of DC operating points: its results are the lines printed below"
    echo "      (ROW ... / name = value), there is no waveform to draw. At the prompt: print all | display" ;;
esac
echo "view: starting ngspice (type 'quit' to leave; plot windows close with it)"
cd "$work"
ngspice "$deck"
echo "view: files written by the testbench are in $work"
