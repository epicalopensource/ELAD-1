v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {sky130_fd_pr/nfet_01v8.sym} -20 200 0 0 {name=MN model=nfet_01v8 W=0.65 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/pfet_01v8.sym} -20 0 0 0 {name=MP model=pfet_01v8 W=1 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
N 0 200 20 200 {lab=VGND}
C {devices/lab_pin.sym} 20 200 0 1 {name=l1 sig_type=std_logic lab=VGND}
N 0 0 20 0 {lab=VDPWR}
C {devices/lab_pin.sym} 20 0 0 1 {name=l2 sig_type=std_logic lab=VDPWR}
N 0 230 0 250 {lab=VGND}
C {devices/gnd.sym} 0 250 0 0 {name=l3 lab=VGND global=false}
N 0 -30 0 -50 {lab=VDPWR}
C {devices/vdd.sym} 0 -50 0 0 {name=l4 lab=VDPWR global=false}
N 0 170 0 130 {lab=Y}
N 0 30 0 130 {lab=Y}
N -60 130 0 130 {lab=Y}
N -40 200 -80 200 {lab=A}
N -80 200 -80 0 {lab=A}
N -40 0 -80 0 {lab=A}
N -140 0 -80 0 {lab=A}
C {devices/iopin.sym} -140 0 0 1 {name=p6 lab=A}
C {devices/iopin.sym} -60 130 0 1 {name=p5 lab=Y}
C {devices/iopin.sym} -300 -30 0 1 {name=p7 lab=VDPWR}
C {devices/iopin.sym} -300 10 0 1 {name=p8 lab=VGND}
