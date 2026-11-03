v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {ELAD1_MIRROR_CC: 1:1 NMOS current mirror} -120 -230 0 0 0.35 0.35 {}
T {unit W/L = 2 / 1 um.  A[3:0] = 4 diode units, B[3:0] = 4 output units, DUM[15:0] = 16 dummies} -120 -190 0 0 0.22 0.22 {}
T {(an array name X[n:0] is n+1 parallel units).  Layout: common centroid ABBA / BAAB} -120 -165 0 0 0.22 0.22 {}
N 20 0 80 0 {lab=REF}
N 80 0 140 0 {lab=REF}
N -120 -70 -20 -70 {lab=REF}
N -20 -70 -20 -30 {lab=REF}
N -20 -70 80 -70 {lab=REF}
N 80 -70 80 0 {lab=REF}
N 180 -70 180 -30 {lab=OUT}
N 180 -70 300 -70 {lab=OUT}
N -120 80 -50 80 {lab=VGND}
N -50 80 -20 80 {lab=VGND}
N -20 80 180 80 {lab=VGND}
N 180 80 210 80 {lab=VGND}
N 210 80 400 80 {lab=VGND}
N 400 80 440 80 {lab=VGND}
N 440 80 460 80 {lab=VGND}
N 460 80 480 80 {lab=VGND}
N -20 30 -20 80 {lab=VGND}
N 180 30 180 80 {lab=VGND}
N -50 0 -20 0 {lab=VGND}
N -50 0 -50 80 {lab=VGND}
N 180 0 210 0 {lab=VGND}
N 210 0 210 80 {lab=VGND}
N 440 30 440 80 {lab=VGND}
N 400 0 400 80 {lab=VGND}
N 440 -30 480 -30 {lab=VGND}
N 480 -30 480 80 {lab=VGND}
N 440 0 460 0 {lab=VGND}
N 460 0 460 80 {lab=VGND}
C {devices/iopin.sym} -120 -70 0 1 {name=p1 lab=REF}
C {devices/iopin.sym} 300 -70 0 0 {name=p2 lab=OUT}
C {devices/iopin.sym} -120 80 0 1 {name=p3 lab=VGND}
C {sky130_fd_pr/nfet_01v8.sym} 0 0 0 1 {name=M1 model=nfet_01v8 W=1 L=1 nf=1 mult=8 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 160 0 0 0 {name=M2 model=nfet_01v8 W=1 L=1 nf=1 mult=8 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 420 0 0 0 {name=M3 model=nfet_01v8 W=1 L=1 nf=1 mult=8 sa=0 sb=0 sd=0}
