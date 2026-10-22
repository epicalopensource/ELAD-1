v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -120 80 -20 80 {}
N -20 80 20 80 {}
N 20 80 50 80 {}
N 50 80 80 80 {}
N -20 0 -20 80 {}
N 20 30 20 80 {}
N 20 0 50 0 {}
N 50 0 50 80 {}
N 20 -30 80 -30 {}
N 80 -30 80 80 {}
C {devices/iopin.sym} -120 80 0 1 {name=p1 lab=VGND}
C {sky130_fd_pr/nfet_01v8.sym} 0 0 0 0 {name=M model=nfet_01v8 W=2 L=1 nf=1 mult=1 sa=0 sb=0 sd=0}
T {ELAD1_NDUMMY: dummy unit, all pins VGND} -120 -110 0 0 0.3 0.3 {}
