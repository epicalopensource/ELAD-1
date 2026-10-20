#!/usr/bin/env bash
# Continuous local automation: when a SOURCE file is saved (schematic .sch/.sym, layout .gds,
# sim/specs.txt), re-run the flow for the affected cells after a quiet period.
#
#   * Debounce (WATCH_QUIET_S, default 2 s): KLayout/xschem saves and multi-file edits collapse
#     into one run; a run never starts while a file is still being written.
#   * Only source paths trigger runs, so the flow's own outputs cannot cause a feedback loop.
#   * Events arriving during a run are queued and processed after it (never overlapping runs).
#   * Uses inotifywait (inotify-tools) when present, else portable polling.
set -uo pipefail
ROOT=$(cd "$(dirname "$(readlink -f "$0")")/.." && pwd)
cd "$ROOT" || exit 2
QUIET=${WATCH_QUIET_S:-2}
SRC_RE='^cells/([A-Za-z_][A-Za-z0-9_]*)/(schematic/[^/]+\.(sch|sym)|layout/[^/]+\.gds|sim/specs\.txt)$'

declare -A pending=()

run_pending() {
  (( ${#pending[@]} )) || return 0
  local cells=("${!pending[@]}")
  pending=()
  echo "[watch] $(date +%H:%M:%S) change detected -> ${cells[*]}"
  if flow/run.sh "${cells[@]}"; then echo "[watch] all green"; else echo "[watch] failures — see reports/summary.md"; fi
  echo "[watch] waiting for changes..."
}

# A '_' folder (e.g. cells/_io) holds shared symbols, not a cell: a change there may affect any
# cell, so queue them all. make is incremental, so unaffected cells cost ~1 s each.
note() {
  local p=${1#./} c d
  [[ $p =~ $SRC_RE ]] || return 0
  c=${BASH_REMATCH[1]}
  if [[ $c != _* ]]; then pending[$c]=1; return 0; fi
  for d in cells/*/; do d=$(basename "$d"); [[ $d == _* ]] || pending[$d]=1; done
}

echo "[watch] watching cells/ (quiet period ${QUIET}s). Ctrl-C to stop."
if command -v inotifywait >/dev/null 2>&1; then
  exec {ev}< <(inotifywait -m -r -q -e close_write,moved_to,create --format '%w%f' cells)
  while true; do
    if IFS= read -r -t "$QUIET" -u "$ev" path; then
      note "$path"
    else
      rc=$?
      if (( rc > 128 )); then run_pending; continue; fi   # timeout = quiet period elapsed
      echo "[watch] inotifywait exited" >&2; exit 1        # EOF
    fi
  done
else
  echo "[watch] inotifywait not found — polling every ${QUIET}s (apt install inotify-tools for instant events)"
  stamp=$(mktemp); next=$(mktemp)
  trap 'rm -f "$stamp" "$next"' EXIT
  while sleep "$QUIET"; do
    touch "$next"                          # mark BEFORE scanning: nothing written meanwhile is missed
    found=0
    while IFS= read -r f; do note "$f"; found=1; done < <(
      find cells -type f -newer "$stamp" \( -path '*/schematic/*.sch' -o -path '*/schematic/*.sym' \
           -o -path '*/layout/*.gds' -o -path '*/sim/specs.txt' \) 2>/dev/null)
    mv -f "$next" "$stamp"; next=$(mktemp)
    # Debounce: run only after a poll interval with no further changes.
    if (( found == 0 )); then run_pending; fi
  done
fi
