#!/usr/bin/env bash
# tidy_cells.sh - bring cell folders into the flow structure WITHOUT REMOVING ANYTHING.
#   bash tidy_cells.sh <CELL|all>                  # dry run: prints the plan, changes nothing
#   bash tidy_cells.sh <CELL|all> --apply          # do it
#   bash tidy_cells.sh <CELL|all> --apply --run    # do it, then run the flow on each cell
# Nothing is deleted or untracked: non-flow files MOVE to cells/<C>/archive/<same path>.
# Missing folders found in git history are restored into archive/. The original GDS is kept
# as archive/layout/<C>_before_tidy.gds and the fixed GDS is XOR-checked against it.
# A tar of cells/ goes to _tidy_backup/<time>/ first. Cell .sch/.sym are never modified.
set -uo pipefail

TARGET=${1:?usage: tidy_cells.sh <CELL|all> [--apply] [--run]}; shift
APPLY=0; RUN=0
for a in "$@"; do case $a in --apply) APPLY=1 ;; --run) RUN=1 ;; *) echo "unknown option $a"; exit 2 ;; esac; done
[[ -f flow/run.sh && -d cells ]] || { echo "run from the repo root"; exit 2; }
((RUN && !APPLY)) && { echo "--run needs --apply"; exit 2; }

if [[ $TARGET == all ]]; then
  CELLS=(); for d in cells/*/; do c=$(basename "$d"); [[ $c == _* ]] && continue; CELLS+=("$c"); done
else
  [[ -d cells/$TARGET ]] || { echo "no cells/$TARGET"; exit 2; }
  CELLS=("$TARGET")
fi
HAS_KL=0; command -v klayout >/dev/null 2>&1 && HAS_KL=1
HAS_GIT=0; git rev-parse --is-inside-work-tree >/dev/null 2>&1 && HAS_GIT=1
((HAS_KL)) || echo "NOTE: klayout not found here - GDS check/fix skipped (run in the EDA box)"
echo "cells: ${CELLS[*]}   $( ((APPLY)) && echo APPLY || echo 'DRY RUN (add --apply to change files)')"

act() { if ((APPLY)); then "$@"; else printf '    would: %s\n' "$*"; fi; }
tracked() { ((HAS_GIT)) && [[ -n $(git ls-files -- "$1" | head -1) ]]; }
move() {
  [[ -e $1 || -L $1 ]] || return 0
  if [[ -e $2 || -L $2 ]]; then echo "    SKIP $1 -> $2 (destination exists, both kept)"; return 0; fi
  ((APPLY)) && mkdir -p "$(dirname "$2")"
  if tracked "$1"; then act git mv -k -- "$1" "$2"; else act mv -- "$1" "$2"; fi
  ((APPLY)) || return 0
  [[ -e $2 || -L $2 ]] && echo "    moved $1 -> $2" || echo "    ERROR moving $1"
}
link() {
  [[ -e $2 || -L $2 ]] && return 0
  ((APPLY)) && mkdir -p "$(dirname "$2")"; act ln -s "$1" "$2"
}

STAMP=$(date +%Y-%m-%d_%H%M%S); BK=_tidy_backup/$STAMP
if ((APPLY)); then
  mkdir -p "$BK"
  ((HAS_GIT)) && { grep -qxF "_tidy_backup/" .git/info/exclude 2>/dev/null || echo "_tidy_backup/" >> .git/info/exclude; }
  tar czf "$BK/cells.tgz" cells && echo "backup: $BK/cells.tgz ($(du -h "$BK/cells.tgz" | cut -f1))  - restore: tar xzf $BK/cells.tgz"
fi

GDSPY=$(mktemp --suffix=.py); XORPY=$(mktemp --suffix=.py)
cat > "$GDSPY" <<'EOF'
import pya
ly = pya.Layout(); ly.read(gds)
tops = [c.name for c in ly.top_cells()]
bad = len(tops) != 1 or tops[0] != top or abs(ly.dbu - 0.001) > 1e-12
print(f"    found DBU {ly.dbu}  top cells {tops if len(tops) <= 6 else tops[:3] + ['...'] + tops[-2:]} ({len(tops)})")
if ly.cell(top) is None:
    print(f"    ERROR: no cell named {top} - rename the top cell in KLayout"); raise SystemExit
if bad and fix == "1":
    for ci in [c.cell_index() for c in ly.top_cells() if c.name != top]:
        ly.prune_cell(ci, -1)
    opt = pya.SaveLayoutOptions(); opt.dbu = 0.001
    ly.write(gds, opt)
    chk = pya.Layout(); chk.read(gds)
    print(f"    fixed -> DBU {chk.dbu}  top cells {[c.name for c in chk.top_cells()]}")
elif bad:
    print("    NEEDS FIX (original kept as archive/layout/<C>_before_tidy.gds)")
else:
    print("    ok")
EOF
cat > "$XORPY" <<'EOF'
import pya
a = pya.Layout(); a.read(old); b = pya.Layout(); b.read(new)
ta, tb = a.cell(top), b.cell(top)
if ta is None or tb is None:
    print("    XOR: top cell missing"); raise SystemExit
infos = {(i.layer, i.datatype) for i in a.layer_infos()} | {(i.layer, i.datatype) for i in b.layer_infos()}
to_a = pya.ICplxTrans(b.dbu / a.dbu)
def polys(cell, li):
    if li is None: return pya.Region()
    it = cell.begin_shapes_rec(li)
    it.shape_flags = pya.Shapes.SPolygons | pya.Shapes.SBoxes | pya.Shapes.SPaths
    return pya.Region(it)
def labels(cell, li):
    out = set()
    if li is None: return out
    it = cell.begin_shapes_rec(li)
    while not it.at_end():
        s = it.shape()
        if s.is_text():
            t = s.dtext.transformed(it.dtrans())
            out.add((t.string, round(t.x, 4), round(t.y, 4)))
        it.next()
    return out
bad = []
for (l, d) in sorted(infos):
    ia, ib = a.find_layer(l, d), b.find_layer(l, d)
    x = polys(ta, ia) ^ polys(tb, ib).transformed(to_a)
    if not x.is_empty():
        bad.append(f"{l}/{d}: {x.count()} polygon diff, area {x.area()*a.dbu*a.dbu:.4f} um2")
    la, lb = labels(ta, ia), labels(tb, ib)
    if la != lb:
        bad.append(f"{l}/{d}: labels differ (-{sorted(la-lb)[:3]} +{sorted(lb-la)[:3]})")
na, nb = sum(1 for _ in ta.each_inst()), sum(1 for _ in tb.each_inst())
if na != nb: bad.append(f"instances in top: {na} -> {nb}")
print("    XOR vs original: identical (geometry, labels, instances)" if not bad else "    XOR vs original: DIFFERENT\n      " + "\n      ".join(bad))
EOF

OLD_ITEMS=(netlist/run_sim.sh netlist/pex_c.sh netlist/pex_rc.sh netlist/env.sh netlist/collect.py
           netlist/compare.py netlist/results_dc netlist/flow pex_rc layout/backups)
declare -A SUMMARY

for CELL in "${CELLS[@]}"; do
  C=cells/$CELL; A=$C/archive; S=""
  echo; echo "################ $CELL"

  miss=""
  for f in schematic/$CELL.sch schematic/$CELL.sym schematic/tb_$CELL.sch layout/$CELL.gds sim/specs.txt; do
    [[ -f $C/$f ]] || miss="$miss $f"
  done
  [[ -n $miss ]] && { echo "  sources missing:$miss"; S="$S missing:$(echo $miss | wc -w)"; } || echo "  sources ok"

  for p in pex_rc netlist/results_dc netlist/flow layout/backups; do
    [[ -e $C/$p || -e $A/$p || -e $C/_manual/$(basename "$p") ]] && continue
    [[ $p == netlist/flow && -e $C/_manual/old_copy_flow ]] && continue
    [[ $p == layout/backups && -e $C/_manual/layout_backups ]] && continue
    ((HAS_GIT)) || continue
    src=""
    for c in $(git log --all --format=%h -- "$C/$p" "$C/_manual/$(basename "$p")" 2>/dev/null); do
      for q in "$C/$p" "$C/_manual/$(basename "$p")"; do
        [[ -n $(git ls-tree -r --name-only "$c" -- "$q" | head -1) ]] && { src="$c $q"; break 2; }
      done
    done
    [[ -z $src ]] && continue
    set -- $src
    echo "  $p missing on disk, found in git $1 ($2) -> restore into archive/$p"
    if ((APPLY)); then
      { git restore --source="$1" --worktree -- "$2" 2>/dev/null || git checkout "$1" -- "$2"; } && move "$2" "$A/$p"
      S="$S restored:$p"
    fi
  done

  PLANNED=0
  for p in "${OLD_ITEMS[@]}" "layout/$CELL.lvsdb" "layout/${CELL}_extracted.cir" layout/sky130_drc.txt _manual archive; do
    [[ -e $C/$p ]] && PLANNED=1
  done
  echo "  archive:"
  ((PLANNED)) || echo "    nothing to archive"
  for p in "${OLD_ITEMS[@]}"; do move "$C/$p" "$A/$p"; done
  for f in "$CELL.lvsdb" "${CELL}_extracted.cir" sky130_drc.txt; do move "$C/layout/$f" "$A/layout/$f"; done
  if [[ -d $C/_manual ]]; then
    for f in run_sim.sh pex_c.sh pex_rc.sh env.sh collect.py compare.py; do move "$C/_manual/$f" "$A/netlist/$f"; done
    move "$C/_manual/results_dc"     "$A/netlist/results_dc"
    move "$C/_manual/old_copy_flow"  "$A/netlist/flow"
    move "$C/_manual/layout_backups" "$A/layout/backups"
    for f in "$C"/_manual/gui_verify/*; do [[ -e $f ]] && move "$f" "$A/layout/$(basename "$f")"; done
    [[ -d $C/_manual/gui_verify ]] && act rmdir "$C/_manual/gui_verify" 2>/dev/null
    for f in "$CELL.spice" "tb_$CELL.spice"; do
      [[ -L $C/_manual/$f ]] && act rm "$C/_manual/$f"
    done
    if ((APPLY)); then
      if rmdir "$C/_manual" 2>/dev/null; then echo "    _manual/ now empty, folder removed"
      else echo "    _manual/ still holds files you added - left in place:"; ls -A "$C/_manual" | sed 's/^/      /'; fi
    fi
  fi
  if ((PLANNED)); then
    link "../../netlist/$CELL.spice"     "$A/netlist/$CELL.spice"
    link "../../netlist/tb_$CELL.spice"  "$A/netlist/tb_$CELL.spice"
    link "../../layout/$CELL.gds"        "$A/layout/$CELL.gds"
    for d in schematic sim pex verify; do link "../$d" "$A/$d"; done
    for s in "$A"/netlist/*.sh "$A"/netlist/*.py "$A"/netlist/flow/*.sh "$A"/netlist/flow/*.py \
             "$C"/netlist/*.sh "$C"/netlist/*.py "$C"/_manual/*.sh "$C"/_manual/*.py; do
      [[ -f $s && ! -L $s ]] || continue
      if grep -qE "/$C/(_manual|netlist|pex_rc)([/\"' ]|$)" "$s"; then
        act sed -i -E "s#/$C/_manual([/\"' ]|\$)#/$C/archive/netlist\1#g; s#/$C/netlist([/\"' ]|\$)#/$C/archive/netlist\1#g; s#/$C/pex_rc([/\"' ]|\$)#/$C/archive/pex_rc\1#g" "$s"
        echo "    absolute paths rewritten in $s"
      fi
    done
  fi

  G=$C/layout/$CELL.gds
  if ((HAS_KL)) && [[ -f $G ]]; then
    echo "  layout:"
    if ((APPLY)); then
      ORIG=$A/layout/${CELL}_before_tidy.gds
      mkdir -p "$A/layout"; [[ -e $ORIG ]] || cp -p "$G" "$ORIG"
      chmod u+w "$G"
      klayout -b -r "$GDSPY" -rd gds="$G" -rd top="$CELL" -rd fix=1
      x=$(klayout -b -r "$XORPY" -rd old="$ORIG" -rd new="$G" -rd top="$CELL" 2>&1); echo "$x"
      case $x in *identical*) S="$S gds=identical" ;; *) S="$S gds=CHECK" ;; esac
    else
      klayout -b -r "$GDSPY" -rd gds="$G" -rd top="$CELL" -rd fix=0
    fi
  fi

  TB=$C/schematic/tb_$CELL.sch; SYM=$C/schematic/$CELL.sym
  if [[ -f $TB && -f $SYM ]]; then
    ports=" $( { grep -o 'name=[][A-Za-z0-9_:]*' "$SYM" || true; } | cut -d= -f2 | tr 'A-Z' 'a-z' | sort -u | tr '\n' ' ')"
    probes=$( { grep -oi 'xdut\.[a-z0-9_#]*' "$TB" || true; } | cut -d. -f2 | tr 'A-Z' 'a-z' | sort -u)
    bad=""; for n in $probes; do case "$ports " in *" $n "*) ;; *) bad="$bad $n" ;; esac; done
    if [[ -n $bad ]]; then echo "  testbench: probes internal net(s):$bad  (post-layout will fail; send me tb + specs)"; S="$S tb-internal:$(echo $bad | tr ' ' ',')"
    else echo "  testbench: ports only, ok"; fi
  fi
  SUMMARY[$CELL]=${S:- ok}
done
rm -f "$GDSPY" "$XORPY"

OLDIGN=("cells/*/pex_rc/" "cells/*/netlist/results_dc/" "cells/*/netlist/flow/results/" "cells/*/layout/backups/"
        "cells/*/layout/*.lvsdb" "cells/*/layout/*_extracted.cir" "cells/*/layout/sky130_drc.txt"
        "cells/*/_manual/results_dc/" "cells/*/_manual/old_copy_flow/results/" "cells/*/_manual/layout_backups/"
        "cells/*/_manual/gui_verify/")
if [[ -f .gitignore ]]; then
  for p in "${OLDIGN[@]}"; do
    if grep -qxF "$p" .gitignore; then
      if ((APPLY)); then grep -vxF "$p" .gitignore > .gitignore.tmp && cat .gitignore.tmp > .gitignore && rm .gitignore.tmp
      else echo "  .gitignore: would drop rule $p (so archived results are versioned again)"; fi
    fi
  done
fi

echo; echo "================ summary $( ((APPLY)) && echo APPLY || echo DRY-RUN)"
for c in "${CELLS[@]}"; do printf '  %-30s%s\n' "$c" "${SUMMARY[$c]}"; done
((APPLY)) && echo "backup of everything before this run: $BK/cells.tgz"

if ((RUN)); then
  echo; echo "================ flow"
  for c in "${CELLS[@]}"; do
    r=$(./flow/run.sh "$c" 2>&1 | grep -E '^OVERALL' || echo "OVERALL: (no report)")
    printf '  %-30s%s\n' "$c" "$r"
  done
fi
