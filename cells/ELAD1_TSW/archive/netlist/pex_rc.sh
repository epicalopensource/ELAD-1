#!/bin/bash
source ./env.sh >/dev/null
[ -n "$GDS" ] || { echo "GDS not found under $CELLDIR - export it from KLayout first"; exit 1; }
rm -rf ../pex_rc; mkdir -p ../pex_rc; cd ../pex_rc
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
ext2sim labels on
ext2sim
extresist tolerance 0
extresist threshold 0
extresist mindelay 0
extresist minres 0
extresist all
ext2spice cthresh 0
ext2spice rthresh 0
ext2spice extresist on
ext2spice -o ${CELL}_rc.spice
quit -noprompt
TCL
magic -dnull -noconsole -rcfile $MAGICRC run.tcl > pex_rc.log 2>&1
grep -E "Total Nets|Nets extracted" pex_rc.log
[ -f ${CELL}_rc.spice ] || { echo "no netlist produced - see ../pex_rc/pex_rc.log"; exit 1; }
{ echo ".subckt $CELL $PINS"
  grep -v '^\*' ${CELL}_rc.spice | grep -v -i '^\.end' | grep -v -i '^\.subckt' | sed 's/\*\*[Ff][Ll][Oo][Aa][Tt][Ii][Nn][Gg].*$//'
  echo ".ends"; } > ${CELL}_rc_sub.spice
echo "devices: $(grep -c '^X' ${CELL}_rc_sub.spice)   hierarchical instances (want 0): $(awk '/^[Xx]/ && $NF ~ /^ELAD1_TGA/' ${CELL}_rc_sub.spice | wc -l)"
for n in $PINS; do echo "wire resistors on $n: $(grep -E "^R[0-9]+ $n[. ]" ${CELL}_rc_sub.spice | wc -l)"; done
echo "total wire resistors: $(grep -c '^R' ${CELL}_rc_sub.spice)"
echo "largest wire R (ohm):"; grep '^R' ${CELL}_rc_sub.spice | sort -k4 -g | tail -2
echo "device count by type / gate / bulk (suffix removed; pfet: ENB VDPWR, pass nfet: EN VGND, pull-down nfet: ENB VGND):"
grep '^X' ${CELL}_rc_sub.spice | awk '{t=($0 ~ /pfet/)?"pfet":"nfet"; print t, "gate=" $3, "bulk=" $5}' | sed -E 's/\.[nt][0-9]+//g' | sort | uniq -c
echo "NET NAMES NOT IN PINS (the mid node M is expected here if the layout labels it):"
grep -E '^[CR]' ${CELL}_rc_sub.spice | awk '{print $2; print $3}' | sed -E 's/\.[nt][0-9]+$//' | sort -u | grep -v -E '^[aw]_[0-9_]+#?$' | grep -v -x -F -f <(echo $PINS | tr ' ' '\n') || echo "  none"
