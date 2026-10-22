#!/usr/bin/env bash
# Netlist one testbench schematic of a cell (xschem, batch) - the same way the flow's netlist stage
# does, but for any tb_*.sch, not only tb_<CELL>.sch.
#
#   flow/lib/tb_netlist.sh <CELL> <TB>     e.g.  flow/lib/tb_netlist.sh ELAD1_ANALOG_CORE tb_top_mirror
#
# Result: cells/<CELL>/netlist/<TB>.spice  (hierarchy expanded; model corner from the CORNER symbol).
# The cell's own netlist stage is run first when its netlist is missing.
set -euo pipefail
ROOT=$(cd "$(dirname "$(readlink -f "$0")")/../.." && pwd)
cd "$ROOT"
cell=${1:?usage: tb_netlist.sh <CELL> <TB>}; tb=${2:?usage: tb_netlist.sh <CELL> <TB>}
sch="cells/$cell/schematic/$tb.sch"
[[ -f $sch ]] || { echo "tb_netlist: $sch not found" >&2; exit 1; }
command -v xschem >/dev/null || { echo "tb_netlist: xschem not found (run this in the EDA box)" >&2; exit 1; }
mkdir -p "cells/$cell/netlist"
work=$(mktemp -d "cells/$cell/netlist/.work.XXXXXX")
trap 'rm -rf "$work"' EXIT
mkdir -p "$work/home"
log="$work/xschem.log"
HOME="$work/home" FLOW_NETLIST_MODE=tb timeout 300 xschem --rcfile "$ROOT/flow/xschemrc" -q -x -n -s \
    -o "$work" -N "$tb.spice" "$sch" >"$log" 2>&1 || true
[[ -s $work/$tb.spice ]] || { echo "tb_netlist: xschem produced no netlist for $sch:" >&2; tail -20 "$log" >&2; exit 1; }
mv -f "$work/$tb.spice" "cells/$cell/netlist/$tb.spice"
