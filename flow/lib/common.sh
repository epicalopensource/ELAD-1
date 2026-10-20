# shellcheck shell=bash
# common.sh — shared stage runtime: logging, status records, atomic publication,
# tool invocation with timeouts. Every stage script sources this first.
#
# Stage contract (enforced here, relied upon by cell.mk and report.py):
#   * a stage exits 0 only if its result is good; non-zero otherwise
#   * a stage ALWAYS writes cells/<cell>/reports/<stage>.json (PASS|FAIL)
#   * outputs are built in a private work dir and published with a rename,
#     so no consumer (make, watcher, a human, a concurrent stage) sees a partial file

set -Eeuo pipefail
# shellcheck source=env.sh
source "$(dirname "${BASH_SOURCE[0]}")/env.sh"
LIB="$FLOW_ROOT/flow/lib"

log() {
  local line
  line=$(printf '[%s] [%s/%s] %s' "$(date +%H:%M:%S)" "${CELL:-?}" "${STAGE:-?}" "$*")
  printf '%s\n' "$line" >&2
  if [[ -n ${STAGE_LOG:-} ]]; then printf '%s\n' "$line" >> "$STAGE_LOG"; fi
}

# write_status <PASS|FAIL> <message> [details.json]
write_status() {
  local status=$1 msg=${2:-} details=${3:-}
  python3 - "$CELL_DIR/reports/$STAGE.json" "$CELL" "$STAGE" "$status" "$msg" \
           "$(( $(date +%s) - STAGE_T0 ))" "$details" "$STAGE_LOG" "$CELL_DIR" <<'PY'
import json, os, sys, tempfile, time
out, cell, stage, status, msg, dur, details, log, cell_dir = sys.argv[1:10]
rec = {"cell": cell, "stage": stage, "status": status, "message": msg,
       "duration_s": int(dur), "finished": time.strftime("%Y-%m-%dT%H:%M:%S%z"),
       "pdk": os.environ.get("PDK"), "log": os.path.relpath(log, cell_dir)}
if details and os.path.isfile(details):
    try:
        with open(details) as f:
            rec["details"] = json.load(f)
    except ValueError:
        rec["details_error"] = "unparseable " + details
os.makedirs(os.path.dirname(out), exist_ok=True)
fd, tmp = tempfile.mkstemp(dir=os.path.dirname(out), prefix=".status.")
with os.fdopen(fd, "w") as f:
    json.dump(rec, f, indent=2)
os.replace(tmp, out)
PY
}

pass() { trap - ERR; log "PASS: $1"; write_status PASS "$1" "${2:-}"; exit 0; }
die()  { trap - ERR; log "FAIL: $1"; write_status FAIL "$1" "${2:-}" || true; exit 1; }

_on_err() { die "unexpected error at line $1 (exit $2) — see log"; }

# stage_init <cell> <stage>
stage_init() {
  CELL=$1; STAGE=$2
  if [[ ! $CELL =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]]; then echo "invalid cell name '$CELL'" >&2; exit 2; fi
  CELL_DIR="$FLOW_ROOT/cells/$CELL"
  if [[ ! -d $CELL_DIR ]]; then echo "no such cell directory: $CELL_DIR" >&2; exit 2; fi
  STAGE_T0=$(date +%s)
  mkdir -p "$CELL_DIR/reports/logs"
  STAGE_LOG="$CELL_DIR/reports/logs/$STAGE.log"
  # Keep the previous run's log: an intermittent failure followed by a passing rerun would
  # otherwise erase the only evidence of what went wrong.
  if [[ -s $STAGE_LOG ]]; then mv -f "$STAGE_LOG" "${STAGE_LOG%.log}.prev.log"; fi
  : > "$STAGE_LOG"
  export CELL STAGE CELL_DIR STAGE_LOG STAGE_T0
  trap '_on_err $LINENO $?' ERR
  log "start (PDK=$PDK)"
}

need() {
  local t
  for t in "$@"; do
    command -v "$t" >/dev/null 2>&1 || die "required tool '$t' not on PATH (run inside the flow container, or 'make doctor')"
  done
}

# run_tool <timeout_s> <logfile> cmd... — stdin closed (tools must never block on a prompt)
run_tool() {
  local t=$1 lf=$2 rc=0
  shift 2
  printf '\n$ %s\n' "$*" >> "$lf"
  timeout --kill-after=30 "$t" "$@" >> "$lf" 2>&1 < /dev/null || rc=$?
  if (( rc == 124 || rc == 137 )); then log "TIMEOUT after ${t}s: $1"; fi
  return "$rc"
}

# Publish a finished work dir as <dst> with renames only (no copy, no partial state).
replace_dir() {
  local src=$1 dst=$2
  rm -rf "$dst.old"
  if [[ -e $dst ]]; then mv "$dst" "$dst.old"; fi
  mv "$src" "$dst"
  rm -rf "$dst.old"
}

# check_topcell <gds> <cell> — the GDS must contain <cell> as a top cell
check_topcell() {
  local gds=$1 cell=$2 tops
  tops=$(klayout -b -r "$LIB/gds_topcells.py" -rd gds="$gds" 2>>"$STAGE_LOG" \
         | sed -n 's/^TOPCELL://p') || true
  if ! grep -qxF "$cell" <<<"$tops"; then
    log "top cells found in $(basename "$gds"): ${tops//$'\n'/ }"
    return 1
  fi
}
