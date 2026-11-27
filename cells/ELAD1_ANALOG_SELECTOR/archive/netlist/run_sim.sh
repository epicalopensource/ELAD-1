#!/bin/bash
# usage: ./run_sim.sh <pre|postC|postRC> <netlist containing the subckt>
source ./env.sh >/dev/null
STAGE=$1; NET=$(readlink -f "$2"); OUT=results_dc/$STAGE
command -v ngspice >/dev/null || { echo "ngspice not found"; exit 1; }
[ -f "$NET" ] || { echo "netlist not found: $NET"; exit 1; }
if [ "$STAGE" != "pre" ]; then
  tied=$(awk '/^Vtie_/ {print $2}' $NET)
  bad=$(awk '/^X/ && /(pfet|nfet)/ {print $5}' $NET | sed -E 's/\.[nt][0-9]+$//' | sort -u | grep -v -x -F -f <(echo $PINS $tied | tr ' ' '\n'))
  if [ -n "$bad" ] && [ -z "$FORCE" ]; then
    echo "WARNING: transistor bulk on non-pin / untied net(s): $bad"
    echo "Set TIE_NET in env.sh and rerun pex_c.sh / pex_rc.sh, fix the layout, or run with FORCE=1."; exit 1
  fi
fi
rm -rf $OUT; mkdir -p $OUT
python3 sel_sim.py $STAGE $NET || { echo "---- ngspice log (tt_27) ----"; grep -i -E "error|fatal|unknown|no such|not found|duplicate" $OUT/log_tt_27.txt | head -10; tail -8 $OUT/log_tt_27.txt; }
