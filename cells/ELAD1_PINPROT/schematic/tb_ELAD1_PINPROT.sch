v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -120 120 -100 120 {}
N -100 120 -80 120 {}
N -240 120 -240 140 {}
N -240 120 -120 120 {}
N 80 120 100 120 {}
N 100 120 120 120 {}
N -120 350 -120 370 {}
N -240 350 -120 350 {}
C {ELAD1_PINPROT.sym} 0 120 0 0 {name=XDUT}
C {devices/lab_pin.sym} -100 120 0 0 {name=l1 sig_type=std_logic lab=PAD}
C {devices/vsource.sym} -240 170 0 0 {name=VPAD value=0.9}
C {devices/gnd.sym} -240 200 0 0 {name=l2 lab=0 global=false}
C {devices/lab_pin.sym} 100 120 0 1 {name=l3 sig_type=std_logic lab=CORE}
C {devices/vdd.sym} 0 60 0 0 {name=l4 lab=VDPWR global=false}
C {devices/gnd.sym} 0 180 0 0 {name=l5 lab=0 global=false}
C {devices/vdd.sym} -240 350 0 0 {name=l6 lab=VDPWR global=false}
C {devices/vsource.sym} -120 400 0 0 {name=VDD value=1.8}
C {devices/gnd.sym} -120 430 0 0 {name=l7 lab=0 global=false}
T {tb_ELAD1_PINPROT - secondary ESD diodes of one analog pin.} -280 -175 0 0 0.4 0.4 {}
T {Normal range (0..1.8 V): leakage must be negligible. Outside the rails the diodes clamp:
PAD at -0.6 V forward-biases DN (to VGND), PAD at 2.4 V forward-biases DP (to VDPWR).
CORE has no other load: it must follow PAD (PAD and CORE are the same metal net).} -280 -130 0 0 0.22 0.22 {}
C {devices/code_shown.sym} 320 200 0 0 {name=s1 only_toplevel=false value=".control
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
C {sky130_fd_pr/corner.sym} 320 0 0 0 {name=CORNER only_toplevel=true corner=tt}
