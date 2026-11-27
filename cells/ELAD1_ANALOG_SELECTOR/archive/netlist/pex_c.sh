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
cp ${CELL}_pex_sub.spice ${CELL}_pex_sub_raw.spice
for n in $TIE_NET; do sed -i "/^\.ends/i * VIRTUAL TIE (post-LVS): $n to $TIE_TO\nVtie_nw $n $TIE_TO 0" ${CELL}_pex_sub.spice; done
echo "devices: $(grep -c '^X' ${CELL}_pex_sub.spice) (schematic has 74; more only if a device is split into fingers)  caps: $(grep -c '^C' ${CELL}_pex_sub.spice)"
echo "device types:"; grep '^X' ${CELL}_pex_sub.spice | grep -o -E 'sky130_fd_pr__[a-z0-9_]+' | sort | uniq -c
echo "pfet bulk nets (must be VDPWR):"; awk '/^X/ && /pfet/ {print $5}' ${CELL}_pex_sub.spice | sort | uniq -c
echo "nfet bulk nets (must be VGND):"; awk '/^X/ && /nfet/ {print $5}' ${CELL}_pex_sub.spice | sort | uniq -c
echo "NET NAMES NOT IN PINS (want only a_.. internal ENB nets, no w_.. nwell nets):"
grep '^C' ${CELL}_pex_sub.spice | awk '{print $2; print $3}' | sort -u | grep -v -E '^a_[0-9_]+#?$' | grep -v -x -F -f <(echo $PINS | tr ' ' '\n') || echo "  none - OK"
