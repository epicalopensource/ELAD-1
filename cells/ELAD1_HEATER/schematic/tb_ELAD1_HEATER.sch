v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -120 100 -100 100 {}
N -100 100 -80 100 {}
N -240 100 -240 120 {}
N -240 100 -120 100 {}
N -300 60 -190 60 {}
N -190 60 -80 60 {}
N -330 60 -300 60 {}
N -420 60 -390 60 {}
N -540 60 -540 80 {}
N -540 60 -420 60 {}
C {ELAD1_HEATER.sym} 0 80 0 0 {name=XDUT}
C {devices/lab_pin.sym} -100 100 0 0 {name=l1 sig_type=std_logic lab=HEN}
C {devices/vsource.sym} -240 150 0 0 {name=VHEN value=1.8}
C {devices/gnd.sym} -240 180 0 0 {name=l2 lab=0 global=false}
C {devices/lab_pin.sym} -190 60 0 0 {name=l3 sig_type=std_logic lab=HIN}
C {devices/res.sym} -360 60 3 0 {name=RP value=500}
C {devices/lab_pin.sym} -420 60 0 0 {name=l4 sig_type=std_logic lab=EXT}
C {devices/vsource.sym} -540 110 0 0 {name=VEXT value=1.8}
C {devices/gnd.sym} -540 140 0 0 {name=l5 lab=0 global=false}
C {devices/gnd.sym} 0 140 0 0 {name=l6 lab=0 global=false}
T {tb_ELAD1_HEATER - local heater driven through the Tiny Tapeout analog path.} -580 -155 0 0 0.4 0.4 {}
T {VEXT 1.8 V -> RP 500 ohm (TT path envelope) -> ua5 (HIN). HEN=1: heater on; HEN=0: leakage.
Package tt 27C: 0.893 mA, V(HIN) 1.353 V, R(HIN) 1515 ohm, leakage 8 pA.} -580 -110 0 0 0.22 0.22 {}
C {devices/code_shown.sym} 200 200 0 0 {name=s1 only_toplevel=false value=".control
op
let i_heater = -i(VEXT)
let r_hin = v(HIN)/i_heater
let p_heater = v(hin)*i_heater
print i_heater r_hin p_heater
alter VHEN dc = 0
op
let i_off = abs(i(VEXT))
print i_off
alter VHEN dc = 1.8
dc VEXT 0 1.8 0.01
write tb_ELAD1_HEATER.raw
.endc"}
C {sky130_fd_pr/corner.sym} 200 0 0 0 {name=CORNER only_toplevel=true corner=tt}
