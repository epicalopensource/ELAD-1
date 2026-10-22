v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/vsource.sym} 0 0 0 0 {name=VDD value=1.8}
C {devices/vsource.sym} 240 0 0 0 {name=VEN value=1.8}
C {devices/vsource.sym} 480 0 0 0 {name=VENB value=0}
C {devices/vsource.sym} 720 0 0 0 {name=VA value=0.9}
C {ELAD1_TGA.sym} 2000 0 0 0 {name=XDUT}
C {devices/isource.sym} 960 0 0 0 {name=IB value=1u}
C {devices/vsource.sym} 1200 0 0 0 {name=VAO value=0.3}
C {devices/vsource.sym} 1440 0 0 0 {name=VBO value=1.8}
C {ELAD1_TGA.sym} 2400 0 0 0 {name=XOFF}
N 0 -30 0 -50 {lab=VDPWR}
C {devices/vdd.sym} 0 -50 0 0 {name=l1 lab=VDPWR global=false}
N 0 70 240 70 {lab=0}
N 240 70 480 70 {lab=0}
N 480 70 720 70 {lab=0}
N 720 70 960 70 {lab=0}
N 960 70 1200 70 {lab=0}
N 1200 70 1440 70 {lab=0}
N 0 30 0 70 {lab=0}
N 240 30 240 70 {lab=0}
N 480 30 480 70 {lab=0}
N 720 30 720 70 {lab=0}
N 960 30 960 70 {lab=0}
N 1200 30 1200 70 {lab=0}
N 1440 30 1440 70 {lab=0}
C {devices/gnd.sym} 0 70 0 0 {name=l2 lab=0 global=false}
N 2080 0 2100 0 {lab=VDPWR}
C {devices/lab_pin.sym} 2100 0 0 1 {name=l3 sig_type=std_logic lab=VDPWR}
N 2480 0 2500 0 {lab=VDPWR}
C {devices/lab_pin.sym} 2500 0 0 1 {name=l4 sig_type=std_logic lab=VDPWR}
N 2080 20 2100 20 {lab=0}
C {devices/lab_pin.sym} 2100 20 0 1 {name=l5 sig_type=std_logic lab=0}
N 2480 20 2500 20 {lab=0}
C {devices/lab_pin.sym} 2500 20 0 1 {name=l6 sig_type=std_logic lab=0}
N 2320 20 2300 20 {lab=0}
C {devices/lab_pin.sym} 2300 20 0 0 {name=l7 sig_type=std_logic lab=0}
N 2480 -20 2500 -20 {lab=VDPWR}
C {devices/lab_pin.sym} 2500 -20 0 1 {name=l8 sig_type=std_logic lab=VDPWR}
N 1440 -30 1440 -70 {lab=BO}
N 2320 0 2300 0 {lab=BO}
N 2300 0 2300 -70 {lab=BO}
N 1440 -70 2300 -70 {lab=BO}
C {devices/lab_pin.sym} 1440 -70 0 0 {name=l9 sig_type=std_logic lab=BO}
N 1920 0 1900 0 {lab=B}
N 1900 0 1900 -80 {lab=B}
N 960 -30 960 -80 {lab=B}
N 960 -80 1900 -80 {lab=B}
C {devices/lab_pin.sym} 960 -80 0 0 {name=l10 sig_type=std_logic lab=B}
N 1200 -30 1200 -50 {lab=AO}
N 1200 -50 1180 -50 {lab=AO}
N 1180 -50 1180 80 {lab=AO}
N 2320 -20 2280 -20 {lab=AO}
N 2280 -20 2280 80 {lab=AO}
N 1180 80 2280 80 {lab=AO}
C {devices/lab_pin.sym} 1180 80 0 0 {name=l11 sig_type=std_logic lab=AO}
N 720 -30 720 -90 {lab=A}
N 1920 -20 1880 -20 {lab=A}
N 1880 -20 1880 -90 {lab=A}
N 720 -90 1880 -90 {lab=A}
C {devices/lab_pin.sym} 720 -90 0 0 {name=l12 sig_type=std_logic lab=A}
N 480 -30 480 -100 {lab=ENB}
N 2080 -20 2100 -20 {lab=ENB}
N 2100 -20 2100 -100 {lab=ENB}
N 480 -100 2100 -100 {lab=ENB}
C {devices/lab_pin.sym} 480 -100 0 0 {name=l13 sig_type=std_logic lab=ENB}
N 240 -30 240 -50 {lab=EN}
N 240 -50 220 -50 {lab=EN}
N 220 -50 220 90 {lab=EN}
N 1920 20 1900 20 {lab=EN}
N 1900 20 1900 90 {lab=EN}
N 220 90 1900 90 {lab=EN}
C {devices/lab_pin.sym} 220 90 0 0 {name=l14 sig_type=std_logic lab=EN}
C {devices/code_shown.sym} -400 -320 0 0 {name=s1 only_toplevel=false value=".control
op
let i_leak_off = abs(i(VAO))
print i_leak_off
dc VA 0 1.8 0.01
let ron = (v(A)-v(B))/1e-6
meas dc ron_max max ron
meas dc ron_0p7 find ron at=0.7
meas dc ron_1p2 find ron at=1.2
write tb_ELAD1_TGA.raw
.endc"}
C {sky130_fd_pr/corner.sym} -400 -520 0 0 {name=CORNER only_toplevel=true corner=tt}
T {tb_ELAD1_TGA - analog selector switch element.
XDUT on (EN=1): 1 uA pulled through A->B, Ron = (V(A)-V(B))/1 uA swept over VA = 0..1.8 V.
XOFF off (EN=0): A held at 0.3 V, B at 1.8 V (worst case in the package leakage table).} -400 -815 0 0 0.4 0.4 {}
