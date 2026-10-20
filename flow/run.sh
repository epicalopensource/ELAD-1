#!/usr/bin/env bash
# One flow run: every cell's DAG executed concurrently (make -k -j), then the report.
#   flow/run.sh [cell ...]        default: all cells (folders under cells/ not starting with _)
# Exit status: non-zero if make failed OR any applicable stage is not PASS.
set -uo pipefail
ROOT=$(cd "$(dirname "$(readlink -f "$0")")/.." && pwd)
cd "$ROOT" || exit 2
JOBS=${JOBS:-$(nproc 2>/dev/null || echo 4)}

cells=("$@")
if (( ${#cells[@]} == 0 )) && [[ -d cells ]]; then
  mapfile -t cells < <(find cells -mindepth 1 -maxdepth 1 -type d ! -name '_*' -printf '%f\n' | sort)
fi
if (( ${#cells[@]} == 0 )); then echo "no cells under cells/ (make new-cell NAME=...)"; exit 0; fi
for c in "${cells[@]}"; do
  [[ $c =~ ^[A-Za-z_][A-Za-z0-9_]*$ && -d cells/$c ]] || { echo "invalid or unknown cell: '$c' (no folder cells/$c — are you in the right clone?)" >&2; exit 2; }
  [[ $c != _* ]] || { echo "'$c' is a shared-symbol folder, not a cell; run the cells that use it" >&2; exit 2; }
done

# One run at a time per checkout: two concurrent makes on the same cell would race on the
# same output paths (watcher + manual run, or two watchers).
if command -v flock >/dev/null 2>&1; then
  exec 9>"$ROOT/.flow.lock"
  if ! flock -n 9; then echo "[flow] another run is active — waiting for it to finish"; flock 9; fi
fi

echo "[flow] cells: ${cells[*]}  jobs: $JOBS"
t0=$(date +%s)
make -k -j"$JOBS" --no-print-directory -C "$ROOT" cells CELLS="${cells[*]}"
mrc=$?
python3 flow/lib/report.py "${cells[@]}"
rrc=$?
echo "[flow] finished in $(( $(date +%s) - t0 ))s (make=$mrc report=$rrc)"
exit $(( mrc != 0 ? mrc : rrc ))
