#!/bin/bash
source ./env.sh >/dev/null
rm -rf pex_rc; mkdir -p pex_rc; cd pex_rc
mk_tail() { cat <<TCL
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
}
{ echo "gds read $GDS"; echo "load $CELL"; echo "select top cell"; echo "port makeall"
  echo "flatten ${CELL}_flat"; echo "load ${CELL}_flat"; echo "select top cell"; mk_tail; } > runA.tcl
{ echo "gds read $GDS"; echo "load $CELL"; echo "select top cell"; echo "port makeall"; mk_tail; } > runB.tcl
best=""; bestn=-1
for m in A B; do
  mkdir -p m$m; cp run$m.tcl m$m/run.tcl
  ( cd m$m; magic -dnull -noconsole -rcfile $MAGICRC run.tcl > pex_rc.log 2>&1 )
  tot=$(grep -E "Total Nets" m$m/pex_rc.log | grep -o '[0-9]\+' | tail -1); tot=${tot:-0}
  ext=$(grep -E "Nets extracted" m$m/pex_rc.log | grep -o '[0-9]\+' | tail -1); ext=${ext:-0}
  echo "method $m: Total Nets $tot, Nets extracted $ext"
  if [ -f m$m/${CELL}_rc.spice ] && [ "$ext" -gt "$bestn" ]; then best=$m; bestn=$ext; fi
done
[ -z "$best" ] && { echo "no netlist produced - see mA/pex_rc.log"; exit 1; }
echo "using method $best"
cp m$best/pex_rc.log pex_rc.log
{ echo ".subckt $CELL $PINS"
  grep -v '^\*' m$best/${CELL}_rc.spice | grep -v -i '^\.end' | grep -v -i '^\.subckt' | sed 's/\*\*[Ff][Ll][Oo][Aa][Tt][Ii][Nn][Gg].*$//'
  echo ".ends"; } > ${CELL}_rc_sub.spice
echo "devices: $(grep -c '^X' ${CELL}_rc_sub.spice)"
for n in $PINS; do echo "wire resistors on $n: $(grep -E "^R[0-9]+ $n[. ]" ${CELL}_rc_sub.spice | wc -l)"; done
echo "largest wire R (ohm):"; grep '^R' ${CELL}_rc_sub.spice | sort -k4 -g | tail -2
echo "PFET BULK NETS NOT PINS (want none - nwell must be tied to VDPWR):"
awk '/^X/ && /pfet/ {print $5}' ${CELL}_rc_sub.spice | sort -u | grep -v -x -F -f <(echo $PINS | tr ' ' '\n') || echo "  none - OK"
