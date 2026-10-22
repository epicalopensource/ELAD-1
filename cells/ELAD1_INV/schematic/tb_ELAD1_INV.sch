v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -100 110 -80 110 {}
N -80 110 -60 110 {}
N -220 110 -220 130 {}
N -220 110 -100 110 {}
N 60 110 80 110 {}
N 80 110 100 110 {}
N 220 110 220 130 {}
N 100 110 220 110 {}
N -100 330 -100 350 {}
N -220 330 -100 330 {}
C {ELAD1_INV.sym} 0 110 0 0 {name=XDUT}
C {devices/lab_pin.sym} -80 110 0 0 {name=l1 sig_type=std_logic lab=A}
C {devices/vsource.sym} -220 160 0 0 {name=VA value="PULSE(0 1.8 1n 100p 100p 4.9n 10n)"}
C {devices/gnd.sym} -220 190 0 0 {name=l2 lab=0 global=false}
C {devices/lab_pin.sym} 80 110 0 1 {name=l3 sig_type=std_logic lab=Y}
C {devices/capa.sym} 220 160 0 0 {name=CL value=10f}
C {devices/gnd.sym} 220 190 0 0 {name=l4 lab=0 global=false}
C {devices/vdd.sym} 0 60 0 0 {name=l5 lab=VDPWR global=false}
C {devices/gnd.sym} 0 160 0 0 {name=l6 lab=0 global=false}
C {devices/vdd.sym} -220 330 0 0 {name=l7 lab=VDPWR global=false}
C {devices/vsource.sym} -100 380 0 0 {name=VDD value=1.8}
C {devices/gnd.sym} -100 410 0 0 {name=l8 lab=0 global=false}
T {tb_ELAD1_INV - complement driver for the selector switch gates.} -260 -155 0 0 0.4 0.4 {}
T {Transient: 100 MHz square wave into a 10 fF load (about one TG gate pair): delays.
DC: transfer curve, switching threshold where V(Y) = V(A).} -260 -110 0 0 0.22 0.22 {}
C {devices/code_shown.sym} 420 200 0 0 {name=s1 only_toplevel=false value=".control
tran 5p 12n
meas tran tphl trig v(A) val=0.9 rise=1 targ v(Y) val=0.9 fall=1
meas tran tplh trig v(A) val=0.9 fall=1 targ v(Y) val=0.9 rise=1
write tb_ELAD1_INV.raw
dc VA 0 1.8 0.001
let d = v(Y)-v(A)
meas dc vsw find v(A) when d=0
.endc"}
C {sky130_fd_pr/corner.sym} 420 0 0 0 {name=CORNER only_toplevel=true corner=tt}
