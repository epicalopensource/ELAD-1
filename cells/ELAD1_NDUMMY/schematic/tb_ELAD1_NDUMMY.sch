v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/vsource.sym} 0 0 0 0 {name=VS value=1.8}
C {ELAD1_NDUMMY.sym} 560 0 0 0 {name=XDUT}
N 0 -30 0 -50 {lab=VGND}
C {devices/lab_pin.sym} 0 -50 1 0 {name=l1 sig_type=std_logic lab=VGND}
N 0 30 0 50 {lab=0}
C {devices/gnd.sym} 0 50 0 0 {name=l2 lab=0 global=false}
N 480 0 460 0 {lab=VGND}
C {devices/lab_pin.sym} 460 0 0 0 {name=l3 sig_type=std_logic lab=VGND}
C {devices/code_shown.sym} -400 -260 0 0 {name=s1 only_toplevel=false value=".control
op
let i_dummy = abs(i(VS))
let vth = @m.xdut.xm.msky130_fd_pr__nfet_01v8[vth]
let w_um = @m.xdut.xm.msky130_fd_pr__nfet_01v8[w]*1e6
print i_dummy vth w_um
write tb_ELAD1_NDUMMY.raw
.endc"}
C {sky130_fd_pr/corner.sym} -400 -460 0 0 {name=CORNER only_toplevel=true corner=tt}
T {tb_ELAD1_NDUMMY - perimeter dummy: all four terminals on its single pin VGND.
VS holds the pin at 1.8 V: no current may flow (D=G=S=B), and the device must be the
2/1 um nfet_01v8 (its threshold is read back to prove it is present and sized).} -400 -755 0 0 0.4 0.4 {}
