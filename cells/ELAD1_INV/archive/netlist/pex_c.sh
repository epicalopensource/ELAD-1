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
echo "MOS devices: $(grep -c "^X" ${CELL}_pex_sub.spice)  caps: $(grep -c "^C" ${CELL}_pex_sub.spice)"
grep '^X' ${CELL}_pex_sub.spice | grep -o -E 'sky130_fd_pr__[a-z0-9_]+' | sort | uniq -c
echo "pins missing from the extracted netlist (want none):"
miss=0; for n in $PINS; do grep -q -F "$n" ${CELL}_pex_sub.spice || { echo "  MISSING $n"; miss=1; }; done; [ $miss = 0 ] && echo "  none - OK"
echo "pins tied to power by name check (VDPWR / VGND appear on devices):"
echo "  VDPWR: $(grep -c ' VDPWR' ${CELL}_pex_sub.spice)  VGND: $(grep -c ' VGND' ${CELL}_pex_sub.spice)"
