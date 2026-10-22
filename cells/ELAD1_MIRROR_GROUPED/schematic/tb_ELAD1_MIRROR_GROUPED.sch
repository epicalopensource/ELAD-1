v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/isource.sym} 0 0 2 1 {name=IREF value="DC 5u"}
C {devices/vsource.sym} 240 0 0 0 {name=VOUT value=0.6}
C {ELAD1_MIRROR_GROUPED.sym} 800 0 0 0 {name=XDUT}
N 0 70 240 70 {lab=0}
N 0 30 0 70 {lab=0}
N 240 30 240 70 {lab=0}
C {devices/gnd.sym} 0 70 0 0 {name=l1 lab=0 global=false}
N 880 -10 900 -10 {lab=0}
C {devices/lab_pin.sym} 900 -10 0 1 {name=l2 sig_type=std_logic lab=0}
N 240 -30 240 -70 {lab=OUT}
N 720 10 700 10 {lab=OUT}
N 700 10 700 -70 {lab=OUT}
N 240 -70 700 -70 {lab=OUT}
C {devices/lab_pin.sym} 240 -70 0 0 {name=l3 sig_type=std_logic lab=OUT}
N 0 -30 0 -50 {lab=REF}
N 0 -50 -20 -50 {lab=REF}
N -20 -50 -20 80 {lab=REF}
N 720 -10 680 -10 {lab=REF}
N 680 -10 680 80 {lab=REF}
N -20 80 680 80 {lab=REF}
C {devices/lab_pin.sym} -20 80 0 0 {name=l4 sig_type=std_logic lab=REF}
C {devices/code_shown.sym} -400 -500 0 0 {name=s1 only_toplevel=false value=".control
op
let vref = v(REF)
print vref
set vrefs = $&vref
alter VOUT dc = $vrefs
op
let iout = -i(VOUT)
let err_pct = 100*(iout-5e-6)/5e-6
print iout err_pct
dc VOUT 0 1.8 0.002
let io = -i(VOUT)
meas dc i_at_ref find io at=$vrefs
let i99 = 0.99*i_at_ref
meas dc v_out_99pct find v(OUT) when io=i99 cross=1
meas dc i_0p9 find io at=0.9
let rout_ohm = (0.9-$vrefs)/(i_0p9-i_at_ref)
print rout_ohm
write tb_ELAD1_MIRROR_GROUPED.raw
.endc"}
C {sky130_fd_pr/corner.sym} -400 -700 0 0 {name=CORNER only_toplevel=true corner=tt}
T {tb_ELAD1_MIRROR_GROUPED - 1:1 mirror ratio at matched drain voltage, and output compliance.
IREF forces 5 uA into REF. VOUT is first set to V(REF) (equal VDS, as the chip's Kelvin
servo does), then swept 0..1.8 V for the output characteristic.
err_pct = 100*(IOUT-IREF)/IREF (nominal models: systematic error only).
v_out_99pct = VOUT where IOUT has fallen to 99 % of its value at VOUT = V(REF) (package
definition of compliance); rout_ohm = output resistance between V(REF) and 0.9 V.} -400 -1070 0 0 0.4 0.4 {}
