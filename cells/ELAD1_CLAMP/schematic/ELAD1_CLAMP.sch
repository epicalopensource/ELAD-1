v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {sky130_fd_pr/nfet_01v8.sym} -20 0 0 0 {name=M model=nfet_01v8 W=0.42 L=1}
N 0 0 20 0 {lab=VGND}
C {devices/lab_pin.sym} 20 0 0 1 {name=l1 sig_type=std_logic lab=VGND}
N 0 30 0 50 {lab=VGND}
C {devices/gnd.sym} 0 50 0 0 {name=l2 lab=VGND}
N 0 -30 0 -70 {lab=NODE}
N -60 -70 0 -70 {lab=NODE}
N -40 0 -60 0 {lab=CLR}
N -120 0 -60 0 {lab=CLR}
C {devices/iopin.sym} -60 -70 0 1 {name=p3 lab=NODE}
C {devices/iopin.sym} -120 0 0 1 {name=p4 lab=CLR}
C {devices/iopin.sym} -280 -70 0 1 {name=p5 lab=VGND}
