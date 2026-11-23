#!/bin/bash
source ./env.sh >/dev/null
[ -n "$GDS" ] || { echo "GDS not found under $CELLDIR - export it from KLayout first"; exit 1; }
rm -rf ../pex; mkdir -p ../pex && cd ../pex
cat > run.tcl <<TCL
gds read $GDS
load $CELL
select top cell
port makeall
flatten ${CELL}_flat
load ${CELL}_flat
select top cell
extract do local
extract all
ext2spice cthresh 0
ext2spice -o ${CELL}_pex.spice
quit -noprompt
TCL
magic -dnull -noconsole -rcfile $MAGICRC run.tcl > magic.log 2>&1
{ echo ".subckt $CELL $PINS"
  grep -v '^\*' ${CELL}_pex.spice | grep -v -i '^\.end' | grep -v -i '^\.subckt' | sed 's/\*\*[Ff][Ll][Oo][Aa][Tt][Ii][Nn][Gg].*$//'
  echo ".ends"; } > ${CELL}_pex_sub.spice
echo "devices: $(grep -c '^X' ${CELL}_pex_sub.spice) (schematic: 4 pfet lvt + 4 nfet lvt after fingers, 1 pull-down nfet; Magic splits wide devices)  caps: $(grep -c '^C' ${CELL}_pex_sub.spice)"
echo "hierarchical instances (want 0): $(awk '/^[Xx]/ && $NF ~ /^ELAD1_TGA/' ${CELL}_pex_sub.spice | wc -l)"
echo "device count by type / gate / bulk (pfet: ENB VDPWR, pass nfet: EN VGND, pull-down nfet: ENB VGND):"
grep '^X' ${CELL}_pex_sub.spice | awk '{t=($0 ~ /pfet/)?"pfet":"nfet"; print t, "gate=" $3, "bulk=" $5}' | sort | uniq -c
echo "NET NAMES NOT IN PINS (the mid node M is expected here if the layout labels it):"
grep '^C' ${CELL}_pex_sub.spice | awk '{print $2; print $3}' | sort -u | grep -v -E '^[aw]_[0-9_]+#?$' | grep -v -x -F -f <(echo $PINS | tr ' ' '\n') || echo "  none"
