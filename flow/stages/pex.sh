#!/usr/bin/env bash
# Stage: magic parasitic extraction  layout/<c>.gds -> pex/<c>_pex.spice
#   PEX_MODE=c  : device + coupling/ground capacitance
#   PEX_MODE=rc : additionally wire resistance (extresist)
#
# The output is made simulation-ready and drop-in compatible with the schematic:
#   * flat (`ext2spice hierarchy off`) -> exactly one .subckt, no name clashes with the
#     testbench's own subcircuits
#   * port ORDER forced to the schematic's .subckt order (readspice in magic, then verified
#     and if needed rewritten by spice_tools.py). A silently permuted port list is the most
#     dangerous failure here: post-layout simulation would run and be wrong.
# shellcheck source=../lib/common.sh
source "$(dirname "$(readlink -f "$0")")/../lib/common.sh"

stage_init "$1" pex
need magic python3
gds="$CELL_DIR/layout/$CELL.gds"
net="$CELL_DIR/netlist/$CELL.spice"
[[ -f $gds ]] || die "missing layout $gds"
[[ -f $net ]] || die "missing schematic netlist $net (needed for port order)"
case $PEX_MODE in c|rc) ;; *) die "PEX_MODE must be c or rc (got '$PEX_MODE')" ;; esac
mrc=$(pdk_magicrc) || die "magicrc not found for PDK=$PDK"

work=$(mktemp -d "$CELL_DIR/.pex.XXXXXX")
trap 'rm -rf "$work"' EXIT
raw="$work/raw_pex.spice"

{
  echo "drc off"
  echo "gds read {$gds}"
  echo "load {$CELL}"
  echo "select top cell"
  echo "# Port indices from the schematic so the .subckt pin order matches (best effort)."
  echo "if {[catch {readspice {$net}} err]} { puts \"FLOW-WARN: readspice failed: \$err\" }"
  echo "load {$CELL}"
  echo "select top cell"
  echo "extract do local"
  echo "extract all"
  if [[ $PEX_MODE == rc ]]; then
    echo "ext2sim labels on"
    echo "ext2sim"
    echo "extresist tolerance $PEX_RES_TOLERANCE"
    echo "extresist all"
  fi
  echo "ext2spice lvs"
  echo "ext2spice format ngspice"
  echo "ext2spice hierarchy off"
  echo "ext2spice subcircuit top on"
  echo "ext2spice cthresh 0"
  if [[ $PEX_MODE == rc ]]; then echo "ext2spice extresist on"; fi
  echo "ext2spice -o {$raw}"
  echo "quit -noprompt"
} > "$work/pex.tcl"

( cd "$work" && run_tool "$PEX_TIMEOUT" "$STAGE_LOG" magic -dnull -noconsole -rcfile "$mrc" "$work/pex.tcl" ) \
  || die "magic exited non-zero (see log)"
[[ -s $raw ]] || die "magic produced no PEX netlist (see log: cell name, GDS layer map, labels)"

alias_args=()
for a in $PEX_PORT_ALIAS; do alias_args+=(--alias "$a"); done
python3 "$LIB/spice_tools.py" fix-ports --ref "$net" --pex "$raw" --cell "$CELL" \
    "${alias_args[@]}" --out "$work/${CELL}_pex.spice" --stats "$work/pex_stats.json" >>"$STAGE_LOG" 2>&1 \
  || die "PEX ports do not reconcile with the schematic (see log; layout labels or PEX_PORT_ALIAS)"

mkdir -p "$work/ext"
find "$work" -maxdepth 1 -type f \( -name '*.ext' -o -name '*.sim' -o -name '*.nodes' -o -name '*.res*' \) \
     -exec mv -t "$work/ext" {} +

ndev=$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))["devices"])' "$work/pex_stats.json")
summary=$(python3 -c 'import json,sys; s=json.load(open(sys.argv[1])); print("%d devices, %d C, %d R" % (s["devices"], s["capacitors"], s["resistors"]))' "$work/pex_stats.json")
warns=$(grep -c 'FLOW-WARN' "$STAGE_LOG" || true)

replace_dir "$work" "$CELL_DIR/pex"
trap - EXIT
details="$CELL_DIR/pex/pex_stats.json"
if (( ndev == 0 )); then die "PEX netlist contains no devices — extraction did not recognise the layout" "$details"; fi
pass "PEX ($PEX_MODE): $summary$( (( warns > 0 )) && echo ", $warns warning(s)" )" "$details"
