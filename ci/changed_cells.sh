#!/usr/bin/env bash
# Print a JSON array of cells CI must run, e.g. ["inv","ota"].
#
# Inputs (env):  EVENT (push|pull_request|workflow_dispatch|schedule), BASE_SHA, BEFORE_SHA,
#                INPUT_CELLS (manual override, comma/space separated)
# Rules:
#   * manual list            -> exactly those cells
#   * flow/config/CI changed -> all cells (the verification method itself changed)
#   * otherwise              -> cells with changed files, plus every cell whose schematic
#                               instantiates a changed cell (transitively)
#   * unknown/unreachable base (first push, force-push, shallow clone) -> all cells (safe side)
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")/.."

all_cells() { [[ -d cells ]] || return 0; find cells -mindepth 1 -maxdepth 1 -type d ! -name '_*' -printf '%f\n' | sort; }
emit() { python3 -c 'import json,re,sys
c=sorted({x for x in sys.stdin.read().split() if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*",x)})
print(json.dumps(c))'; }

if [[ -n ${INPUT_CELLS:-} ]]; then tr ', ' '\n\n' <<<"$INPUT_CELLS" | emit; exit 0; fi

base=""
case ${EVENT:-} in
  pull_request) base=${BASE_SHA:-} ;;
  push)         base=${BEFORE_SHA:-} ;;
esac
if [[ -z $base || $base =~ ^0+$ ]] || ! git cat-file -e "$base^{commit}" 2>/dev/null; then
  all_cells | emit; exit 0
fi

changed=$(git diff --name-only "$base" HEAD)
if grep -qE '^(flow/|flow\.conf$|Makefile$|ci/|\.github/)' <<<"$changed"; then all_cells | emit; exit 0; fi

declare -A sel=()
while IFS= read -r c; do [[ -n $c && -d cells/$c ]] && sel[$c]=1; done < <(
  grep -oE '^cells/[^/]+/' <<<"$changed" | cut -d/ -f2 | sort -u || true)

# Symbols whose file changed directly (covers symbol-only folders such as cells/_io/schematic/,
# whose symbols are not named after their folder).
declare -A syms=()
while IFS= read -r s; do [[ -n $s ]] && syms[$s]=1; done < <(
  grep -E '^cells/[^/]+/schematic/[^/]+\.sym$' <<<"$changed" | xargs -r -n1 basename | sed 's/\.sym$//' || true)

# Reverse hierarchy closure: a parent whose schematic references a changed cell's symbol,
# or a changed symbol file.
users_of() { grep -lE "(^|[/ {])$1\.sym" cells/*/schematic/*.sch 2>/dev/null || true; }
for s in "${!syms[@]}"; do
  while IFS= read -r f; do [[ -n $f ]] && sel[$(cut -d/ -f2 <<<"$f")]=1; done < <(users_of "$s")
done
grew=1
while (( grew )); do
  grew=0
  for c in "${!sel[@]}"; do
    while IFS= read -r f; do
      p=$(cut -d/ -f2 <<<"$f")
      if [[ -z ${sel[$p]:-} ]]; then sel[$p]=1; grew=1; fi
    done < <(users_of "$c")
  done
done
# Folders starting with '_' hold shared symbols only; they are not cells and never run.
for c in "${!sel[@]}"; do [[ $c == _* ]] && unset "sel[$c]"; done
printf '%s\n' "${!sel[@]}" | emit
