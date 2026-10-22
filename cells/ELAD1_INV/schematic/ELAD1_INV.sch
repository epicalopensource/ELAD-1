v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -120 0 -50 0 {}
N -50 -60 -20 -60 {}
N -50 -60 -50 0 {}
N -50 0 -50 60 {}
N -50 60 -20 60 {}
N 20 -30 20 0 {}
N 20 0 20 30 {}
N 20 0 140 0 {}
N -120 -120 20 -120 {}
N 20 -120 60 -120 {}
N 20 -120 20 -90 {}
N 20 -60 60 -60 {}
N 60 -120 60 -60 {}
N -120 120 20 120 {}
N 20 120 60 120 {}
N 20 90 20 120 {}
N 20 60 60 60 {}
N 60 60 60 120 {}
C {devices/iopin.sym} -120 0 0 1 {name=p1 lab=A}
C {devices/iopin.sym} 140 0 0 0 {name=p2 lab=Y}
C {devices/iopin.sym} -120 -120 0 1 {name=p3 lab=VDPWR}
C {devices/iopin.sym} -120 120 0 1 {name=p4 lab=VGND}
C {sky130_fd_pr/pfet_01v8.sym} 0 -60 0 0 {name=MP model=pfet_01v8 W=1 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 0 60 0 0 {name=MN model=nfet_01v8 W=0.65 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
T {ELAD1_INV - CMOS inverter (TG complement driver)} -120 -200 0 0 0.4 0.4 {}
