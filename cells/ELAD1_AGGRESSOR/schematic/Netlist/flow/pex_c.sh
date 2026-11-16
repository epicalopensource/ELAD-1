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
echo "devices: $(grep -c '^X' ${CELL}_pex_sub.spice)  poly resistor segments: $(grep -c -E 'res_(xhigh|generic)' ${CELL}_pex_sub.spice)  caps: $(grep -c '^C' ${CELL}_pex_sub.spice)"
echo "PFET BULK NETS NOT PINS (want none - nwell must be tied to VDPWR):"
awk '/^X/ && /pfet/ {print $5}' ${CELL}_pex_sub.spice | sort -u | grep -v -x -F -f <(echo $PINS | tr ' ' '\n') || echo "  none - OK"
