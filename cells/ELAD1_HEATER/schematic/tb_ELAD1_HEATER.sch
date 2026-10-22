v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/vsource.sym} 0 0 0 0 {name=VEXT value=1.8}
C {devices/res.sym} 600 100 0 0 {name=RP value=500}
C {devices/vsource.sym} 240 0 0 0 {name=VHEN value=1.8}
C {ELAD1_HEATER.sym} 960 0 0 0 {name=XDUT}
N 0 70 240 70 {lab=0}
N 0 30 0 70 {lab=0}
N 240 30 240 70 {lab=0}
C {devices/gnd.sym} 0 70 0 0 {name=l1 lab=0 global=false}
N 1040 -10 1060 -10 {lab=0}
C {devices/lab_pin.sym} 1060 -10 0 1 {name=l2 sig_type=std_logic lab=0}
N 880 -10 860 -10 {lab=HIN}
N 860 -10 860 130 {lab=HIN}
N 600 130 860 130 {lab=HIN}
C {devices/lab_pin.sym} 600 130 0 0 {name=l3 sig_type=std_logic lab=HIN}
N 240 -30 240 -70 {lab=HEN}
N 880 10 840 10 {lab=HEN}
N 840 10 840 -70 {lab=HEN}
N 240 -70 840 -70 {lab=HEN}
C {devices/lab_pin.sym} 240 -70 0 0 {name=l4 sig_type=std_logic lab=HEN}
N 0 -30 0 -50 {lab=EXT}
N 0 -50 -20 -50 {lab=EXT}
N -20 -50 -20 80 {lab=EXT}
N 600 70 600 50 {lab=EXT}
N 600 50 580 50 {lab=EXT}
N 580 50 580 80 {lab=EXT}
N -20 80 580 80 {lab=EXT}
C {devices/lab_pin.sym} -20 80 0 0 {name=l5 sig_type=std_logic lab=EXT}
C {devices/code_shown.sym} -400 -400 0 0 {name=s1 only_toplevel=false value=".control
op
let i_heater = -i(VEXT)
let r_hin = v(HIN)/i_heater
let p_heater = (v(HIN)-v(xdut.HD))*i_heater
let p_switch = v(xdut.HD)*i_heater
print i_heater r_hin p_heater p_switch
alter VHEN dc = 0
op
let i_off = abs(i(VEXT))
print i_off
alter VHEN dc = 1.8
dc VEXT 0 1.8 0.01
write tb_ELAD1_HEATER.raw
.endc"}
C {sky130_fd_pr/corner.sym} -400 -600 0 0 {name=CORNER only_toplevel=true corner=tt}
T {tb_ELAD1_HEATER - local heater driven through the Tiny Tapeout analog path.
VEXT 1.8 V -> RP 500 ohm (TT path envelope) -> ua5 (HIN). HEN=1: heater on; HEN=0: leakage.
Package tt 27C: 0.893 mA, V(HIN) 1.353 V, R(HIN) 1515 ohm, leakage 8 pA.} -400 -895 0 0 0.4 0.4 {}
