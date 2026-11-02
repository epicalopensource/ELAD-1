v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {ELAD1_INV - CMOS inverter (TG complement driver)} -120 -200 0 0 0.4 0.4 {}
N -120 0 -50 0 {lab=A}
N -50 -60 -20 -60 {lab=A}
N -50 -60 -50 0 {lab=A}
N -50 0 -50 60 {lab=A}
N -50 60 -20 60 {lab=A}
N 20 -30 20 0 {lab=Y}
N 20 0 20 30 {lab=Y}
N 20 0 140 0 {lab=Y}
N -120 -120 20 -120 {lab=VDPWR}
N 20 -120 60 -120 {lab=VDPWR}
N 20 -120 20 -90 {lab=VDPWR}
N 20 -60 60 -60 {lab=VDPWR}
N 60 -120 60 -60 {lab=VDPWR}
N -120 120 20 120 {lab=VGND}
N 20 120 60 120 {lab=VGND}
N 20 90 20 120 {lab=VGND}
N 20 60 60 60 {lab=VGND}
N 60 60 60 120 {lab=VGND}
C {devices/iopin.sym} -120 0 0 1 {name=p1 lab=A}
C {devices/iopin.sym} 140 0 0 0 {name=p2 lab=Y}
C {devices/iopin.sym} -120 -120 0 1 {name=p3 lab=VDPWR}
C {devices/iopin.sym} -120 120 0 1 {name=p4 lab=VGND}
C {sky130_fd_pr/pfet_01v8.sym} 0 -60 0 0 {name=MP model=pfet_01v8 W=1 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 0 60 0 0 {name=MN model=nfet_01v8 W=0.65 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
