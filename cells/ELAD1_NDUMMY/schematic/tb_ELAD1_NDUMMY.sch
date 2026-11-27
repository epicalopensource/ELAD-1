v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 0 60 0 80 {}
N 120 230 120 250 {}
N 0 230 120 230 {}
C {ELAD1_NDUMMY.sym} 0 0 0 0 {name=XDUT}
C {devices/lab_pin.sym} 0 80 1 1 {name=l1 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} 0 230 0 0 {name=l2 sig_type=std_logic lab=VGND}
C {devices/vsource.sym} 120 280 0 0 {name=VS value=1.8}
C {devices/gnd.sym} 120 310 0 0 {name=l3 lab=0 global=false}
T {tb_ELAD1_NDUMMY - perimeter dummy: all four terminals on its single pin VGND.} -40 -215 0 0 0.4 0.4 {}
T {VS holds the pin at 1.8 V: no current may flow (D=G=S=B), and the device must be the
2/1 um nfet_01v8 (its threshold is read back to prove it is present and sized).} -40 -170 0 0 0.22 0.22 {}
C {devices/code_shown.sym} 320 140 0 0 {name=s1 only_toplevel=false value=".control
op
let i_dummy = abs(i(VS))
print i_dummy
write tb_ELAD1_NDUMMY.raw
.endc"}
C {sky130_fd_pr/corner.sym} 320 -60 0 0 {name=CORNER only_toplevel=true corner=tt}
