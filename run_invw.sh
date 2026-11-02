#!/usr/bin/env bash
# usage: ./run_invw.sh cases.txt [corner] [temp] [vdd]     cases.txt lines: label WN WP L
[ -f "$1" ] || { echo "cases file $1 not found"; exit 1; }
CASES=$1; C=${2:-tt}; T=${3:-27}; V=${4:-1.8}; NET=tb_ELAD1_INV.spice; OUT=results_invw; mkdir -p $OUT
F=$OUT/$(basename $CASES .txt)_${C}_${T}_${V}.csv
echo "label,corner,temp,vdd,WN,WP,L,vm,voh,vol,gain_max,vil,vih,isc_pk,ileak,tphl,tplh,trise,tfall,pavg,ecyc" > $F
while read lab wn wp l; do
  [ -z "$lab" ] && continue
  case $lab in \#*) continue;; esac
  sed -e "s|^\(\.lib .*sky130.lib.spice\) .*|\1 $C|" \
      -e "s|^\.option temp=.*|.option temp=$T|" \
      -e "s|^\.param WN=.*|.param WN=$wn|" \
      -e "s|^\.param WP=.*|.param WP=$wp|" \
      -e "s|^\.param LEN=.*|.param LEN=$l|" \
      -e "s|^set vddv = .*|set vddv = $V|" \
      -e "s|^VDD VDPWR 0 .*|VDD VDPWR 0 $V|" \
      -e "s|PULSE(0 [0-9.]* |PULSE(0 $V |" $NET > run_invw.spice
  LG=$OUT/log_${lab}_${C}_${T}_${V}.txt
  ngspice -b run_invw.spice > $LG 2>&1
  S=$(grep '^SUM ' $LG | awk '{for(i=2;i<=NF;i++) printf "%s%s",(i>2?",":""),$i}')
  TT=$(grep '^SUMT ' $LG | awk '{for(i=2;i<=NF;i++) printf "%s%s",(i>2?",":""),$i}')
  echo "$lab,$C,$T,$V,$wn,$wp,$l,$S,$TT" >> $F
  mv tb_inv_tran $OUT/tran_${lab}_${C}_${T}_${V}.raw
  mv tb_inv_dc   $OUT/dc_${lab}_${C}_${T}_${V}.raw
done < $CASES
echo "wrote $F"
