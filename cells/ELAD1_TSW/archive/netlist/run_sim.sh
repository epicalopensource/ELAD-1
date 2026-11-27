#!/bin/bash
# usage: ./run_sim.sh <pre|postC|postRC> <netlist containing the subckt>
source ./env.sh >/dev/null
STAGE=$1; NET=$(readlink -f "$2"); OUT=results_dc/$STAGE
command -v ngspice >/dev/null || { echo "ngspice not found"; exit 1; }
[ -f "$NET" ] || { echo "netlist not found: $NET"; exit 1; }
for p in A B EN ENB VDPWR VGND; do echo " $PINS " | grep -q " $p " || { echo "pin $p not in [$PINS]"; exit 1; }; done
if [ "$STAGE" != "pre" ]; then
  # extracted netlist must be flat: no ELAD1_TGA instances
  if awk '/^[Xx]/ && $NF ~ /^ELAD1_TGA/ {f=1} END{exit !f}' $NET && [ -z "$FORCE" ]; then echo "WARNING: $NET is hierarchical (calls ELAD1_TGA). Use the flat extraction (pex_rc.sh / pex_c.sh)."; exit 1; fi
  # pfet: gate ENB, bulk VDPWR.  nfet: gate EN (pass devices) or ENB (pull-down), bulk VGND.  Suffix .tN/.nN removed.
  bad=$(tr -d '\r' < $NET | awk '/^X/ && /fet/ {g=$3; b=$5; sub(/\.[nt][0-9]+$/,"",g); sub(/\.[nt][0-9]+$/,"",b);
        if ($0 ~ /pfet/) { if (g!="ENB") print $1" pfet gate="g; if (b!="VDPWR") print $1" pfet bulk="b }
        else { if (g!="EN" && g!="ENB") print $1" nfet gate="g; if (b!="VGND") print $1" nfet bulk="b } }')
  npd=$(tr -d '\r' < $NET | awk '/^X/ && /nfet/ {g=$3; sub(/\.[nt][0-9]+$/,"",g); if (g=="ENB") c++} END{print c+0}')
  [ "$npd" -eq 0 ] && bad="$bad
no nfet with gate on ENB (the pull-down of the mid node is missing or its gate is on another net)"
  if [ -n "$bad" ] && [ -z "$FORCE" ]; then
    echo "WARNING: wrong gate/bulk connections in this netlist:"; echo "$bad"
    echo "Fix the extraction first, or run with FORCE=1."; exit 1
  fi
fi
rm -rf $OUT; mkdir -p $OUT/sweeps
head_() { echo "* tsw $1 $2 $3"; echo ".lib $LIB $3"; echo ".include $NET"; echo "XDUT $PINS $CELL"
          echo "VDD VDPWR 0 1.8"; echo "VG0 VGND 0 0"; echo ".option rshunt=1e12"; echo ".temp $4"; }
for c in tt ss ff sf fs; do for t in -20 27 85; do
  tag=${c}_${t}; S=$OUT/sweeps
  # 1) R_on A-to-B through both TGA: EN=1.8, ENB=0, 0.1 V across A-B, common mode swept 0.05..1.75 V
  { head_ ron $STAGE $c $t; echo "VEN EN 0 1.8"; echo "VENB ENB 0 0"
    echo "VCM CM 0 0.9"; echo "EA A 0 vol='v(CM)+0.05'"; echo "EB B1 0 vol='v(CM)-0.05'"; echo "VSB B1 B 0"
    echo ".control"; echo "set filetype=ascii"; echo "dc VCM 0.05 1.75 0.01"; echo "wrdata $S/ron_$tag.txt i(VSB)"; echo "quit"; echo ".endc"; echo ".end"; } > $OUT/tb_ron_$tag.spice
  # 2) leakage: switch off (EN=0, ENB=1.8, pull-down on), A=1.8, B=0, current taken from A
  { head_ leak $STAGE $c $t; echo "VEN EN 0 0"; echo "VENB ENB 0 1.8"; echo "VA A 0 1.8"; echo "VB B 0 0"
    echo ".control"; echo "set filetype=ascii"; echo "dc VA 1.8 1.8 1"; echo "wrdata $S/leak_$tag.txt i(VA)"; echo "quit"; echo ".endc"; echo ".end"; } > $OUT/tb_leak_$tag.spice
  # 3) bandwidth: switch on, A = 0.9 V + AC 1, load 1 pF on B
  { head_ bw $STAGE $c $t; echo "VEN EN 0 1.8"; echo "VENB ENB 0 0"; echo "VA A 0 dc 0.9 ac 1"; echo "CL B 0 1p"
    echo ".control"; echo "ac dec 40 1e6 50e9"; echo "meas ac bw when vdb(B)=-3 fall=1"; echo "quit"; echo ".endc"; echo ".end"; } > $OUT/tb_bw_$tag.spice
  # 4) off isolation at 100 MHz: switch off (pull-down on), A = 0.9 V + AC 1, 1 kohm load on B
  { head_ iso $STAGE $c $t; echo "VEN EN 0 0"; echo "VENB ENB 0 1.8"; echo "VA A 0 dc 0.9 ac 1"; echo "RL B 0 1k"
    echo ".control"; echo "ac dec 40 1e6 50e9"; echo "meas ac iso find vdb(B) at=1e8"; echo "quit"; echo ".endc"; echo ".end"; } > $OUT/tb_iso_$tag.spice
  for an in ron leak bw iso; do ngspice -b $OUT/tb_${an}_$tag.spice > $OUT/log_${an}_$tag.txt 2>&1; done
done; done
python3 collect.py $STAGE || { echo "---- ngspice log (ron, tt_27) ----"; grep -i -E "error|fatal|unknown|no such|not found" $OUT/log_ron_tt_27.txt | head -10; tail -8 $OUT/log_ron_tt_27.txt; }
