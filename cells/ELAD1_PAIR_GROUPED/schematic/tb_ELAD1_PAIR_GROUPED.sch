v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/isource.sym} 0 0 2 1 {name=IT value="DC 10u"}
C {devices/vsource.sym} 240 0 0 0 {name=VP value=1.0}
C {devices/vsource.sym} 480 0 0 0 {name=VM value=1.0}
C {devices/vsource.sym} 720 0 0 0 {name=VD1 value=1.2}
C {devices/vsource.sym} 960 0 0 0 {name=VD2 value=1.2}
C {ELAD1_PAIR_GROUPED.sym} 1520 0 0 0 {name=XDUT}
N 0 70 240 70 {lab=0}
N 240 70 480 70 {lab=0}
N 480 70 720 70 {lab=0}
N 720 70 960 70 {lab=0}
N 0 30 0 70 {lab=0}
N 240 30 240 70 {lab=0}
N 480 30 480 70 {lab=0}
N 720 30 720 70 {lab=0}
N 960 30 960 70 {lab=0}
C {devices/gnd.sym} 0 70 0 0 {name=l1 lab=0 global=false}
N 1600 20 1620 20 {lab=0}
C {devices/lab_pin.sym} 1620 20 0 1 {name=l2 sig_type=std_logic lab=0}
N 960 -30 960 -70 {lab=D2}
N 1600 -20 1620 -20 {lab=D2}
N 1620 -20 1620 -70 {lab=D2}
N 960 -70 1620 -70 {lab=D2}
C {devices/lab_pin.sym} 960 -70 0 0 {name=l3 sig_type=std_logic lab=D2}
N 720 -30 720 -80 {lab=D1}
N 1440 20 1420 20 {lab=D1}
N 1420 20 1420 -80 {lab=D1}
N 720 -80 1420 -80 {lab=D1}
C {devices/lab_pin.sym} 720 -80 0 0 {name=l4 sig_type=std_logic lab=D1}
N 480 -30 480 -50 {lab=VINM}
N 480 -50 460 -50 {lab=VINM}
N 460 -50 460 80 {lab=VINM}
N 1440 0 1400 0 {lab=VINM}
N 1400 0 1400 80 {lab=VINM}
N 460 80 1400 80 {lab=VINM}
C {devices/lab_pin.sym} 460 80 0 0 {name=l5 sig_type=std_logic lab=VINM}
N 240 -30 240 -90 {lab=VINP}
N 1440 -20 1400 -20 {lab=VINP}
N 1400 -20 1400 -90 {lab=VINP}
N 240 -90 1400 -90 {lab=VINP}
C {devices/lab_pin.sym} 240 -90 0 0 {name=l6 sig_type=std_logic lab=VINP}
N 0 -30 0 -100 {lab=VBIAS}
N 1600 0 1640 0 {lab=VBIAS}
N 1640 0 1640 -100 {lab=VBIAS}
N 0 -100 1640 -100 {lab=VBIAS}
C {devices/lab_pin.sym} 0 -100 0 0 {name=l7 sig_type=std_logic lab=VBIAS}
C {devices/code_shown.sym} -400 -420 0 0 {name=s1 only_toplevel=false value=".control
op
let vbias = v(VBIAS)
let vtail = v(xdut.TAIL)
let id1 = -i(VD1)
let id2 = -i(VD2)
let isum = id1+id2
let imbalance_pct = 100*(id1-id2)/isum
print vbias vtail id1 id2 isum imbalance_pct
dc VP 0.98 1.02 0.0005
let did = i(VD2)-i(VD1)
meas dc vinp_bal find v(VINP) when did=0
let vos = vinp_bal-1.0
print vos
write tb_ELAD1_PAIR_GROUPED.raw
.endc"}
C {sky130_fd_pr/corner.sym} -400 -620 0 0 {name=CORNER only_toplevel=true corner=tt}
T {tb_ELAD1_PAIR_GROUPED - NMOS differential pair at the package operating point:
ITAIL 10 uA forced into VBIAS (ua0), VCM 1.0 V on both inputs, both drains held at 1.2 V.
Offset: VINP swept +-20 mV around VCM with VINM fixed; VOS = VINP - VCM where ID1 = ID2.} -400 -915 0 0 0.4 0.4 {}
