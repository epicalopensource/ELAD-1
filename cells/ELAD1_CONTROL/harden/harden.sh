#!/usr/bin/env bash
# Harden ELAD1_CONTROL with LibreLane (EDA box), then publish the result:
#   bash cells/ELAD1_CONTROL/harden/harden.sh            # full run
#   bash cells/ELAD1_CONTROL/harden/harden.sh collect    # only re-publish the latest run
# Publishes to cells/ELAD1_CONTROL/macro/: ELAD1_CONTROL.gds / .lef / .nl.v (+ run reports),
# and regenerates cells/ELAD1_CONTROL/synth/ELAD1_CONTROL.spice from the HARDENED netlist, so
# simulation uses exactly the cells (buffers, clock tree, ties) that are in the layout, plus
# synth/ELAD1_CONTROL_lvs.spice (PDK cell definitions unchanged) for LVS. Port order of both
# = pin order of schematic/ELAD1_CONTROL.sym.
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")"
: "${PDK_ROOT:=/foss/pdks}" "${PDK:=sky130A}"

if [[ ${1:-} != collect ]]; then
  librelane --manual-pdk --pdk-root "$PDK_ROOT" --pdk "$PDK" config.json
fi

run=$(ls -td runs/*/ 2>/dev/null | head -1)
[[ -n $run && -d $run/final ]] || { echo "harden: no finished run in runs/ (see the LibreLane output)" >&2; exit 1; }
f=$run/final
mkdir -p ../macro
cp "$f/gds/ELAD1_CONTROL.gds" "$f/lef/ELAD1_CONTROL.lef" "$f/nl/ELAD1_CONTROL.nl.v" ../macro/
[[ -f $f/metrics.json ]] && cp "$f/metrics.json" ../macro/metrics.json
echo "harden: published from $run"

HD=$PDK_ROOT/$PDK/libs.ref/sky130_fd_sc_hd/spice
python3 ../../../flow/lib/gl2spice.py ../macro/ELAD1_CONTROL.nl.v ELAD1_CONTROL ../synth/ELAD1_CONTROL.spice \
    --stdcells "$HD"/*.spice --name ELAD1_CONTROL --embed \
    --lvs-out ../synth/ELAD1_CONTROL_lvs.spice \
    --sym ../schematic/ELAD1_CONTROL.sym
# --sym: the .subckt ports must follow the xschem symbol's pin order, because xschem writes the
# instance line positionally in symbol order. LibreLane writes the netlist header ALPHABETICALLY,
# so without --sym every pin of the controller would be connected to the wrong net.
