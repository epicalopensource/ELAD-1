#!/bin/bash
# usage: ./run_sim.sh <pre|postC|postRC> <netlist containing the subckt>
source ./env.sh >/dev/null
STAGE=$1; NET=$(readlink -f "$2"); OUT=results/$STAGE
command -v ngspice >/dev/null || { echo "ngspice not found"; exit 1; }
[ -f "$NET" ] || { echo "netlist not found: $NET"; exit 1; }
for p in AGG_CLK EN VDPWR VGND SUBI; do echo " $PINS " | grep -q " $p " || { echo "pin $p not in [$PINS]"; exit 1; }; done
if [ "$STAGE" != "pre" ]; then
  bad=$(awk '/^X/ && /pfet/ {print $5}' $NET | sort -u | grep -v -x -F -f <(echo $PINS | tr ' ' '\n'))
  if [ -n "$bad" ] && [ -z "$FORCE" ]; then
    echo "WARNING: pfet bulk is on non-pin net(s): $bad"
    echo "The nwell is not tied to VDPWR in this netlist. Fix the layout (or tie it) first, or run with FORCE=1."; exit 1
  fi
fi
rm -rf $OUT; mkdir -p $OUT/sweeps
for c in tt ss ff sf fs; do for t in -20 27 85; do
  tag=${c}_${t}; S=$OUT/sweeps
  { echo "* aggressor $STAGE $tag"
    echo ".lib $LIB $c"
    echo ".include $NET"
    echo "XDUT $PINS $CELL"
    echo "VDD VDPWR 0 1.8"; echo "VG0 VGND 0 0"; echo "VEN EN 0 1.8"
    echo "VSUB SUBI 0 0"
    echo "VCLK AGG_CLK 0 PULSE(0 1.8 1n 100p 100p 4.9n 10n)"
    echo ".option rshunt=1e12"; echo ".temp $t"
    echo ".control"; echo "set filetype=ascii"
    echo "tran 10p 60n"
    echo "wrdata $S/on_$tag.txt v(AGG_CLK) i(VSUB) i(VDD)"
    echo "alter VEN dc=0"
    echo "tran 10p 60n"
    echo "wrdata $S/off_$tag.txt v(AGG_CLK) i(VSUB) i(VDD)"
    echo "quit"; echo ".endc"; echo ".end"; } > $OUT/tb_$tag.spice
  ngspice -b $OUT/tb_$tag.spice > $OUT/log_$tag.txt 2>&1
done; done
python3 collect.py $STAGE
