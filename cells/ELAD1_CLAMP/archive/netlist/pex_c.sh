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
echo "devices: $(grep -c '^X' ${CELL}_pex_sub.spice) (schematic has 1)  caps: $(grep -c '^C' ${CELL}_pex_sub.spice)"
echo "nfet lines (drain gate source bulk):"; grep '^X' ${CELL}_pex_sub.spice | awk '{print "  " $2, $3, $4, $5, $6}'
echo "nfet gate net (must be CLR) / bulk net (must be VGND):"; awk '/^X/ && /nfet/ {print "  gate " $3 "   bulk " $5}' ${CELL}_pex_sub.spice
echo "NET NAMES NOT IN PINS (want none):"
grep '^C' ${CELL}_pex_sub.spice | awk '{print $2; print $3}' | sort -u | grep -v -E '^[aw]_[0-9_]+#?$' | grep -v -x -F -f <(echo $PINS | tr ' ' '\n') || echo "  none - OK"
