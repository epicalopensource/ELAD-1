v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/vsource.sym} 0 0 0 0 {name=VDD value=1.8}
C {devices/vsource.sym} 240 0 0 0 {name=VA value="PULSE(0 1.8 1n 100p 100p 4.9n 10n)"}
C {ELAD1_INV.sym} 1040 0 0 0 {name=XDUT}
C {devices/capa.sym} 480 0 0 0 {name=CL value=10f}
N 0 -30 0 -50 {lab=VDPWR}
C {devices/vdd.sym} 0 -50 0 0 {name=l1 lab=VDPWR global=false}
N 0 70 240 70 {lab=0}
N 240 70 480 70 {lab=0}
N 0 30 0 70 {lab=0}
N 240 30 240 70 {lab=0}
N 480 30 480 70 {lab=0}
C {devices/gnd.sym} 0 70 0 0 {name=l2 lab=0 global=false}
N 1120 -10 1140 -10 {lab=VDPWR}
C {devices/lab_pin.sym} 1140 -10 0 1 {name=l3 sig_type=std_logic lab=VDPWR}
N 1120 10 1140 10 {lab=0}
C {devices/lab_pin.sym} 1140 10 0 1 {name=l4 sig_type=std_logic lab=0}
N 960 10 940 10 {lab=Y}
N 940 10 940 -70 {lab=Y}
N 480 -30 480 -70 {lab=Y}
N 480 -70 940 -70 {lab=Y}
C {devices/lab_pin.sym} 480 -70 0 0 {name=l5 sig_type=std_logic lab=Y}
N 240 -30 240 -80 {lab=A}
N 960 -10 920 -10 {lab=A}
N 920 -10 920 -80 {lab=A}
N 240 -80 920 -80 {lab=A}
C {devices/lab_pin.sym} 240 -80 0 0 {name=l6 sig_type=std_logic lab=A}
C {devices/code_shown.sym} -400 -280 0 0 {name=s1 only_toplevel=false value=".control
tran 5p 12n
meas tran tphl trig v(A) val=0.9 rise=1 targ v(Y) val=0.9 fall=1
meas tran tplh trig v(A) val=0.9 fall=1 targ v(Y) val=0.9 rise=1
write tb_ELAD1_INV.raw
dc VA 0 1.8 0.001
let d = v(Y)-v(A)
meas dc vsw find v(A) when d=0
.endc"}
C {sky130_fd_pr/corner.sym} -400 -480 0 0 {name=CORNER only_toplevel=true corner=tt}
T {tb_ELAD1_INV - complement driver for the selector switch gates.
Transient: 100 MHz square wave into a 10 fF load (about one TG gate pair): delays.
DC: transfer curve, switching threshold where V(Y) = V(A).} -400 -775 0 0 0.4 0.4 {}
