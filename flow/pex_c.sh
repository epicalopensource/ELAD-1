#!/bin/bash
source ./env.sh >/dev/null
rm -rf pex; mkdir -p pex && cd pex
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
echo "devices: $(grep -c '^X' ${CELL}_pex_sub.spice)  caps: $(grep -c '^C' ${CELL}_pex_sub.spice)"
echo "device types:"
grep '^X' ${CELL}_pex_sub.spice | grep -o -E 'sky130_fd_pr__[a-z0-9_]+' | sort | uniq -c
echo "nfet bulk nets (must be VGND):"; awk '/^X/ && /nfet/ {print $5}' ${CELL}_pex_sub.spice | sort | uniq -c
echo "resistor body nets (must be VGND):"; awk '/^X/ && /res_/ {print $4}' ${CELL}_pex_sub.spice | sort | uniq -c
echo "NET NAMES NOT IN PINS (want none, or only the internal heater node):"
grep '^C' ${CELL}_pex_sub.spice | awk '{print $2; print $3}' | sort -u | grep -v -E '^[aw]_[0-9_]+#?$' | grep -v -x -F -f <(echo $PINS | tr ' ' '\n') || echo "  none - OK"
