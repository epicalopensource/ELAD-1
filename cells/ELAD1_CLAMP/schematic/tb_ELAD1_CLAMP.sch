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
N 0 40 0 60 {}
N -100 470 -80 470 {}
N -80 470 -60 470 {}
N -220 470 -220 490 {}
N -220 470 -100 470 {}
N 0 390 0 410 {}
N -100 680 -100 700 {}
N -220 700 -100 700 {}
N 160 700 160 720 {}
N 40 700 160 700 {}
N 420 700 420 720 {}
N 300 700 420 700 {}
C {ELAD1_CLAMP.sym} 0 120 0 0 {name=XDUT}
C {devices/lab_pin.sym} -80 120 0 0 {name=l1 sig_type=std_logic lab=CLR}
C {devices/vsource.sym} -220 170 0 0 {name=VCLR value=1.8}
C {devices/gnd.sym} -220 200 0 0 {name=l2 lab=0 global=false}
C {devices/lab_pin.sym} 0 40 0 0 {name=l3 sig_type=std_logic lab=NODE}
C {devices/gnd.sym} 0 180 0 0 {name=l4 lab=0 global=false}
C {ELAD1_CLAMP.sym} 0 470 0 0 {name=XOFF}
C {devices/lab_pin.sym} -80 470 0 0 {name=l5 sig_type=std_logic lab=CLR0}
C {devices/vsource.sym} -220 520 0 0 {name=VCLR0 value=0}
C {devices/gnd.sym} -220 550 0 0 {name=l6 lab=0 global=false}
C {devices/lab_pin.sym} 0 390 0 0 {name=l7 sig_type=std_logic lab=LIVE}
C {devices/gnd.sym} 0 530 0 0 {name=l8 lab=0 global=false}
C {devices/lab_pin.sym} -220 700 0 0 {name=l9 sig_type=std_logic lab=NODE}
C {devices/res.sym} -100 650 0 0 {name=RPU value=1meg}
C {devices/vdd.sym} -100 620 0 0 {name=l10 lab=VDPWR global=false}
C {devices/lab_pin.sym} 40 700 0 0 {name=l11 sig_type=std_logic lab=LIVE}
C {devices/vsource.sym} 160 750 0 0 {name=VLIVE value=0.9}
C {devices/gnd.sym} 160 780 0 0 {name=l12 lab=0 global=false}
C {devices/vdd.sym} 300 700 0 0 {name=l13 lab=VDPWR global=false}
C {devices/vsource.sym} 420 750 0 0 {name=VDD value=1.8}
C {devices/gnd.sym} 420 780 0 0 {name=l14 lab=0 global=false}
T {tb_ELAD1_CLAMP - inactive-gate clamp. CLR=1 must hold NODE at VGND; CLR=0 must release it.} -260 -175 0 0 0.4 0.4 {}
T {NODE is pulled up by RPU 1 Mohm (stands in for any weak drive on an inactive gate).
XOFF (CLR=0) has its NODE forced to 0.9 V: off-state leakage the clamp adds to a live node.} -260 -130 0 0 0.22 0.22 {}
C {devices/code_shown.sym} 620 180 0 0 {name=s1 only_toplevel=false value=".control
op
let v_clamped = v(NODE)
let i_leak = abs(i(VLIVE))
print v_clamped i_leak
alter VCLR dc = 0
op
let v_released = v(NODE)
print v_released
write tb_ELAD1_CLAMP.raw
.endc"}
C {sky130_fd_pr/corner.sym} 620 -20 0 0 {name=CORNER only_toplevel=true corner=tt}
