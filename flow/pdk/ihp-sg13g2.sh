# shellcheck shell=bash
# PDK adapter: IHP SG13G2 (IHP-Open-PDK: $PDK_ROOT/ihp-sg13g2).
# Contract: see flow/pdk/sky130.sh. IHP ships official KLayout DRC/LVS runners.
# VERIFY: runner locations/arguments against your PDK checkout (`--help`); magic support for
# SG13G2 is newer than for sky130/gf180 — confirm the magicrc exists before relying on PEX.

pdk_magicrc()      { first_existing "$PDK_DIR/libs.tech/magic/$PDK.magicrc" "$PDK_DIR/libs.tech/magic/ihp-sg13g2.magicrc"; }
pdk_ngspice_init() { first_existing "$PDK_DIR/libs.tech/ngspice/.spiceinit" "$PDK_DIR/libs.tech/ngspice/spinit"; }
pdk_netgen_setup() { first_existing "$PDK_DIR/libs.tech/netgen/${PDK}_setup.tcl" "$PDK_DIR/libs.tech/netgen/setup.tcl"; }

pdk_klayout_drc() {
  local gds=$1 top=$2 out=$3 lf=$4 runner
  if [[ -n $KLAYOUT_DRC_DECK ]]; then
    run_tool "$DRC_TIMEOUT" "$lf" klayout -b -r "$KLAYOUT_DRC_DECK" \
      -rd input="$gds" -rd topcell="$top" -rd report="$out/$top.lyrdb"
    return
  fi
  runner=$(first_existing "$PDK_DIR/libs.tech/klayout/tech/drc/run_drc.py") || return 3
  run_tool "$DRC_TIMEOUT" "$lf" python3 "$runner" --path="$gds" --topcell="$top" --run_dir="$out"
}

pdk_klayout_lvs() {
  local gds=$1 net=$2 top=$3 out=$4 lf=$5 runner
  if [[ -n $KLAYOUT_LVS_DECK ]]; then
    run_tool "$LVS_TIMEOUT" "$lf" klayout -b -r "$KLAYOUT_LVS_DECK" \
      -rd input="$gds" -rd schematic="$net" -rd topcell="$top" -rd report="$out/$top.lvsdb"
    return
  fi
  runner=$(first_existing "$PDK_DIR/libs.tech/klayout/tech/lvs/run_lvs.py") || return 3
  run_tool "$LVS_TIMEOUT" "$lf" python3 "$runner" --layout="$gds" --netlist="$net" \
    --topcell="$top" --run_dir="$out"
}
