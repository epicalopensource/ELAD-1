v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/vsource.sym} 0 0 0 0 {name=VDD value=1.8}
C {devices/vsource.sym} 240 0 0 0 {name=VPAD value=0.9}
C {ELAD1_PINPROT.sym} 800 0 0 0 {name=XDUT}
N 0 -30 0 -50 {lab=VDPWR}
C {devices/vdd.sym} 0 -50 0 0 {name=l1 lab=VDPWR global=false}
N 0 70 240 70 {lab=0}
N 0 30 0 70 {lab=0}
N 240 30 240 70 {lab=0}
C {devices/gnd.sym} 0 70 0 0 {name=l2 lab=0 global=false}
N 880 -10 900 -10 {lab=VDPWR}
C {devices/lab_pin.sym} 900 -10 0 1 {name=l3 sig_type=std_logic lab=VDPWR}
N 880 10 900 10 {lab=0}
C {devices/lab_pin.sym} 900 10 0 1 {name=l4 sig_type=std_logic lab=0}
N 720 10 700 10 {lab=CORE}
C {devices/lab_pin.sym} 700 10 0 0 {name=l5 sig_type=std_logic lab=CORE}
N 240 -30 240 -70 {lab=PAD}
N 720 -10 700 -10 {lab=PAD}
N 700 -10 700 -70 {lab=PAD}
N 240 -70 700 -70 {lab=PAD}
C {devices/lab_pin.sym} 240 -70 0 0 {name=l6 sig_type=std_logic lab=PAD}
C {devices/code_shown.sym} -400 -420 0 0 {name=s1 only_toplevel=false value=".control
op
let i_leak = abs(i(VPAD))
let v_core_err = abs(v(CORE)-v(PAD))
print i_leak v_core_err
alter VPAD dc = -0.6
op
let i_clamp_neg = abs(i(VPAD))
print i_clamp_neg
alter VPAD dc = 2.4
op
let i_clamp_pos = abs(i(VPAD))
print i_clamp_pos
dc VPAD -0.8 2.6 0.01
write tb_ELAD1_PINPROT.raw
.endc"}
C {sky130_fd_pr/corner.sym} -400 -620 0 0 {name=CORNER only_toplevel=true corner=tt}
T {tb_ELAD1_PINPROT - secondary ESD diodes of one analog pin.
Normal range (0..1.8 V): leakage must be negligible. Outside the rails the diodes clamp:
PAD at -0.6 V forward-biases DN (to VGND), PAD at 2.4 V forward-biases DP (to VDPWR).
CORE has no other load: it must follow PAD (PAD and CORE are the same metal net).} -400 -940 0 0 0.4 0.4 {}
