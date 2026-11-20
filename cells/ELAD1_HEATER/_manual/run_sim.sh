#!/bin/bash
# usage: ./run_sim.sh <pre|postC|postRC> <netlist containing the subckt>
source ./env.sh >/dev/null
STAGE=$1; NET=$(readlink -f "$2"); OUT=results_dc/$STAGE
command -v ngspice >/dev/null || { echo "ngspice not found"; exit 1; }
[ -f "$NET" ] || { echo "netlist not found: $NET"; exit 1; }
for p in HIN HEN VGND; do echo " $PINS " | grep -q " $p " || { echo "pin $p not in [$PINS]"; exit 1; }; done
if [ "$STAGE" != "pre" ]; then
  # nfet: gate HEN, bulk VGND.  poly resistor body (3rd terminal) VGND.  Suffix .tN / .nN removed.
  bad=$(tr -d '\r' < $NET | awk '/^X/ && /nfet/ {g=$3; b=$5; sub(/\.[nt][0-9]+$/,"",g); sub(/\.[nt][0-9]+$/,"",b); if (g!="HEN") print $1" nfet gate="g; if (b!="VGND") print $1" nfet bulk="b}
                                 /^X/ && /res_/ {b=$4; sub(/\.[nt][0-9]+$/,"",b); if (b!="VGND") print $1" resistor body="b}')
  if [ -n "$bad" ] && [ -z "$FORCE" ]; then
    echo "WARNING: wrong connections in this netlist:"; echo "$bad"
    echo "Fix the layout/extraction first, or run with FORCE=1."; exit 1
  fi
fi
rm -rf $OUT; mkdir -p $OUT/sweeps
STEP=$(python3 -c "print($HIN_V/36)")
for c in tt ss ff sf fs; do for t in -20 27 85; do
  tag=${c}_${t}; S=$OUT/sweeps
  { echo "* heater $STAGE $tag"
    echo ".lib $LIB $c"
    echo ".include $NET"
    echo "XDUT $PINS $CELL"
    echo "VG0 VGND 0 0"; echo "VHEN HEN 0 1.8"; echo "VHIN HIN 0 $HIN_V"
    echo ".option rshunt=1e12"; echo ".temp $t"
    echo ".control"; echo "set filetype=ascii"
    echo "dc VHIN 0 $HIN_V $STEP"
    echo "wrdata $S/on_$tag.txt i(VHIN)"
    echo "alter VHEN dc=0"
    echo "dc VHIN 0 $HIN_V $STEP"
    echo "wrdata $S/off_$tag.txt i(VHIN)"
    echo "alter VHEN dc=1.8"
    echo "alter VHIN dc=$HIN_V"
    echo "dc VHEN 0 1.8 0.05"
    echo "wrdata $S/hen_$tag.txt i(VHIN)"
    echo "quit"; echo ".endc"; echo ".end"; } > $OUT/tb_$tag.spice
  ngspice -b $OUT/tb_$tag.spice > $OUT/log_$tag.txt 2>&1
done; done
python3 collect.py $STAGE || { echo "---- ngspice log (tt_27) ----"; grep -i -E "error|fatal|unknown|no such|not found|warning" $OUT/log_tt_27.txt | head -10; tail -8 $OUT/log_tt_27.txt; }
