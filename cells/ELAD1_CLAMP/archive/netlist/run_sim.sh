#!/bin/bash
# usage: ./run_sim.sh <pre|postC|postRC> <netlist containing the subckt>
source ./env.sh >/dev/null
STAGE=$1; NET=$(readlink -f "$2"); OUT=results_dc/$STAGE
command -v ngspice >/dev/null || { echo "ngspice not found"; exit 1; }
[ -f "$NET" ] || { echo "netlist not found: $NET"; exit 1; }
for p in NODE CLR VGND; do echo " $PINS " | grep -q " $p " || { echo "pin $p not in [$PINS]"; exit 1; }; done
if [ "$STAGE" != "pre" ]; then
  # bulk (field 5) and gate (field 3) of the nfet must sit on pin nets once the .tN / .nN suffix is removed
  bad=$(awk '/^X/ && /nfet/ {print $5; print $3}' $NET | sed -E 's/\.[nt][0-9]+$//' | sort -u | grep -v -x -F -f <(echo $PINS | tr ' ' '\n'))
  if [ -n "$bad" ] && [ -z "$FORCE" ]; then
    echo "WARNING: nfet gate/bulk on non-pin net(s): $bad"
    echo "A gate not on CLR means the clamp is not controlled by the CLR pin in this netlist. Fix the extraction first, or run with FORCE=1."; exit 1
  fi
fi
rm -rf $OUT; mkdir -p $OUT/sweeps
for c in tt ss ff sf fs; do for t in -20 27 85; do
  tag=${c}_${t}; S=$OUT/sweeps
  { echo "* clamp $STAGE $tag"
    echo ".lib $LIB $c"
    echo ".include $NET"
    echo "XDUT $PINS $CELL"
    echo "VG0 VGND 0 0"; echo "VCLR CLR 0 1.8"; echo "VNODE NODE 0 0.9"
    echo ".option rshunt=1e12"; echo ".temp $t"
    echo ".control"; echo "set filetype=ascii"
    echo "dc VNODE 0 1.8 0.05"
    echo "wrdata $S/on_$tag.txt i(VNODE)"
    echo "alter VCLR dc=0"
    echo "dc VNODE 0 1.8 0.05"
    echo "wrdata $S/off_$tag.txt i(VNODE)"
    echo "alter VCLR dc=1.8"
    echo "alter VNODE dc=0.9"
    echo "dc VCLR 0 1.8 0.05"
    echo "wrdata $S/clr_$tag.txt i(VNODE)"
    echo "quit"; echo ".endc"; echo ".end"; } > $OUT/tb_$tag.spice
  ngspice -b $OUT/tb_$tag.spice > $OUT/log_$tag.txt 2>&1
done; done
python3 collect.py $STAGE || { echo "---- ngspice log (tt_27) ----"; grep -i -E "error|fatal|unknown|no such|not found" $OUT/log_tt_27.txt | head -10; tail -8 $OUT/log_tt_27.txt; }
