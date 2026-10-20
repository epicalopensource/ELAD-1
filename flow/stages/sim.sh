#!/usr/bin/env bash
# Stage: ngspice batch simulation.
#   pre  : schematic testbench                       -> cells/<c>/sim/results/
#   post : same testbench, DUT .subckt replaced by    -> cells/<c>/sim/postlayout/
#          the PEX netlist (post-layout simulation)
#
# Testbench contract: write outputs RELATIVE to the working directory (e.g. `write tb.raw`
# inside .control); ngspice runs inside a private work dir that is published atomically.
# Optional pass/fail: cells/<c>/sim/specs.txt   (lines: <meas_name> <min|-> <max|->)
# shellcheck source=../lib/common.sh
source "$(dirname "$(readlink -f "$0")")/../lib/common.sh"

mode=${2:-pre}
case $mode in
  pre)  stage=sim ;;
  post) stage=postsim ;;
  *) echo "usage: sim.sh <cell> pre|post" >&2; exit 2 ;;
esac
stage_init "$1" "$stage"
need ngspice

tbnet="$CELL_DIR/netlist/tb_$CELL.spice"
specs="$CELL_DIR/sim/specs.txt"
[[ -f $tbnet ]] || die "missing testbench netlist $tbnet"

mkdir -p "$CELL_DIR/sim"
work=$(mktemp -d "$CELL_DIR/sim/.work.XXXXXX")
trap 'rm -rf "$work"' EXIT

# PDK simulator settings (e.g. sky130 needs ngbehavior=hsa) — ngspice reads ./.spiceinit
if init=$(pdk_ngspice_init); then cp "$init" "$work/.spiceinit"; fi

deck=$tbnet
dest="$CELL_DIR/sim/results"
if [[ $mode == post ]]; then
  pex="$CELL_DIR/pex/${CELL}_pex.spice"
  [[ -f $pex ]] || die "missing PEX netlist $pex"
  deck="$work/tb_${CELL}_post.spice"
  python3 "$LIB/spice_tools.py" swap-tb --tb "$tbnet" --cell "$CELL" --pex "$pex" --out "$deck" \
      >>"$STAGE_LOG" 2>&1 || die "could not substitute the PEX netlist into the testbench (see log)"
  dest="$CELL_DIR/sim/postlayout"
fi

# Netlist is read in place (keeps its relative .include paths valid); outputs land in $work.
rc=0
( cd "$work" && run_tool "$SIM_TIMEOUT" "$work/ngspice.log" ngspice -b "$deck" ) || rc=$?

errs=$(grep -nE '^[[:space:]]*(Error|ERROR)\b|[Ff]atal|aborted|Timestep too small|singular matrix|Circuit not parsed|could not find' \
       "$work/ngspice.log" | head -n 5 || true)

spec_args=(--log "$work/ngspice.log" --out "$work/measurements.json")
if [[ -f $specs ]]; then spec_args+=(--specs "$specs"); fi
spec_rc=0
python3 "$LIB/spice_tools.py" check-specs "${spec_args[@]}" >>"$STAGE_LOG" 2>&1 || spec_rc=$?

replace_dir "$work" "$dest"
trap - EXIT
details="$dest/measurements.json"

if (( rc == 124 || rc == 137 )); then die "simulation timed out after ${SIM_TIMEOUT}s" "$details"; fi
if [[ -n $errs ]]; then die "ngspice reported errors: $(head -n1 <<<"$errs")" "$details"; fi
if (( rc != 0 )); then die "ngspice exited with status $rc" "$details"; fi
case $spec_rc in
  0) pass "simulation ok$( [[ -f $specs ]] && echo ', all specs met' )" "$details" ;;
  1) die "simulation ran but specs violated (see measurements.json)" "$details" ;;
  *) die "spec checker error (exit $spec_rc, see log)" "$details" ;;
esac
