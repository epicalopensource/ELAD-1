v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {sky130_fd_pr/nfet_01v8.sym} -20 0 0 0 {name=M model=nfet_01v8 W=2 L=1}
N 0 0 20 0 {lab=VGND}
C {devices/lab_pin.sym} 20 0 0 1 {name=l1 sig_type=std_logic lab=VGND}
N 0 -30 0 -50 {lab=VGND}
C {devices/lab_pin.sym} 0 -50 1 0 {name=l2 sig_type=std_logic lab=VGND}
N -40 0 -60 0 {lab=VGND}
C {devices/lab_pin.sym} -60 0 0 0 {name=l3 sig_type=std_logic lab=VGND}
N 0 30 0 50 {lab=VGND}
C {devices/gnd.sym} 0 50 0 0 {name=l4 lab=VGND}
C {devices/iopin.sym} -220 -30 0 1 {name=p5 lab=VGND}
