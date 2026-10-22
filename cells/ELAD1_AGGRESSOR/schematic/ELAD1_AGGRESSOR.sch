v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -150 0 -50 0 {}
N -50 -60 -20 -60 {}
N -50 -60 -50 0 {}
N -50 0 -50 60 {}
N -50 60 -20 60 {}
N 20 -30 20 0 {}
N 20 0 20 30 {}
N 20 -120 20 -90 {}
N 20 -60 60 -60 {}
N 60 -120 60 -60 {}
N 20 90 20 120 {}
N 20 60 60 60 {}
N 60 60 60 120 {}
N 20 0 100 0 {}
N 100 0 170 0 {}
N 170 -60 200 -60 {}
N 170 -60 170 0 {}
N 170 0 170 60 {}
N 170 60 200 60 {}
N 240 -30 240 0 {}
N 240 0 240 30 {}
N 240 -120 240 -90 {}
N 240 -60 280 -60 {}
N 280 -120 280 -60 {}
N 240 90 240 120 {}
N 240 60 280 60 {}
N 280 60 280 120 {}
N 240 0 320 0 {}
N 320 0 390 0 {}
N 390 -60 420 -60 {}
N 390 -60 390 0 {}
N 390 0 390 60 {}
N 390 60 420 60 {}
N 460 -30 460 0 {}
N 460 0 460 30 {}
N 460 -120 460 -90 {}
N 460 -60 500 -60 {}
N 500 -120 500 -60 {}
N 460 90 460 120 {}
N 460 60 500 60 {}
N 500 60 500 120 {}
N 460 0 540 0 {}
N 540 0 680 0 {}
N 720 30 720 120 {}
N 720 0 740 0 {}
N 740 0 740 120 {}
N 720 -30 760 -30 {}
N 760 -30 760 120 {}
N -150 -120 20 -120 {}
N 20 -120 60 -120 {}
N 60 -120 240 -120 {}
N 240 -120 280 -120 {}
N 280 -120 460 -120 {}
N 460 -120 500 -120 {}
N -150 120 20 120 {}
N 20 120 60 120 {}
N 60 120 240 120 {}
N 240 120 280 120 {}
N 280 120 460 120 {}
N 460 120 500 120 {}
N 500 120 720 120 {}
N 720 120 740 120 {}
N 740 120 760 120 {}
C {devices/iopin.sym} -150 0 0 1 {name=p1 lab=AGG_CLK}
C {devices/iopin.sym} -150 -120 0 1 {name=p2 lab=VDPWR}
C {devices/iopin.sym} -150 120 0 1 {name=p3 lab=VGND}
C {sky130_fd_pr/pfet_01v8.sym} 0 -60 0 0 {name=B1P model=pfet_01v8 W=1 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 0 60 0 0 {name=B1N model=nfet_01v8 W=0.65 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {devices/lab_pin.sym} 100 0 0 1 {name=l4 sig_type=std_logic lab=b1}
C {sky130_fd_pr/pfet_01v8.sym} 220 -60 0 0 {name=B2P model=pfet_01v8 W=4 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 220 60 0 0 {name=B2N model=nfet_01v8 W=2 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {devices/lab_pin.sym} 320 0 0 1 {name=l5 sig_type=std_logic lab=b2}
C {sky130_fd_pr/pfet_01v8.sym} 440 -60 0 0 {name=IP[3:0] model=pfet_01v8 W=4 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 440 60 0 0 {name=IN[3:0] model=nfet_01v8 W=2 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {devices/lab_pin.sym} 540 0 0 1 {name=l6 sig_type=std_logic lab=o3,o2,o1,o0}
C {sky130_fd_pr/nfet_01v8.sym} 700 0 0 0 {name=C[3:0] model=nfet_01v8 W=5 L=4 nf=1 mult=1 sa=0 sb=0 sd=0}
T {ELAD1_AGGRESSOR: buffered clock driving 4 MOS-capacitor loads (substrate-noise source)} -150 -220 0 0 0.35 0.35 {}
T {b1, b2: buffer chain; IP/IN[3:0] = 4 output inverters, each loading its own C[3:0] (W/L 5/4) on o3..o0} -150 -185 0 0 0.22 0.22 {}
