#!/usr/bin/env bash
# Stage: LVS  layout/<c>.gds  vs  netlist/<c>.spice  -> cells/<c>/verify/lvs/
#   LVS_ENGINE=klayout : PDK KLayout LVS deck; verdict read from the .lvsdb cross-reference
#   LVS_ENGINE=netgen  : magic extraction + netgen compare (mature sky130 path)
# shellcheck source=../lib/common.sh
source "$(dirname "$(readlink -f "$0")")/../lib/common.sh"

stage_init "$1" lvs
gds="$CELL_DIR/layout/$CELL.gds"
net="$CELL_DIR/netlist/$CELL.spice"
[[ -f $gds ]] || die "missing layout $gds"
[[ -f $net ]] || die "missing LVS netlist $net"

mkdir -p "$CELL_DIR/verify"
work=$(mktemp -d "$CELL_DIR/verify/.lvs.XXXXXX")
trap 'rm -rf "$work"' EXIT
verdict=UNKNOWN detail=""

case $LVS_ENGINE in
  klayout)
    need klayout
    check_topcell "$gds" "$CELL" || die "GDS does not contain '$CELL' as a top cell"
    rc=0
    pdk_klayout_lvs "$gds" "$net" "$CELL" "$work" "$STAGE_LOG" || rc=$?
    if (( rc == 3 )); then die "no KLayout LVS deck for PDK=$PDK (set KLAYOUT_LVS_DECK or LVS_ENGINE=netgen)"; fi
    db=$(find "$work" -name '*.lvsdb' -type f | head -n1)
    if [[ -n $db ]]; then
      out=$(klayout -b -r "$LIB/lvsdb_check.py" -rd lvsdb="$db" 2>>"$STAGE_LOG" || true)
      verdict=$(sed -n 's/^LVS_RESULT=//p' <<<"$out" | tail -n1)
      detail=$(sed -n 's/^LVS_DETAIL=//p' <<<"$out" | tail -n1)
    fi
    # Fallback when the database cannot be interpreted: the deck's own log verdict.
    if [[ -z $verdict || $verdict == UNKNOWN ]]; then
      if grep -qiE "don'?t match|do not match|mismatch" "$STAGE_LOG"; then verdict=MISMATCH
      elif grep -qiE 'congratulations|netlists match' "$STAGE_LOG"; then verdict=MATCH
      else verdict=UNKNOWN; fi
    fi
    ;;
  netgen)
    need magic netgen
    mrc=$(pdk_magicrc) || die "magicrc not found for PDK=$PDK"
    setup=$(pdk_netgen_setup) || die "netgen setup file not found for PDK=$PDK"
    ext="$work/${CELL}_ext.spice"
    cat > "$work/lvs_extract.tcl" <<EOF
drc off
gds read {$gds}
load {$CELL}
select top cell
extract do local
extract all
ext2spice lvs
ext2spice -o {$ext}
quit -noprompt
EOF
    ( cd "$work" && run_tool "$LVS_TIMEOUT" "$STAGE_LOG" magic -dnull -noconsole -rcfile "$mrc" "$work/lvs_extract.tcl" ) \
      || die "magic extraction for LVS failed"
    [[ -s $ext ]] || die "magic produced no extracted netlist"
    rc=0
    ( cd "$work" && run_tool "$LVS_TIMEOUT" "$STAGE_LOG" netgen -batch lvs "$ext $CELL" "$net $CELL" "$setup" "$work/lvs.report" ) || rc=$?
    [[ -f $work/lvs.report ]] || die "netgen produced no report (exit $rc)"
    if grep -q 'Property errors' "$work/lvs.report"; then verdict=MISMATCH; detail="property (W/L/M) errors"
    elif grep -qE 'Circuits match uniquely|Netlists match' "$work/lvs.report" \
         && ! grep -q 'do not match' "$work/lvs.report"; then verdict=MATCH
    else verdict=MISMATCH; fi
    ;;
  *) die "unknown LVS_ENGINE '$LVS_ENGINE' (klayout|netgen)" ;;
esac

printf '{"engine": "%s", "verdict": "%s", "detail": %s}\n' "$LVS_ENGINE" "$verdict" \
  "$(python3 -c 'import json,sys; print(json.dumps(sys.argv[1]))' "$detail")" > "$work/lvs_summary.json"
replace_dir "$work" "$CELL_DIR/verify/lvs"
trap - EXIT
details="$CELL_DIR/verify/lvs/lvs_summary.json"

case $verdict in
  MATCH)    pass "LVS clean ($LVS_ENGINE)" "$details" ;;
  MISMATCH) die "LVS mismatch${detail:+: $detail} — inspect verify/lvs/" "$details" ;;
  *)        die "LVS verdict could not be determined — inspect log and verify/lvs/ (never assumed clean)" "$details" ;;
esac
