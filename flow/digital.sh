#!/usr/bin/env bash
# Digital part of ELAD-1: the configuration controller ELAD1_CONTROL (src/elad1_control.v).
#
#   flow/digital.sh sim       RTL simulation: test/tb_elad1_control.v (self-checking, 284 checks)
#                             and test/tb_latency.v (APPLY -> BUSY / ACTIVE latency); exit 0 = pass
#   flow/digital.sh wave      open the last waveform in GTKWave with the controller's signals laid out
#   flow/digital.sh smoke     LibreLane's own smoke test (checks the layout toolchain; once)
#   flow/digital.sh harden    LibreLane: Verilog -> placed and routed layout (GDS, LEF, netlists),
#                             settings in digital/elad1_control/config.json; views copied to final/
#   flow/digital.sh gl [NL]   the same 284-check testbench on a gate netlist (default: the hardened
#                             digital/elad1_control/final/nl/elad1_control.nl.v) with sky130 cell models
#
# src/project.v is NOT simulated: in an analog Tiny Tapeout project it is only the interface stub.
# Simulation output: test/sim_build/.  Layout runs: digital/elad1_control/runs/<tag>/ (not in git).
set -euo pipefail
ROOT=$(cd "$(dirname "$(readlink -f "$0")")/.." && pwd)
cd "$ROOT"
OUT=test/sim_build
RTL=(src/elad1_control.v src/elad1_digital_top.v)
LIMIT=${DIG_TIMEOUT:-120}      # seconds per testbench; a hung simulation (a wait() never met) fails
HARD=digital/elad1_control

need() { command -v "$1" >/dev/null || { echo "digital: $1 not found (run this in the EDA box)"; exit 2; }; }
need_pdk() { : "${PDK_ROOT:?PDK_ROOT is not set - run this in the EDA box}" "${PDK:?PDK is not set}"; }

# run_tb <name> <source files...>: compile + run the self-checking testbench, print PASS/FAIL
run_tb() {
  local name=$1; shift
  mkdir -p "$OUT"
  iverilog -g2012 "$@" -o "$OUT/$name" 2>"$OUT/$name.compile.log" \
    || { echo "FAIL  $name: does not compile"; grep -v timescale "$OUT/$name.compile.log" | head -20; return 1; }
  local rc=0
  ( cd "$OUT" && timeout "$LIMIT" vvp -n "$name" > "$name.log" 2>&1 ) || rc=$?
  local res; res=$(grep -E '^RESULT:' "$OUT/$name.log" || true)
  if (( rc == 124 )); then
    echo "FAIL  $name: did not finish within ${LIMIT}s (hung; last lines of its log:)"
    tail -5 "$OUT/$name.log" | sed 's/^/      /'; return 1
  elif [[ $res =~ RESULT:\ ([0-9]+)\ checks,\ 0\ errors ]] && (( BASH_REMATCH[1] > 0 )); then
    echo "PASS  $name: ${res#RESULT: }"
  else
    echo "FAIL  $name: ${res:-no RESULT line}"; { grep -E "^FAIL" "$OUT/$name.log" | head -20 || true; }; return 1
  fi
  grep -E '^  rate' "$OUT/$name.log" | sed 's/^ */      /' || true
}

sim() {
  need iverilog; need vvp
  local fail=0
  run_tb tb_elad1_control test/tb_elad1_control.v "${RTL[@]}" || fail=1
  [[ -f $OUT/tb_elad1_control.vcd ]] && cp "$OUT/tb_elad1_control.vcd" "$OUT/rtl.vcd"
  iverilog -g2012 -o "$OUT/tb_latency" test/tb_latency.v "${RTL[@]}" 2>"$OUT/tb_latency.compile.log" \
    || { echo "FAIL  tb_latency: does not compile"; exit 1; }
  ( cd "$OUT" && timeout "$LIMIT" vvp -n tb_latency > tb_latency.log 2>&1 ) || true
  local lat; lat=$(grep -E 'APPLY->BUSY' "$OUT/tb_latency.log" || true)
  if [[ -n $lat ]]; then echo "INFO  tb_latency: $lat"; else echo "FAIL  tb_latency: no result line"; fail=1; fi
  echo "      logs and waveforms: $OUT/"
  (( fail == 0 )) && echo "digital sim: PASS" || { echo "digital sim: FAIL"; exit 1; }
}

gl() {
  need iverilog; need vvp; need_pdk
  local nl=${1:-$HARD/final/nl/elad1_control.nl.v}
  [[ -f $nl ]] || { echo "digital: gate netlist $nl not found - run: flow/digital.sh harden"; exit 1; }
  local lib="$PDK_ROOT/$PDK/libs.ref/sky130_fd_sc_hd/verilog"
  [[ -f $lib/sky130_fd_sc_hd.v ]] || { echo "digital: sky130_fd_sc_hd Verilog models not found in $lib"; exit 1; }
  echo "gate-level: $nl"
  # FUNCTIONAL = logic-only cell models; UNIT_DELAY = 1 ns per cell, so ordering bugs still show
  if run_tb tb_gl -DFUNCTIONAL -DUNIT_DELAY=#1 test/tb_elad1_control.v src/elad1_digital_top.v "$nl" \
       "$lib/primitives.v" "$lib/sky130_fd_sc_hd.v"; then
    [[ -f $OUT/tb_elad1_control.vcd ]] && mv "$OUT/tb_elad1_control.vcd" "$OUT/gl.vcd"
    echo "digital gl: PASS  (waveform: $OUT/gl.vcd)"
  else
    echo "digital gl: FAIL"; exit 1
  fi
}

wave() {
  need gtkwave
  local vcd=$OUT/tb_elad1_control.vcd
  [[ -f $vcd ]] || vcd=$OUT/rtl.vcd
  [[ -f ${1:-} ]] && vcd=$1
  [[ -f $vcd ]] || { echo "digital: no waveform yet - run: flow/digital.sh sim"; exit 1; }
  [[ -n ${DISPLAY:-} ]] || { echo "digital: DISPLAY is not set (try: export DISPLAY=:1)"; exit 1; }
  gtkwave "$vcd" test/elad1_control.gtkw >/dev/null 2>&1 &
  echo "digital: GTKWave opened in the desktop ($vcd)"
}

smoke() {
  need librelane; need_pdk
  librelane --manual-pdk --pdk-root "$PDK_ROOT" --pdk "$PDK" --smoke-test
}

harden() {
  need librelane; need_pdk
  local tag=${RUN_TAG:-$(date +%Y%m%d_%H%M%S)}
  echo "harden: LibreLane run '$tag' (several minutes; full log under $HARD/runs/$tag/)"
  rm -rf "$HARD/final.new"
  if ( cd "$HARD" && librelane --manual-pdk --pdk-root "$PDK_ROOT" --pdk "$PDK" --run-tag "$tag" \
         --save-views-to final.new config.json ); then
    rm -rf "$HARD/final"; mv "$HARD/final.new" "$HARD/final"
    echo "harden: PASS - views in $HARD/final/ (gds/ lef/ nl/ pnl/ spice/ ...)"
    ls "$HARD/final" | sed 's/^/      /'
  else
    rm -rf "$HARD/final.new"
    echo "harden: FAIL - the error is printed above; step logs in $HARD/runs/$tag/"
    exit 1
  fi
}

case ${1:-} in
  sim) sim ;;
  wave) shift; wave "${1:-}" ;;
  gl) shift; gl "${1:-}" ;;
  smoke) smoke ;;
  harden) harden ;;
  *) sed -n '2,15p' "$0" | sed 's/^# \{0,1\}//'; exit 2 ;;
esac
