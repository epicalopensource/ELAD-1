v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -120 220 -100 220 {}
N -100 220 -80 220 {}
N -240 220 -240 240 {}
N -240 220 -120 220 {}
N -300 180 -190 180 {}
N -190 180 -80 180 {}
N -420 180 -420 200 {}
N -420 180 -300 180 {}
N -480 140 -280 140 {}
N -280 140 -80 140 {}
N -600 140 -600 160 {}
N -600 140 -480 140 {}
N -660 100 -370 100 {}
N -370 100 -80 100 {}
N -780 100 -780 120 {}
N -780 100 -660 100 {}
N -840 60 -460 60 {}
N -460 60 -80 60 {}
N -960 60 -960 80 {}
N -960 60 -840 60 {}
C {ELAD1_PAIR_GROUPED.sym} 0 140 0 0 {name=XDUT}
C {devices/lab_pin.sym} -100 220 0 0 {name=l1 sig_type=std_logic lab=D2}
C {devices/vsource.sym} -240 270 0 0 {name=VD2 value=1.2}
C {devices/gnd.sym} -240 300 0 0 {name=l2 lab=0 global=false}
C {devices/lab_pin.sym} -190 180 0 0 {name=l3 sig_type=std_logic lab=D1}
C {devices/vsource.sym} -420 230 0 0 {name=VD1 value=1.2}
C {devices/gnd.sym} -420 260 0 0 {name=l4 lab=0 global=false}
C {devices/lab_pin.sym} -280 140 0 0 {name=l5 sig_type=std_logic lab=VINM}
C {devices/vsource.sym} -600 190 0 0 {name=VM value=1.0}
C {devices/gnd.sym} -600 220 0 0 {name=l6 lab=0 global=false}
C {devices/lab_pin.sym} -370 100 0 0 {name=l7 sig_type=std_logic lab=VINP}
C {devices/vsource.sym} -780 150 0 0 {name=VP value=1.0}
C {devices/gnd.sym} -780 180 0 0 {name=l8 lab=0 global=false}
C {devices/lab_pin.sym} -460 60 0 0 {name=l9 sig_type=std_logic lab=VBIAS}
C {devices/isource.sym} -960 110 2 0 {name=IT value="DC 10u"}
C {devices/gnd.sym} -960 140 0 0 {name=l10 lab=0 global=false}
C {devices/gnd.sym} 0 260 0 0 {name=l11 lab=0 global=false}
T {tb_ELAD1_PAIR_GROUPED - NMOS differential pair at the package operating point:} -1000 -155 0 0 0.4 0.4 {}
T {ITAIL 10 uA forced into VBIAS (ua0), VCM 1.0 V on both inputs, both drains held at 1.2 V.
Offset: VINP swept +-20 mV around VCM with VINM fixed; VOS = VINP - VCM where ID1 = ID2.} -1000 -110 0 0 0.22 0.22 {}
C {devices/code_shown.sym} 200 200 0 0 {name=s1 only_toplevel=false value=".control
op
let vbias = v(VBIAS)
let id1 = -i(VD1)
let id2 = -i(VD2)
let isum = id1+id2
let imbalance_pct = 100*(id1-id2)/isum
print vbias id1 id2 isum imbalance_pct
dc VP 0.98 1.02 0.0005
let did = i(VD2)-i(VD1)
meas dc vinp_bal find v(VINP) when did=0
let vos = vinp_bal-1.0
print vos
write tb_ELAD1_PAIR_GROUPED.raw
.endc"}
C {sky130_fd_pr/corner.sym} 200 0 0 0 {name=CORNER only_toplevel=true corner=tt}
