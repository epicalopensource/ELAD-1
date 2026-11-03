#!/bin/bash
# ELAD1_MIRROR_CC : PEX (C and R+C) -> pre / post-C / post-RC DC over PVT -> CSV
CELL=ELAD1_MIRROR_CC
TOP=$(pwd)
RC=${PDK_ROOT:-/foss/pdks}/sky130A/libs.tech/magic/sky130A.magicrc
TB=$TOP/netlist/tb_$CELL.spice
OUT=$TOP/netlist/results_dc
mkdir -p $TOP/pex $TOP/pex_rc $OUT

# ---- 0. sanity check on the testbench ----
for p in '\.option temp' 'sky130\.lib\.spice' 'set iref' "\.subckt $CELL"; do
  grep -qi "$p" $TB || { echo "TB is missing: $p"; exit 1; }
done

# ---- 1. wrap a Magic spice into a clean subckt (no FLOATING lines) ----
wrap() {  # $1 = magic spice  $2 = output
  { echo ".subckt $CELL REF OUT VGND"
    grep -viE '^\.(subckt|ends|end)|FLOATING|^\*' $1
    echo ".ends"; } > $2
}

# ---- 2. PEX, C only ----
cd $TOP/pex
cat > run_pex.tcl <<TCL
gds read ../layout/$CELL.gds
load $CELL
select top cell
extract do local
extract all
ext2spice cthresh 0
ext2spice -o ${CELL}_pex.spice
quit -noprompt
TCL
magic -dnull -noconsole -rcfile $RC run_pex.tcl > pex.log 2>&1
wrap ${CELL}_pex.spice ${CELL}_pex_sub.spice

# ---- 3. PEX, R + C ----
cd $TOP/pex_rc
cat > run_pex_rc.tcl <<TCL
gds read ../layout/$CELL.gds
load $CELL
flatten ${CELL}_flat
load ${CELL}_flat
select top cell
extract do local
extract all
ext2sim labels on
ext2sim
extresist tolerance 1
extresist
ext2spice cthresh 0
ext2spice rthresh 0
ext2spice extresist on
ext2spice -o ${CELL}_rc.spice
quit -noprompt
TCL
magic -dnull -noconsole -rcfile $RC run_pex_rc.tcl > pex_rc.log 2>&1
wrap ${CELL}_rc.spice ${CELL}_rc_sub.spice
cd $TOP/netlist
echo "devices/caps/res in C pex:  $(grep -c '^[Xx]' ../pex/${CELL}_pex_sub.spice) / $(grep -c '^[Cc]' ../pex/${CELL}_pex_sub.spice) / $(grep -c '^[Rr]' ../pex/${CELL}_pex_sub.spice)"
echo "devices/caps/res in RC pex: $(grep -c '^[Xx]' ../pex_rc/${CELL}_rc_sub.spice) / $(grep -c '^[Cc]' ../pex_rc/${CELL}_rc_sub.spice) / $(grep -c '^[Rr]' ../pex_rc/${CELL}_rc_sub.spice)"

# ---- 4. build post-layout testbenches ----
mk_post() {  # $1 = out tb  $2 = pex sub file
  awk -v c="$CELL" 'BEGIN{s=0} tolower($0) ~ "^\\.subckt "tolower(c){s=1} s==0{print} tolower($0) ~ /^\.ends/ && s==1{s=0}' $TB > $1
  sed -i "1a .include $2" $1
}
mk_post tb_${CELL}_postC.spice  $TOP/pex/${CELL}_pex_sub.spice
mk_post tb_${CELL}_postRC.spice $TOP/pex_rc/${CELL}_rc_sub.spice

# ---- 5. DC over PVT ----
echo "stage,corner,temp_C,iref_uA,vref_V,iout_uA,err_pct,i_at_ref_A,v99_V,i_0p9_A,rout_ohm" > $OUT/dc.csv
run_stage() {  # $1 = stage name  $2 = tb
  for C in tt ss ff sf fs; do for T in -20 27 85; do for I in 1 2 5 10 20; do
    f=_run_$1.spice
    sed -E -e "s/(\.option temp *= *)[-0-9.]+/\1$T/I" \
           -e "s#(\.lib .*sky130\.lib\.spice) +[a-z]{2}#\1 $C#I" \
           -e "s/^(set iref *= *).*/\1${I}e-6/" \
           -e 's/^echo OP .*/echo OP $vrefs $\&iout $\&err_pct/' \
           -e 's/^write .*\.raw//' $2 > $f
    log=$(ngspice -b $f 2>&1)
    op=$(echo "$log" | grep '^OP ' | tail -1)
    sw=$(echo "$log" | grep '^SWEEP ' | tail -1)
    echo "$1,$C,$T,$I,$(echo $op | awk '{print $2","$3","$4}'),$(echo $sw | awk '{print $2","$3","$4","$5}')" >> $OUT/dc.csv
  done; done; done
  echo "stage $1 done"
}
run_stage pre   $TB
run_stage postC  tb_${CELL}_postC.spice
run_stage postRC tb_${CELL}_postRC.spice
rm -f _run_*.spice
echo "DONE -> $OUT/dc.csv"
echo "rows: $(($(wc -l < $OUT/dc.csv)-1)) (expect 225)"
