#!/usr/bin/env bash
# Stage: xschem schematic -> SPICE netlist (batch, no X server).
#   lvs : cells/<c>/schematic/<c>.sch     -> cells/<c>/netlist/<c>.spice     (.subckt <c>, for LVS + PEX)
#   tb  : cells/<c>/schematic/tb_<c>.sch  -> cells/<c>/netlist/tb_<c>.spice  (testbench, for ngspice)
#
# Content-aware publication: the netlist file is replaced ONLY if it changed semantically
# (xschem '**' comment headers ignored). A cosmetic schematic edit (moving a wire, a text
# note) therefore re-runs this ~1 s step but does not invalidate LVS/PEX/simulation.
# shellcheck source=../lib/common.sh
source "$(dirname "$(readlink -f "$0")")/../lib/common.sh"

mode=${2:-}
case $mode in lvs|tb) ;; *) echo "usage: netlist.sh <cell> lvs|tb" >&2; exit 2 ;; esac
stage_init "$1" "netlist_$mode"
need xschem

if [[ $mode == lvs ]]; then
  sch="$CELL_DIR/schematic/$CELL.sch";    out="$CELL_DIR/netlist/$CELL.spice"
else
  sch="$CELL_DIR/schematic/tb_$CELL.sch"; out="$CELL_DIR/netlist/tb_$CELL.spice"
fi
[[ -f $sch ]] || die "missing schematic $sch"

mkdir -p "$CELL_DIR/netlist"
work=$(mktemp -d "$CELL_DIR/netlist/.work.XXXXXX")
trap 'rm -rf "$work"' EXIT
name=$(basename "$out")

# FLOW_NETLIST_MODE is read by flow/xschemrc (sets lvs_netlist / top_subckt before netlisting).
# Private HOME per xschem run: xschem creates ~/.xschem on first start. In a fresh container
# (CI, flow/docker.sh) the LVS and testbench netlists start in parallel and race to create it;
# a private HOME removes the race and keeps personal ~/.xschem settings out of batch results.
mkdir -p "$work/home"
if ! HOME="$work/home" FLOW_NETLIST_MODE=$mode run_tool "$NETLIST_TIMEOUT" "$STAGE_LOG" \
     xschem --rcfile "$FLOW_ROOT/flow/xschemrc" -q -x -n -s -o "$work" -N "$name" "$sch"; then
  die "xschem netlisting failed (see log)"
fi
gen="$work/$name"
[[ -s $gen ]] || die "xschem produced no netlist — check symbol paths / XSCHEM_LIBRARY_PATH (see log)"

if [[ $mode == lvs ]]; then
  grep -qiE "^\.subckt[[:space:]]+$CELL([[:space:]]|\$)" "$gen" \
    || die "netlist has no '.subckt $CELL' — top schematic must be a subcircuit (ipin/opin/iopin) and lvs mode must be honoured"
fi

# xschem rarely fails hard on a broken schematic; surface its complaints in the status.
nwarn=$(grep -ciE 'error|not found|missing|unable' "$STAGE_LOG" || true)
suffix=""; if (( nwarn > 0 )); then suffix=", $nwarn suspicious log line(s) — review log"; fi

norm() { grep -v '^\*\*' "$1" || true; }
if [[ -f $out ]] && cmp -s <(norm "$gen") <(norm "$out"); then
  pass "netlist semantically unchanged; downstream not invalidated$suffix"
fi
mv -f "$gen" "$out"
ninst=$(grep -ciE '^x' "$out" || true)
pass "netlist updated ($ninst X-instances)$suffix"
