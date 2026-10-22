#!/usr/bin/env bash
# Run the EXTRA testbenches of the cells in batch and check their limits.
#
#   flow/tb.sh                         every extra testbench of every cell
#   flow/tb.sh <CELL>                  every extra testbench of one cell
#   flow/tb.sh <CELL> <TB> [<TB>...]   chosen ones, e.g. flow/tb.sh ELAD1_ANALOG_CORE tb_top_mirror
#   JOBS=2 flow/tb.sh ...              how many run at once (default 4)
#
# "Extra" = any cells/<CELL>/schematic/tb_*.sch other than tb_<CELL>.sch (that one is run by `make`).
# For each: netlist (flow/lib/tb_netlist.sh), ngspice -b in a private work dir with the PDK
# settings, then the ROW lines it prints are checked against cells/<CELL>/sim/specs_<TB>.txt
# (flow/lib/tb_rows.py). Results: cells/<CELL>/sim/results/<TB>/ (ngspice.log, rows.csv, files the
# testbench writes). Exit status 0 when every testbench passes.
set -uo pipefail
ROOT=$(cd "$(dirname "$(readlink -f "$0")")/.." && pwd)
cd "$ROOT"
JOBS=${JOBS:-4}
TIMEOUT=${TB_TIMEOUT:-3600}
: "${PDK_ROOT:?PDK_ROOT is not set - run this in the EDA box}" "${PDK:?PDK is not set}"
init="$PDK_ROOT/$PDK/libs.tech/ngspice/spinit"

# ---- which testbenches
list=()
if (( $# >= 2 )); then
  c=$1; shift
  for t in "$@"; do [[ $t == tb_* ]] || t=tb_$t; list+=("$c $t"); done
else
  for sch in cells/${1:-*}/schematic/tb_*.sch; do
    [[ -f $sch ]] || continue
    c=$(basename "$(dirname "$(dirname "$sch")")"); t=$(basename "$sch" .sch)
    [[ $t == "tb_$c" ]] || list+=("$c $t")
  done
fi
(( ${#list[@]} )) || { echo "tb: no extra testbench found (cells/*/schematic/tb_*.sch other than tb_<CELL>.sch)"; exit 2; }

rep=$(mktemp -d); trap 'rm -rf "$rep"' EXIT

run_one() {   # <cell> <tb> <report file>
  local c=$1 t=$2 out=$3 s=$SECONDS dest="cells/$1/sim/results/$2"
  local work; work=$(mktemp -d)
  {
    if [[ ! -f cells/$c/schematic/$t.sch ]]; then echo "FAIL $c $t: no cells/$c/schematic/$t.sch"; return; fi
    if ! bash flow/lib/tb_netlist.sh "$c" "$t" >"$work/netlist.log" 2>&1; then
      echo "FAIL $c $t: netlisting failed"; sed 's/^/    /' "$work/netlist.log"; return
    fi
    [[ -f $init ]] && cp "$init" "$work/.spiceinit"
    local rc=0
    ( cd "$work" && timeout "$TIMEOUT" ngspice -b "$ROOT/cells/$c/netlist/$t.spice" >ngspice.log 2>&1 ) || rc=$?
    local errs
    errs=$(grep -E '^[[:space:]]*(Error|ERROR)\b|[Ff]atal|Circuit not parsed|could not find|Timestep too small' \
           "$work/ngspice.log" | sort | uniq -c | sort -rn | head -n 3)
    local chk; chk=$(python3 flow/lib/tb_rows.py "$work/ngspice.log" "cells/$c/sim/specs_$t.txt" --csv "$work/rows.csv" 2>&1)
    local crc=$?
    mkdir -p "$(dirname "$dest")"; rm -rf "$dest"; rm -f "$work/.spiceinit"; mv "$work" "$dest"
    local verdict=PASS why=""
    if (( rc == 124 || rc == 137 )); then verdict=FAIL; why=" - timed out after ${TIMEOUT}s"
    elif (( rc != 0 )); then verdict=FAIL; why=" - ngspice exited with status $rc"
    elif (( crc != 0 )); then verdict=FAIL; why=" - limits not met"
    fi
    echo "$verdict $c $t ($((SECONDS - s))s)$why"
    [[ -n $chk ]] && echo "$chk"
    [[ -n $errs ]] && echo "    ngspice messages (count, first lines):" && echo "$errs" | sed 's/^/    /'
    echo "    results: $dest/"
  } >"$out" 2>&1
}

echo "tb: ${#list[@]} testbench(es), $JOBS at a time"
i=0
for e in "${list[@]}"; do
  set -- $e
  run_one "$1" "$2" "$rep/$(printf %03d $i)" &
  i=$((i + 1))
  while (( $(jobs -rp | wc -l) >= JOBS )); do wait -n; done
done
wait
fail=0
for f in "$rep"/*; do cat "$f"; head -1 "$f" | grep -q '^PASS' || fail=$((fail + 1)); done
echo "tb: $(( ${#list[@]} - fail )) of ${#list[@]} passed"
(( fail == 0 ))
