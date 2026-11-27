#!/usr/bin/env bash
# tidy_cell.sh - make one cell folder pass the analog flow, in one of two layouts.
#   keep  : old manual flow stays exactly where it is (keeps working unchanged)
#   clean : old manual flow moves to cells/<CELL>/_manual/ with path-compatible links
# Both: check sources, fix GDS (single top, DBU 0.001), patch post-layout-unsafe tb probe,
# update .gitignore.
# Usage (repo root, EDA box):
#   bash tidy_cell.sh <CELL> keep|clean                 # dry run
#   bash tidy_cell.sh <CELL> keep|clean --apply         # do it
#   bash tidy_cell.sh <CELL> keep|clean --apply --run   # do it, then ./flow/run.sh <CELL>
set -euo pipefail

CELL=${1:?usage: tidy_cell.sh <CELL> keep|clean [--apply] [--run]}
MODE=${2:?usage: tidy_cell.sh <CELL> keep|clean [--apply] [--run]}
shift 2
APPLY=0; RUN=0
for a in "$@"; do
  case $a in --apply) APPLY=1 ;; --run) RUN=1 ;; *) echo "unknown option $a"; exit 2 ;; esac
done
[[ $MODE == keep || $MODE == clean ]] || { echo "mode must be keep or clean"; exit 2; }
C=cells/$CELL
[[ -f flow/run.sh && -d $C ]] || { echo "run from the repo root; $C must exist"; exit 2; }
((RUN && !APPLY)) && { echo "--run needs --apply"; exit 2; }

WARN=0
say()  { printf '%s\n' "$*"; }
warn() { printf 'WARN: %s\n' "$*"; WARN=$((WARN + 1)); }
act()  { if ((APPLY)); then "$@"; else printf '  would: %s\n' "$*"; fi; }
has_git() { command -v git >/dev/null 2>&1 && git rev-parse --is-inside-work-tree >/dev/null 2>&1; }
is_tracked() { has_git && [[ -n $(git ls-files -- "$1" | head -1) ]]; }
move() {
  [[ -e $1 || -L $1 ]] || return 0
  act mkdir -p "$(dirname "$2")"
  if is_tracked "$1"; then act git mv -k "$1" "$2"; else act mv "$1" "$2"; fi
}

say "== $CELL  mode=$MODE  $( ((APPLY)) && echo APPLY || echo 'DRY RUN (add --apply to change files)')"

say "-- 1. source files the flow needs"
for f in schematic/$CELL.sch schematic/$CELL.sym schematic/tb_$CELL.sch layout/$CELL.gds sim/specs.txt; do
  if [[ -f $C/$f ]]; then say "  ok      $f"; else warn "missing $C/$f"; fi
done

say "-- 2. layout: single top cell '$CELL', DBU 0.001"
GDS=$C/layout/$CELL.gds
if [[ -f $GDS ]] && command -v klayout >/dev/null 2>&1; then
  PY=$(mktemp --suffix=.py)
  cat > "$PY" <<'EOF'
import pya
ly = pya.Layout(); ly.read(gds)
tops = [c.name for c in ly.top_cells()]
bad = len(tops) != 1 or tops[0] != top or abs(ly.dbu - 0.001) > 1e-12
print(f"  found DBU {ly.dbu}  tops {tops}")
if ly.cell(top) is None:
    print(f"  ERROR no cell named {top}: rename the top cell in KLayout"); raise SystemExit
if bad and fix == "1":
    for ci in [c.cell_index() for c in ly.top_cells() if c.name != top]:
        ly.prune_cell(ci, -1)
    opt = pya.SaveLayoutOptions(); opt.dbu = 0.001
    ly.write(gds, opt)
    chk = pya.Layout(); chk.read(gds)
    print(f"  fixed -> DBU {chk.dbu}  tops {[c.name for c in chk.top_cells()]}")
elif bad:
    print("  NEEDS FIX (done with --apply)")
EOF
  ((APPLY)) && chmod u+w "$GDS"
  klayout -b -r "$PY" -rd gds="$GDS" -rd top="$CELL" -rd fix="$APPLY"
  rm -f "$PY"
elif [[ -f $GDS ]]; then
  warn "klayout not found here: run this script in the EDA box to check/fix the GDS"
fi

say "-- 3. testbench: post-layout may only probe the cell's ports"
TB=$C/schematic/tb_$CELL.sch; SYM=$C/schematic/$CELL.sym
if [[ -f $TB && -f $SYM ]]; then
  PORTS=$( { grep -o 'name=[][A-Za-z0-9_:]*' "$SYM" || true; } | cut -d= -f2 | tr 'A-Z' 'a-z' | sort -u | tr '\n' ' ')
  say "  ports from symbol: $PORTS"
  if grep -q '(v(hin)-v(xdut\.hd))\*i_heater' "$TB"; then
    if ((APPLY)); then
      cp "$TB" "$TB.bak"
      sed -i 's/(v(hin)-v(xdut\.hd))\*i_heater/v(hin)*i_heater/g' "$TB"
      say "  patched (v(hin)-v(xdut.hd))*i_heater -> v(hin)*i_heater   (backup: $TB.bak)"
    else
      say "  would patch (v(hin)-v(xdut.hd))*i_heater -> v(hin)*i_heater"
    fi
  fi
  CHK=$(mktemp); sed 's/(v(hin)-v(xdut\.hd))\*i_heater/v(hin)*i_heater/g' "$TB" > "$CHK"
  LEFT=0
  while read -r n; do
    [[ -z $n ]] && continue
    case " $PORTS " in *" $n "*) ;; *) warn "tb probes internal net xdut.$n - replace with a port-based quantity"; LEFT=1 ;; esac
  done < <( { grep -oi 'xdut\.[a-z0-9_#]*' "$CHK" || true; } | cut -d. -f2 | tr 'A-Z' 'a-z' | sort -u)
  rm -f "$CHK"
  ((LEFT)) || say "  ok      no internal-net probes left"
fi

say "-- 4. folder layout ($MODE)"
M=$C/_manual
if [[ $MODE == clean ]]; then
  for f in run_sim.sh pex_c.sh pex_rc.sh env.sh collect.py compare.py; do
    move "$C/netlist/$f" "$M/$f"
  done
  move "$C/netlist/results_dc" "$M/results_dc"
  move "$C/netlist/flow"       "$M/old_copy_flow"
  for f in "$CELL.lvsdb" "${CELL}_extracted.cir" sky130_drc.txt; do
    move "$C/layout/$f" "$M/gui_verify/$f"
  done
  move "$C/layout/backups" "$M/layout_backups"
  for f in "$CELL.spice" "tb_$CELL.spice"; do
    [[ -e $M/$f || -L $M/$f ]] || act ln -s "../netlist/$f" "$M/$f"
  done
  if [[ -d $M ]] || ((!APPLY)); then
    for s in "$M"/*.sh "$M"/*.py "$C"/netlist/*.sh "$C"/netlist/*.py; do
      [[ -f $s ]] || continue
      if grep -q "/$C/netlist" "$s"; then
        act sed -i "s#/$C/netlist#/$C/_manual#g" "$s"
        say "  path rewrite in $s"
      fi
    done
  fi
else
  say "  old manual flow stays in netlist/ and pex_rc/ (the flow ignores it)"
fi
for s in "$C"/netlist/*.sh "$C"/netlist/*.py "$M"/*.sh "$M"/*.py; do
  [[ -f $s ]] || continue
  grep -nE '(^|[ "=(])netlist/' "$s" | sed "s#^#  note $s:#" || true
done

say "-- 5. .gitignore"
IGN=(
  "cells/*/pex_rc/"
  "cells/*/netlist/results_dc/"
  "cells/*/netlist/flow/results/"
  "cells/*/layout/backups/"
  "cells/*/layout/*.lvsdb"
  "cells/*/layout/*_extracted.cir"
  "cells/*/layout/sky130_drc.txt"
  "cells/*/_manual/results_dc/"
  "cells/*/_manual/old_copy_flow/results/"
  "cells/*/_manual/layout_backups/"
  "cells/*/_manual/gui_verify/"
  "cells/*/schematic/*.bak"
)
((APPLY)) && touch .gitignore
for p in "${IGN[@]}"; do
  { [[ -f .gitignore ]] && grep -qxF "$p" .gitignore; } || act sh -c "printf '%s\n' '$p' >> .gitignore"
done
if has_git; then
  for p in "$C/pex_rc" "$C/netlist/results_dc" "$C/netlist/flow/results" "$C/layout/backups" \
           "$C/layout/$CELL.lvsdb" "$C/layout/${CELL}_extracted.cir" "$C/layout/sky130_drc.txt" \
           "$M/results_dc" "$M/old_copy_flow/results" "$M/layout_backups" "$M/gui_verify"; do
    is_tracked "$p" && act git rm -r -q --cached -- "$p"
  done
fi

say "-- done: $WARN warning(s)"
if ((RUN)); then
  say "-- running ./flow/run.sh $CELL"
  ./flow/run.sh "$CELL"
fi
