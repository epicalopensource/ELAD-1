#!/bin/bash
# usage: ./run_sim.sh <pre|postC|postRC> <netlist containing the subckt>      (ALL=1 for 15 conditions, default 3)
source ./env.sh >/dev/null
STAGE=$1; NET=$(readlink -f "$2"); OUT=results_tr/$STAGE
command -v ngspice >/dev/null || { echo "ngspice not found"; exit 1; }
[ -f "$NET" ] || { echo "netlist not found: $NET"; exit 1; }
for p in clk rst_n ena 'ui_in[0]' 'ui_in[7]' 'status[0]' 'status[7]' hen agg_clk VDPWR VGND; do echo " $PINS " | grep -q -F " $p " || { echo "pin $p not in [$PINS]"; exit 1; }; done
if [ "$STAGE" != "pre" ]; then
  miss=""; for n in $PINS; do grep -q -F "$n" "$NET" || miss="$miss $n"; done
  [ -n "$miss" ] && { echo "pins not found anywhere in $NET:$miss"; exit 1; }
  echo "post netlist MOS devices: $(grep -c '^X' $NET)   (pre has $(python3 count.py $SCH | tail -1))"
fi
rm -rf $OUT; mkdir -p $OUT/sweeps
cp "$NET" $OUT/net.spice; NET=$PWD/$OUT/net.spice
for m in $(grep -o -E 'sky130_fd_pr__[a-z0-9_]+' $NET | sort -u); do
  grep -rqsw "$m" $PDK_ROOT/sky130A/libs.tech/ngspice && continue
  case $m in
    sky130_fd_pr__special_nfet_01v8) sed -i "s/$m/sky130_fd_pr__nfet_01v8/g" $NET; echo "note: $m not in the ngspice lib -> simulated as sky130_fd_pr__nfet_01v8 (same in every stage)";;
    *) echo "WARNING: model $m not found in the ngspice lib - the simulation will fail";;
  esac
done
python3 stim.py > $OUT/tend.txt; TEND=$(cat $OUT/tend.txt); mv stim.inc $OUT/stim.inc
NETS=$(for p in $PINS; do echo -n "$(echo $p | sed 's/\[/_/; s/\]//') "; done)
OUTS="en_mg en_mc en_pg en_pc en_n clr_mg clr_mc clr_pg clr_pc clr_n hen agg_clk status_7 status_6 status_5 status_4 status_3 status_2 status_1 status_0"
if [ -n "$ALL" ]; then CONDS="tt_27 tt_-20 tt_85 ss_27 ss_-20 ss_85 ff_27 ff_-20 ff_85 sf_27 sf_-20 sf_85 fs_27 fs_-20 fs_85"; else CONDS="tt_27 ss_85 ff_-20"; fi
for tag in $CONDS; do c=${tag%_*}; t=${tag#*_}; S=$OUT/sweeps
  { echo "* control $STAGE $tag"
    echo ".lib $LIB $c"
    echo ".include $NET"
    echo ".include $PWD/$OUT/stim.inc"
    echo "XDUT $NETS $CELL"
    echo "VG0 VGND 0 0"; echo "VDD VDPWR 0 $VDD"
    for o in $OUTS; do echo "CL_$o $o 0 ${CLOAD}f"; done
    echo ".option rshunt=1e12"; echo ".option reltol=1e-3"; echo ".temp $t"
    echo ".control"; echo "set filetype=ascii"; echo "set wr_singlescale"
    echo "tran ${STEP:-0.05n} ${TEND}n"
    echo "wrdata $S/out_$tag.txt $(for o in $OUTS; do echo -n "v($o) "; done)"
    echo "wrdata $S/idd_$tag.txt i(VDD)"
    echo "quit"; echo ".endc"; echo ".end"; } > $OUT/tb_$tag.spice
  echo "running $STAGE $tag ..."
  ( time ngspice -b $OUT/tb_$tag.spice > $OUT/log_$tag.txt 2>&1 ) 2>&1 | grep real
  [ -s $S/out_$tag.txt ] || { echo "  no waveform for $tag - log:"; grep -i -E "error|fatal|unknown|no such|not found|singular|timestep" $OUT/log_$tag.txt | head -8; tail -5 $OUT/log_$tag.txt; }
done
python3 collect.py $STAGE "$CONDS"
