# shellcheck shell=bash
# PDK adapter: SkyWater SKY130 (open_pdks install: $PDK_ROOT/sky130A or sky130B).
#
# ADAPTER CONTRACT (every flow/pdk/*.sh implements these; stages never touch PDK paths):
#   pdk_magicrc        -> echo path to <pdk>.magicrc               (return 1 if absent)
#   pdk_ngspice_init   -> echo path copied to ./.spiceinit         (return 1 if absent)
#   pdk_netgen_setup   -> echo netgen setup .tcl                   (return 1 if absent)
#   pdk_klayout_drc <gds> <topcell> <outdir> <log>          -> writes *.lyrdb in outdir
#   pdk_klayout_lvs <gds> <netlist> <topcell> <outdir> <log> -> writes *.lvsdb in outdir
#   both klayout functions return 3 when no deck exists, else the tool's exit status.
#
# VERIFY: deck file names and `-rd` variable names differ between open_pdks releases.
# `make doctor` prints what was resolved; set KLAYOUT_DRC_DECK / KLAYOUT_LVS_DECK to override.
# For sky130 the most battle-tested LVS path is LVS_ENGINE=netgen.

pdk_magicrc()      { first_existing "$PDK_DIR/libs.tech/magic/$PDK.magicrc"; }
pdk_ngspice_init() { first_existing "$PDK_DIR/libs.tech/ngspice/spinit" "$PDK_DIR/libs.tech/ngspice/.spiceinit"; }
pdk_netgen_setup() { first_existing "$PDK_DIR/libs.tech/netgen/${PDK}_setup.tcl" "$PDK_DIR/libs.tech/netgen/setup.tcl"; }

pdk_drc_deck() {
  first_existing "$KLAYOUT_DRC_DECK" \
    "$PDK_DIR/libs.tech/klayout/drc/${PDK}_mr.drc" \
    "$PDK_DIR/libs.tech/klayout/drc/sky130A_mr.drc" \
    "$PDK_DIR/libs.tech/klayout/drc/sky130.lydrc"
}
pdk_lvs_deck() {
  first_existing "$KLAYOUT_LVS_DECK" \
    "$PDK_DIR/libs.tech/klayout/lvs/sky130.lvs" \
    "$PDK_DIR/libs.tech/klayout/lvs/${PDK}.lvs" \
    "$PDK_DIR/libs.tech/klayout/lvs/sky130.lylvs"
}

pdk_klayout_drc() {
  local gds=$1 top=$2 out=$3 lf=$4 deck
  deck=$(pdk_drc_deck) || return 3
  run_tool "$DRC_TIMEOUT" "$lf" klayout -b -r "$deck" \
    -rd input="$gds" -rd topcell="$top" -rd report="$out/$top.lyrdb" \
    -rd feol=true -rd beol=true -rd offgrid=true -rd thr="$(nproc)"
}

# Options of the sky130 KLayout LVS deck. In batch mode every option defaults to OFF
# ("false"); the interactive "Run LVS" dialog turns most of them ON. Without
# convert_subckts=true the deck treats xschem's `XM1 ... sky130_fd_pr__nfet_01v8` calls as
# black-box subcircuits instead of transistors, so a correct layout reports NoMatch.
# net_only stays false: W/L/nf ARE compared (sign-off quality, stricter than the dialog default).
# Override per run, e.g.:  KLAYOUT_LVS_OPTS="convert_subckts=true net_only=true" make ...
SKY130_LVS_OPTS_DEFAULT="convert_subckts=true top_lvl_pins=true schematic_simplify=true combine=true \
purge=true purge_nets=true spice_net_names=true spice_comments=true scale=true verbose=true net_only=false"

pdk_klayout_lvs() {
  local gds=$1 net=$2 top=$3 out=$4 lf=$5 deck o
  local -a opts=()
  deck=$(pdk_lvs_deck) || return 3
  for o in ${KLAYOUT_LVS_OPTS:-$SKY130_LVS_OPTS_DEFAULT}; do opts+=(-rd "$o"); done
  printf 'LVS deck options: %s\n' "${KLAYOUT_LVS_OPTS:-$SKY130_LVS_OPTS_DEFAULT}" >> "$lf"
  run_tool "$LVS_TIMEOUT" "$lf" klayout -b -r "$deck" \
    -rd input="$gds" -rd schematic="$net" -rd topcell="$top" \
    -rd report="$out/$top.lvsdb" -rd target_netlist="$out/${top}_extracted.cir" -rd thr="$(nproc)" \
    "${opts[@]}"
}
