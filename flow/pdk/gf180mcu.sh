# shellcheck shell=bash
# PDK adapter: GlobalFoundries GF180MCU (open_pdks: $PDK_ROOT/gf180mcuC|D).
# Contract: see flow/pdk/sky130.sh. GF180 ships official KLayout DRC/LVS with python runners.
# VERIFY: runner arguments against `python3 run_drc.py --help` / `run_lvs.py --help` of your release.

GF_VARIANT=${PDK#gf180mcu}          # C | D

pdk_magicrc()      { first_existing "$PDK_DIR/libs.tech/magic/$PDK.magicrc"; }
pdk_ngspice_init() { first_existing "$PDK_DIR/libs.tech/ngspice/.spiceinit" "$PDK_DIR/libs.tech/ngspice/spinit"; }
pdk_netgen_setup() { first_existing "$PDK_DIR/libs.tech/netgen/${PDK}_setup.tcl" "$PDK_DIR/libs.tech/netgen/setup.tcl"; }

pdk_klayout_drc() {
  local gds=$1 top=$2 out=$3 lf=$4 runner
  if [[ -n $KLAYOUT_DRC_DECK ]]; then
    run_tool "$DRC_TIMEOUT" "$lf" klayout -b -r "$KLAYOUT_DRC_DECK" \
      -rd input="$gds" -rd topcell="$top" -rd report="$out/$top.lyrdb"
    return
  fi
  runner=$(first_existing "$PDK_DIR/libs.tech/klayout/drc/run_drc.py") || return 3
  run_tool "$DRC_TIMEOUT" "$lf" python3 "$runner" --path="$gds" --variant="$GF_VARIANT" \
    --topcell="$top" --run_dir="$out" --thr="$(nproc)" --run_mode=deep
}

pdk_klayout_lvs() {
  local gds=$1 net=$2 top=$3 out=$4 lf=$5 runner
  if [[ -n $KLAYOUT_LVS_DECK ]]; then
    run_tool "$LVS_TIMEOUT" "$lf" klayout -b -r "$KLAYOUT_LVS_DECK" \
      -rd input="$gds" -rd schematic="$net" -rd topcell="$top" -rd report="$out/$top.lvsdb"
    return
  fi
  runner=$(first_existing "$PDK_DIR/libs.tech/klayout/lvs/run_lvs.py") || return 3
  run_tool "$LVS_TIMEOUT" "$lf" python3 "$runner" --layout="$gds" --netlist="$net" \
    --variant="$GF_VARIANT" --topcell="$top" --run_dir="$out" --thr="$(nproc)"
}
