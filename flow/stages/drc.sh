#!/usr/bin/env bash
# Stage: KLayout DRC on cells/<c>/layout/<c>.gds -> cells/<c>/verify/drc/
# Pass criterion: >=1 report database produced AND zero violations AND clean tool exit.
# shellcheck source=../lib/common.sh
source "$(dirname "$(readlink -f "$0")")/../lib/common.sh"

stage_init "$1" drc
need klayout python3

gds="$CELL_DIR/layout/$CELL.gds"
[[ -f $gds ]] || die "missing layout $gds"
check_topcell "$gds" "$CELL" || die "GDS does not contain '$CELL' as a top cell (rename the cell or file)"

mkdir -p "$CELL_DIR/verify"
work=$(mktemp -d "$CELL_DIR/verify/.drc.XXXXXX")
trap 'rm -rf "$work"' EXIT

rc=0
pdk_klayout_drc "$gds" "$CELL" "$work" "$STAGE_LOG" || rc=$?
if (( rc == 3 )); then die "no KLayout DRC deck found for PDK=$PDK (set KLAYOUT_DRC_DECK)"; fi

mapfile -t dbs < <(find "$work" -name '*.lyrdb' -type f | sort)
if (( ${#dbs[@]} == 0 )); then
  die "DRC produced no .lyrdb (tool exit $rc) — deck invocation/variables likely wrong for this PDK (see log)"
fi
total=$(python3 "$LIB/drc_count.py" --out "$work/drc_summary.json" "${dbs[@]}")

replace_dir "$work" "$CELL_DIR/verify/drc"
trap - EXIT
details="$CELL_DIR/verify/drc/drc_summary.json"

# A crashed run can leave a valid-looking but truncated, empty database: never call that clean.
if (( rc != 0 && total == 0 )); then
  die "DRC tool exited $rc yet reported 0 violations — treating as tool failure, not as clean" "$details"
fi
if (( total == 0 )); then pass "DRC clean" "$details"; fi
die "$total DRC violation(s) — open verify/drc/*.lyrdb in KLayout (Tools > Marker Browser)" "$details"
