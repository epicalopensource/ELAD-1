v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {ELAD1_MIRROR_GROUPED: 1:1 NMOS current mirror} 110 -390 0 0 0.35 0.35 {}
T {unit W/L = 2 / 1 um.  A[3:0] = 4 diode units, B[3:0] = 4 output units, DUM[15:0] = 16 dummies} 110 -350 0 0 0.22 0.22 {}
T {(an array name X[n:0] is n+1 parallel units).  Layout: grouped AAAA BBBB} 110 -325 0 0 0.22 0.22 {}
N 250 -160 310 -160 {lab=REF}
N 310 -160 370 -160 {lab=REF}
N 110 -230 210 -230 {lab=REF}
N 210 -230 210 -190 {lab=REF}
N 210 -230 310 -230 {lab=REF}
N 310 -230 310 -160 {lab=REF}
N 410 -230 410 -190 {lab=OUT}
N 410 -230 530 -230 {lab=OUT}
N 110 -80 180 -80 {lab=VGND}
N 180 -80 210 -80 {lab=VGND}
N 210 -80 410 -80 {lab=VGND}
N 410 -80 440 -80 {lab=VGND}
N 440 -80 630 -80 {lab=VGND}
N 630 -80 670 -80 {lab=VGND}
N 670 -80 690 -80 {lab=VGND}
N 690 -80 710 -80 {lab=VGND}
N 210 -130 210 -80 {lab=VGND}
N 410 -130 410 -80 {lab=VGND}
N 180 -160 210 -160 {lab=VGND}
N 180 -160 180 -80 {lab=VGND}
N 410 -160 440 -160 {lab=VGND}
N 440 -160 440 -80 {lab=VGND}
N 670 -130 670 -80 {lab=VGND}
N 630 -160 630 -80 {lab=VGND}
N 670 -190 710 -190 {lab=VGND}
N 710 -190 710 -80 {lab=VGND}
N 670 -160 690 -160 {lab=VGND}
N 690 -160 690 -80 {lab=VGND}
C {devices/iopin.sym} 110 -230 0 1 {name=p1 lab=REF}
C {devices/iopin.sym} 530 -230 0 0 {name=p2 lab=OUT}
C {devices/iopin.sym} 110 -80 0 1 {name=p3 lab=VGND}
C {sky130_fd_pr/nfet_01v8.sym} 230 -160 0 1 {name=M1 model=nfet_01v8 W=1 L=1 nf=1 mult=8 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 390 -160 0 0 {name=M2 model=nfet_01v8 W=1 L=1 nf=1 mult=8 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 650 -160 0 0 {name=M3 model=nfet_01v8 W=1 L=1 nf=1 mult=8 sa=0 sb=0 sd=0}
