#!/usr/bin/env bash
# Harden ELAD1_CONTROL with LibreLane (EDA box), then publish the result:
#   bash cells/ELAD1_CONTROL/harden/harden.sh            # full run
#   bash cells/ELAD1_CONTROL/harden/harden.sh collect    # only re-publish the latest run
# Publishes
#   cells/ELAD1_CONTROL/layout/ELAD1_CONTROL.gds   the layout (flow convention: DRC, and the copy that
#                                                  tt-check compares the placed instance against)
#   cells/ELAD1_CONTROL/macro/ELAD1_CONTROL.lef / .nl.v / metrics.json   abstract views + reports
# and regenerates cells/ELAD1_CONTROL/synth/ELAD1_CONTROL.spice from the HARDENED netlist, so
# simulation uses exactly the cells (buffers, clock tree, ties) that are in the layout, plus
# synth/ELAD1_CONTROL_lvs.spice (PDK cell definitions unchanged) for LVS. Port order of both
# = pin order of schematic/ELAD1_CONTROL.sym.
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")"
: "${PDK_ROOT:=/foss/pdks}" "${PDK:=sky130A}"
GDS=../layout/ELAD1_CONTROL.gds

# The GDS is a Git LFS lockable file: it is read-only until you hold the lock.
if [[ -e $GDS && ! -w $GDS ]]; then
  echo "harden: $GDS is read-only - lock it first:" >&2
  echo "        git lfs lock cells/ELAD1_CONTROL/layout/ELAD1_CONTROL.gds" >&2
  exit 1
fi

if [[ ${1:-} != collect ]]; then
  librelane --manual-pdk --pdk-root "$PDK_ROOT" --pdk "$PDK" config.json
fi

run=$(ls -td runs/*/ 2>/dev/null | head -1)
[[ -n $run && -d $run/final ]] || { echo "harden: no finished run in runs/ (see the LibreLane output)" >&2; exit 1; }
f=$run/final
mkdir -p ../layout ../macro
cp "$f/gds/ELAD1_CONTROL.gds" "$GDS"
cp "$f/lef/ELAD1_CONTROL.lef" "$f/nl/ELAD1_CONTROL.nl.v" ../macro/
[[ -f $f/metrics.json ]] && cp "$f/metrics.json" ../macro/metrics.json
echo "harden: published from $run  (GDS -> layout/, LEF + netlist + metrics -> macro/)"

HD=$PDK_ROOT/$PDK/libs.ref/sky130_fd_sc_hd/spice
python3 ../../../flow/lib/gl2spice.py ../macro/ELAD1_CONTROL.nl.v ELAD1_CONTROL ../synth/ELAD1_CONTROL.spice \
    --stdcells "$HD"/*.spice --name ELAD1_CONTROL --embed \
    --lvs-out ../synth/ELAD1_CONTROL_lvs.spice \
    --sym ../schematic/ELAD1_CONTROL.sym
# --sym: the .subckt ports must follow the xschem symbol's pin order, because xschem writes the
# instance line positionally in symbol order. LibreLane writes the netlist header ALPHABETICALLY,
# so without --sym every pin of the controller would be connected to the wrong net.
