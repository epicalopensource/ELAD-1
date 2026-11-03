v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {ELAD1_PAIR_CC: NMOS differential pair, mirrored tail} -220 -250 0 0 0.35 0.35 {}
T {unit W/L = 2 / 1 um.  A[3:0], B[3:0] = 4 input units each, T[3:0] = 4 tail units,} -220 -210 0 0 0.22 0.22 {}
T {R[3:0] = 4 bias-diode units, DUM[31:0] = 32 dummies (X[n:0] = n+1 parallel units).  Layout: common centroid} -220 -185 0 0 0.22 0.22 {}
N -220 0 -20 0 {lab=VINP}
N 220 0 380 0 {lab=VINM}
N 20 -90 20 -30 {lab=D1}
N -220 -90 20 -90 {lab=D1}
N 180 -90 180 -30 {lab=D2}
N 180 -90 380 -90 {lab=D2}
N 20 30 20 60 {lab=TAIL}
N 20 60 100 60 {lab=TAIL}
N 100 60 180 60 {lab=TAIL}
N 180 30 180 60 {lab=TAIL}
N 100 60 100 100 {lab=TAIL}
N -60 130 -20 130 {lab=VBIAS}
N -20 130 60 130 {lab=VBIAS}
N -220 70 -100 70 {lab=VBIAS}
N -100 70 -100 100 {lab=VBIAS}
N -100 70 -20 70 {lab=VBIAS}
N -20 70 -20 130 {lab=VBIAS}
N 20 0 100 0 {lab=VGND}
N 100 0 180 0 {lab=VGND}
N 100 -50 100 0 {lab=VGND}
N -220 200 -120 200 {lab=VGND}
N -120 200 -100 200 {lab=VGND}
N -100 200 100 200 {lab=VGND}
N 100 200 130 200 {lab=VGND}
N 130 200 480 200 {lab=VGND}
N 480 200 520 200 {lab=VGND}
N 520 200 540 200 {lab=VGND}
N 540 200 560 200 {lab=VGND}
N 100 160 100 200 {lab=VGND}
N 100 130 130 130 {lab=VGND}
N 130 130 130 200 {lab=VGND}
N -100 160 -100 200 {lab=VGND}
N -120 130 -100 130 {lab=VGND}
N -120 130 -120 200 {lab=VGND}
N 520 160 520 200 {lab=VGND}
N 480 130 480 200 {lab=VGND}
N 520 100 560 100 {lab=VGND}
N 560 100 560 200 {lab=VGND}
N 520 130 540 130 {lab=VGND}
N 540 130 540 200 {lab=VGND}
C {devices/iopin.sym} -220 -90 0 1 {name=p1 lab=D1}
C {devices/iopin.sym} 380 -90 0 0 {name=p2 lab=D2}
C {devices/iopin.sym} -220 0 0 1 {name=p3 lab=VINP}
C {devices/iopin.sym} 380 0 0 0 {name=p4 lab=VINM}
C {devices/iopin.sym} -220 70 0 1 {name=p5 lab=VBIAS}
C {devices/iopin.sym} -220 200 0 1 {name=p6 lab=VGND}
C {sky130_fd_pr/nfet_01v8.sym} 0 0 0 0 {name=MN1 model=nfet_01v8 W=2 L=1 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 200 0 0 1 {name=MN2 model=nfet_01v8 W=2 L=1 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 80 130 0 0 {name=MN3 model=nfet_01v8 W=2 L=1 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} -80 130 0 1 {name=MR2 model=nfet_01v8 W=2 L=1 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 500 130 0 0 {name=MN4 model=nfet_01v8 W=2 L=1 nf=1 mult=1 sa=0 sb=0 sd=0}
C {devices/lab_pin.sym} 100 60 0 1 {name=l7 sig_type=std_logic lab=TAIL}
C {devices/lab_pin.sym} 100 -50 0 1 {name=l8 sig_type=std_logic lab=VGND}
