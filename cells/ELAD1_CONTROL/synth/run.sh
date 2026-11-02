#!/usr/bin/env bash
# Regenerate cells/ELAD1_CONTROL/synth/ELAD1_CONTROL.spice from src/elad1_control.v (EDA box).
#   bash cells/ELAD1_CONTROL/synth/run.sh
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")"
: "${PDK_ROOT:=/foss/pdks}" "${PDK:=sky130A}"
HD=$PDK_ROOT/$PDK/libs.ref/sky130_fd_sc_hd
python3 ../../../flow/lib/lib_drop_cells.py "$HD/lib/sky130_fd_sc_hd__tt_025C_1v80.lib" hd_tt_nolp.lib lpflow
yosys -q -l synth.log synth.ys
python3 ../../../flow/lib/gl2spice.py elad1_control.nl.v elad1_control ELAD1_CONTROL.spice \
    --stdcells "$HD/spice/sky130_fd_sc_hd.spice" --name ELAD1_CONTROL --embed
rm -f hd_tt_nolp.lib
