v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -100 120 -80 120 {}
N -80 120 -60 120 {}
N -220 120 -220 140 {}
N -220 120 -100 120 {}
N 60 120 80 120 {}
N 80 120 100 120 {}
N 220 120 220 140 {}
N 100 120 220 120 {}
N 0 40 0 60 {}
N 0 180 0 200 {}
N -100 470 -80 470 {}
N -80 470 -60 470 {}
N -220 470 -220 490 {}
N -220 470 -100 470 {}
N 60 470 80 470 {}
N 80 470 100 470 {}
N 220 470 220 490 {}
N 100 470 220 470 {}
N -100 700 -100 720 {}
N -220 700 -100 700 {}
N 160 700 160 720 {}
N 40 700 160 700 {}
N 420 700 420 720 {}
N 300 700 420 700 {}
C {ELAD1_TGB.sym} 0 120 0 0 {name=XDUT}
C {devices/lab_pin.sym} -80 120 0 0 {name=l1 sig_type=std_logic lab=A}
C {devices/vsource.sym} -220 170 0 0 {name=VA value=0.9}
C {devices/gnd.sym} -220 200 0 0 {name=l2 lab=0 global=false}
C {devices/lab_pin.sym} 80 120 0 1 {name=l3 sig_type=std_logic lab=B}
C {devices/isource.sym} 220 170 0 0 {name=IB value=1u}
C {devices/gnd.sym} 220 200 0 0 {name=l4 lab=0 global=false}
C {devices/lab_pin.sym} 0 40 0 0 {name=l5 sig_type=std_logic lab=ENB}
C {devices/vdd.sym} 40 60 0 0 {name=l6 lab=VDPWR global=false}
C {devices/lab_pin.sym} 0 200 1 1 {name=l7 sig_type=std_logic lab=EN}
C {devices/gnd.sym} 40 180 0 0 {name=l8 lab=0 global=false}
C {ELAD1_TGB.sym} 0 470 0 0 {name=XOFF}
C {devices/lab_pin.sym} -80 470 0 0 {name=l9 sig_type=std_logic lab=AO}
C {devices/vsource.sym} -220 520 0 0 {name=VAO value=0.3}
C {devices/gnd.sym} -220 550 0 0 {name=l10 lab=0 global=false}
C {devices/lab_pin.sym} 80 470 0 1 {name=l11 sig_type=std_logic lab=BO}
C {devices/vsource.sym} 220 520 0 0 {name=VBO value=1.8}
C {devices/gnd.sym} 220 550 0 0 {name=l12 lab=0 global=false}
C {devices/vdd.sym} 0 410 0 0 {name=l13 lab=VDPWR global=false}
C {devices/vdd.sym} 40 410 0 0 {name=l14 lab=VDPWR global=false}
C {devices/gnd.sym} 0 530 0 0 {name=l15 lab=0 global=false}
C {devices/gnd.sym} 40 530 0 0 {name=l16 lab=0 global=false}
C {devices/lab_pin.sym} -220 700 0 0 {name=l17 sig_type=std_logic lab=ENB}
C {devices/vsource.sym} -100 750 0 0 {name=VENB value=0}
C {devices/gnd.sym} -100 780 0 0 {name=l18 lab=0 global=false}
C {devices/lab_pin.sym} 40 700 0 0 {name=l19 sig_type=std_logic lab=EN}
C {devices/vsource.sym} 160 750 0 0 {name=VEN value=1.8}
C {devices/gnd.sym} 160 780 0 0 {name=l20 lab=0 global=false}
C {devices/vdd.sym} 300 700 0 0 {name=l21 lab=VDPWR global=false}
C {devices/vsource.sym} 420 750 0 0 {name=VDD value=1.8}
C {devices/gnd.sym} 420 780 0 0 {name=l22 lab=0 global=false}
T {tb_ELAD1_TGB - analog selector switch element.} -260 -175 0 0 0.4 0.4 {}
T {XDUT on (EN=1): 1 uA pulled through A->B, Ron = (V(A)-V(B))/1 uA swept over VA = 0..1.8 V.
XOFF off (EN=0): A held at 0.3 V, B at 1.8 V (worst case in the package leakage table).} -260 -130 0 0 0.22 0.22 {}
C {devices/code_shown.sym} 620 180 0 0 {name=s1 only_toplevel=false value=".control
op
let i_leak_off = abs(i(VAO))
print i_leak_off
dc VA 0 1.8 0.01
let ron = (v(A)-v(B))/1e-6
meas dc ron_max max ron
meas dc ron_0p7 find ron at=0.7
meas dc ron_1p2 find ron at=1.2
write tb_ELAD1_TGB.raw
.endc"}
C {sky130_fd_pr/corner.sym} 620 -20 0 0 {name=CORNER only_toplevel=true corner=tt}
