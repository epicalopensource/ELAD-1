#!/bin/bash
# usage: ./run_sim.sh <pre|postC|postRC> <netlist containing the subckt>
source ./env.sh >/dev/null
STAGE=$1; NET=$(readlink -f "$2"); OUT=results/$STAGE
command -v ngspice >/dev/null || { echo "ngspice not found"; exit 1; }
[ -f "$NET" ] || { echo "netlist not found: $NET"; exit 1; }
for p in A B EN ENB VDPWR VGND; do echo " $PINS " | grep -q " $p " || { echo "pin $p not in [$PINS]"; exit 1; }; done
rm -rf $OUT; mkdir -p $OUT/sweeps
hdr() {
  echo "* $1"; echo ".lib $LIB $c"; echo ".include $NET"; echo "XDUT $PINS $CELL"
  echo "VDD VDPWR 0 1.8"; echo "VG0 VGND 0 0"
  for p in $PINS; do case $p in A|B|EN|ENB|VDPWR|VGND) ;; *) echo "VT_$p $p 0 0";; esac; done
  echo ".option rshunt=1e12"; echo ".temp $t"; }
for c in tt ss ff sf fs; do for t in -20 27 85; do
  S=$OUT/sweeps; tag=${c}_${t}
  { hdr "TGA dc $STAGE $tag"
    echo "VEN EN 0 1.8"; echo "VENB ENB 0 0"
    echo "VC cm 0 0.9"; echo "VA A cm 0.005"; echo "VB B cm -0.005"
    echo ".control"; echo "set filetype=ascii"
    echo "dc VC 0.05 1.75 0.01"; echo "let ia = -i(VA)"; echo "wrdata $S/ron_$tag.txt ia"
    echo "alter VEN dc=0"; echo "alter VENB dc=1.8"
    echo "alter VA dc=0.9"; echo "alter VB dc=-0.9"
    echo "dc VC 0.9 0.9 1"; echo "let il = -i(VA)"; echo "wrdata $S/leak1_$tag.txt il"
    echo "alter VA dc=-0.9"; echo "alter VB dc=0.9"
    echo "dc VC 0.9 0.9 1"; echo "let il = -i(VA)"; echo "wrdata $S/leak2_$tag.txt il"
    echo "quit"; echo ".endc"; echo ".end"; } > $OUT/tb_dc_$tag.spice
  ngspice -b $OUT/tb_dc_$tag.spice > $OUT/log_dc_$tag.txt 2>&1
  { hdr "TGA ac $STAGE $tag"
    echo "VEN EN 0 1.8"; echo "VENB ENB 0 0"
    echo "VIN A 0 0.9 AC 1"; echo "CL B 0 1p"
    echo ".control"; echo "set filetype=ascii"
    echo "ac dec 40 1e3 1e11"; echo "let g = vdb(B)"; echo "wrdata $S/acon_$tag.txt g"
    echo "alter VEN dc=0"; echo "alter VENB dc=1.8"
    echo "ac dec 40 1e3 1e11"; echo "let g = vdb(B)"; echo "wrdata $S/acoff_$tag.txt g"
    echo "quit"; echo ".endc"; echo ".end"; } > $OUT/tb_ac_$tag.spice
  ngspice -b $OUT/tb_ac_$tag.spice > $OUT/log_ac_$tag.txt 2>&1
done; done
python3 collect.py $STAGE
