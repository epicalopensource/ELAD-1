v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {tb_ELAD1_MIRROR_CC - 1:1 mirror ratio at matched drain voltage, and output compliance.} -460 -220 0 0 0.4 0.4 {}
T {IREF forces 5 uA into REF. VOUT is first set to V(REF) (equal VDS, as the chip's Kelvin
servo does), then swept 0..1.8 V for the output characteristic.
err_pct = 100*(IOUT-IREF)/IREF (nominal models: systematic error only).
v_out_99pct = VOUT where IOUT has fallen to 99 % of its value at VOUT = V(REF) (package
definition of compliance); rout_ohm = output resistance between V(REF) and 0.9 V.} -460 -175 0 0 0.22 0.22 {}
N -120 100 -100 100 {lab=OUT}
N -100 100 -80 100 {lab=OUT}
N -240 100 -240 120 {lab=OUT}
N -240 100 -120 100 {lab=OUT}
N -300 60 -190 60 {lab=REF}
N -190 60 -80 60 {lab=REF}
N -420 60 -420 80 {lab=REF}
N -420 60 -300 60 {lab=REF}
C {ELAD1_MIRROR_CC.sym} 0 80 0 0 {name=XDUT}
C {devices/lab_pin.sym} -100 100 0 0 {name=l1 sig_type=std_logic lab=OUT}
C {devices/vsource.sym} -240 150 0 0 {name=VOUT value=0.6}
C {devices/gnd.sym} -240 180 0 0 {name=l2 lab=0 global=false}
C {devices/lab_pin.sym} -190 60 0 0 {name=l3 sig_type=std_logic lab=REF}
C {devices/isource.sym} -420 110 2 0 {name=IREF value="DC 5u"}
C {devices/gnd.sym} -420 140 0 0 {name=l4 lab=0 global=false}
C {devices/gnd.sym} 0 140 0 0 {name=l5 lab=0 global=false}
C {devices/code_shown.sym} 200 200 0 0 {name=s1 only_toplevel=false value=".control
set iref = 5e-6
alter IREF dc = $iref
op
let vref = v(REF)
print vref
set vrefs = $&vref
alter VOUT dc = $vrefs
op
let iout = -i(VOUT)
let err_pct = 100*(iout-$iref)/$iref
print err_pct
echo OP $vrefs $&iout $&err_pct
dc VOUT 0 1.8 0.002
let io = -i(VOUT)
meas dc i_at_ref find io at=$vrefs
let i99 = 0.99*i_at_ref
meas dc v_out_99pct find v(OUT) when io=i99 cross=1
meas dc i_0p9 find io at=0.9
let rout_ohm = (0.9-$vrefs)/(i_0p9-i_at_ref)
print rout_ohm
echo SWEEP $&i_at_ref $&v_out_99pct $&i_0p9 $&rout_ohm
write tb_ELAD1_MIRROR_CC_pre.raw
.endc"}
C {sky130_fd_pr/corner.sym} 200 0 0 0 {name=CORNER only_toplevel=true corner=tt}
