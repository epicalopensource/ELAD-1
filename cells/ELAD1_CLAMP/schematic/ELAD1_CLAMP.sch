v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -120 -80 20 -80 {}
N 20 -80 20 -30 {}
N -120 0 -20 0 {}
N -120 80 20 80 {}
N 20 80 50 80 {}
N 20 30 20 80 {}
N 20 0 50 0 {}
N 50 0 50 80 {}
C {devices/iopin.sym} -120 -80 0 1 {name=p1 lab=NODE}
C {devices/iopin.sym} -120 0 0 1 {name=p2 lab=CLR}
C {devices/iopin.sym} -120 80 0 1 {name=p3 lab=VGND}
C {sky130_fd_pr/nfet_01v8.sym} 0 0 0 0 {name=M model=nfet_01v8 W=0.42 L=1 nf=1 mult=1 sa=0 sb=0 sd=0}
T {ELAD1_CLAMP: NODE to VGND while CLR = 1} -120 -170 0 0 0.3 0.3 {}
