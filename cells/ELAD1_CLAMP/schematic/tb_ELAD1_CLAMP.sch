v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/vsource.sym} 0 0 0 0 {name=VDD value=1.8}
C {devices/vsource.sym} 240 0 0 0 {name=VCLR value=1.8}
C {devices/res.sym} 480 0 0 0 {name=RPU value=1meg}
C {ELAD1_CLAMP.sym} 1520 0 0 0 {name=XDUT}
C {devices/vsource.sym} 720 0 0 0 {name=VCLR0 value=0}
C {devices/vsource.sym} 960 0 0 0 {name=VLIVE value=0.9}
C {ELAD1_CLAMP.sym} 1920 0 0 0 {name=XOFF}
N 0 -70 480 -70 {lab=VDPWR}
N 0 -30 0 -70 {lab=VDPWR}
N 480 -30 480 -70 {lab=VDPWR}
C {devices/vdd.sym} 0 -70 0 0 {name=l1 lab=VDPWR global=false}
N 0 70 240 70 {lab=0}
N 240 70 720 70 {lab=0}
N 720 70 960 70 {lab=0}
N 0 30 0 70 {lab=0}
N 240 30 240 70 {lab=0}
N 720 30 720 70 {lab=0}
N 960 30 960 70 {lab=0}
C {devices/gnd.sym} 0 70 0 0 {name=l2 lab=0 global=false}
N 1600 -10 1620 -10 {lab=0}
C {devices/lab_pin.sym} 1620 -10 0 1 {name=l3 sig_type=std_logic lab=0}
N 2000 -10 2020 -10 {lab=0}
C {devices/lab_pin.sym} 2020 -10 0 1 {name=l4 sig_type=std_logic lab=0}
N 960 -30 960 -70 {lab=LIVE}
N 1840 -10 1820 -10 {lab=LIVE}
N 1820 -10 1820 -70 {lab=LIVE}
N 960 -70 1820 -70 {lab=LIVE}
C {devices/lab_pin.sym} 960 -70 0 0 {name=l5 sig_type=std_logic lab=LIVE}
N 480 30 480 80 {lab=NODE}
N 1440 -10 1420 -10 {lab=NODE}
N 1420 -10 1420 80 {lab=NODE}
N 480 80 1420 80 {lab=NODE}
C {devices/lab_pin.sym} 480 80 0 0 {name=l6 sig_type=std_logic lab=NODE}
N 720 -30 720 -80 {lab=CLR0}
N 1840 10 1800 10 {lab=CLR0}
N 1800 10 1800 -80 {lab=CLR0}
N 720 -80 1800 -80 {lab=CLR0}
C {devices/lab_pin.sym} 720 -80 0 0 {name=l7 sig_type=std_logic lab=CLR0}
N 240 -30 240 -50 {lab=CLR}
N 240 -50 220 -50 {lab=CLR}
N 220 -50 220 90 {lab=CLR}
N 1440 10 1400 10 {lab=CLR}
N 1400 10 1400 90 {lab=CLR}
N 220 90 1400 90 {lab=CLR}
C {devices/lab_pin.sym} 220 90 0 0 {name=l8 sig_type=std_logic lab=CLR}
C {devices/code_shown.sym} -400 -320 0 0 {name=s1 only_toplevel=false value=".control
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
C {sky130_fd_pr/corner.sym} -400 -520 0 0 {name=CORNER only_toplevel=true corner=tt}
T {tb_ELAD1_CLAMP - inactive-gate clamp. CLR=1 must hold NODE at VGND; CLR=0 must release it.
NODE is pulled up by RPU 1 Mohm (stands in for any weak drive on an inactive gate).
XOFF (CLR=0) has its NODE forced to 0.9 V: off-state leakage the clamp adds to a live node.} -400 -815 0 0 0.4 0.4 {}
