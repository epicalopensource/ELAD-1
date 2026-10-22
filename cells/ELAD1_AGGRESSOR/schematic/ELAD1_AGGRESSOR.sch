v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {sky130_fd_pr/nfet_01v8.sym} -20 200 0 0 {name=B1N model=nfet_01v8 W=0.65 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/pfet_01v8.sym} -20 0 0 0 {name=B1P model=pfet_01v8 W=1 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 220 200 0 0 {name=B2N model=nfet_01v8 W=2 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/pfet_01v8.sym} 220 0 0 0 {name=B2P model=pfet_01v8 W=4 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 500 200 0 1 {name=IN0 model=nfet_01v8 W=2 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/pfet_01v8.sym} 500 0 0 1 {name=IP0 model=pfet_01v8 W=4 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} -20 400 0 0 {name=C0 model=nfet_01v8 W=5 L=4 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 740 200 0 1 {name=IN1 model=nfet_01v8 W=2 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/pfet_01v8.sym} 740 0 0 1 {name=IP1 model=pfet_01v8 W=4 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 220 400 0 0 {name=C1 model=nfet_01v8 W=5 L=4 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 980 200 0 1 {name=IN2 model=nfet_01v8 W=2 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/pfet_01v8.sym} 980 0 0 1 {name=IP2 model=pfet_01v8 W=4 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 460 400 0 0 {name=C2 model=nfet_01v8 W=5 L=4 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 1180 200 0 0 {name=IN3 model=nfet_01v8 W=2 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/pfet_01v8.sym} 1180 0 0 0 {name=IP3 model=pfet_01v8 W=4 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 700 400 0 0 {name=C3 model=nfet_01v8 W=5 L=4 nf=1 mult=1 sa=0 sb=0 sd=0}
N 0 200 20 200 {lab=VGND}
C {devices/lab_pin.sym} 20 200 0 1 {name=l1 sig_type=std_logic lab=VGND}
N 0 0 20 0 {lab=VDPWR}
C {devices/lab_pin.sym} 20 0 0 1 {name=l2 sig_type=std_logic lab=VDPWR}
N 240 200 260 200 {lab=VGND}
C {devices/lab_pin.sym} 260 200 0 1 {name=l3 sig_type=std_logic lab=VGND}
N 240 0 260 0 {lab=VDPWR}
C {devices/lab_pin.sym} 260 0 0 1 {name=l4 sig_type=std_logic lab=VDPWR}
N 480 200 460 200 {lab=VGND}
C {devices/lab_pin.sym} 460 200 0 0 {name=l5 sig_type=std_logic lab=VGND}
N 480 0 460 0 {lab=VDPWR}
C {devices/lab_pin.sym} 460 0 0 0 {name=l6 sig_type=std_logic lab=VDPWR}
N 0 400 20 400 {lab=VGND}
C {devices/lab_pin.sym} 20 400 0 1 {name=l7 sig_type=std_logic lab=VGND}
N 720 200 700 200 {lab=VGND}
C {devices/lab_pin.sym} 700 200 0 0 {name=l8 sig_type=std_logic lab=VGND}
N 720 0 700 0 {lab=VDPWR}
C {devices/lab_pin.sym} 700 0 0 0 {name=l9 sig_type=std_logic lab=VDPWR}
N 240 400 260 400 {lab=VGND}
C {devices/lab_pin.sym} 260 400 0 1 {name=l10 sig_type=std_logic lab=VGND}
N 960 200 940 200 {lab=VGND}
C {devices/lab_pin.sym} 940 200 0 0 {name=l11 sig_type=std_logic lab=VGND}
N 960 0 940 0 {lab=VDPWR}
C {devices/lab_pin.sym} 940 0 0 0 {name=l12 sig_type=std_logic lab=VDPWR}
N 480 400 500 400 {lab=VGND}
C {devices/lab_pin.sym} 500 400 0 1 {name=l13 sig_type=std_logic lab=VGND}
N 1200 200 1220 200 {lab=VGND}
C {devices/lab_pin.sym} 1220 200 0 1 {name=l14 sig_type=std_logic lab=VGND}
N 1200 0 1220 0 {lab=VDPWR}
C {devices/lab_pin.sym} 1220 0 0 1 {name=l15 sig_type=std_logic lab=VDPWR}
N 720 400 740 400 {lab=VGND}
C {devices/lab_pin.sym} 740 400 0 1 {name=l16 sig_type=std_logic lab=VGND}
N 0 270 240 270 {lab=VGND}
N 240 270 480 270 {lab=VGND}
N 480 270 720 270 {lab=VGND}
N 720 270 960 270 {lab=VGND}
N 960 270 1200 270 {lab=VGND}
N 0 230 0 270 {lab=VGND}
N 240 230 240 270 {lab=VGND}
N 480 230 480 270 {lab=VGND}
N 720 230 720 270 {lab=VGND}
N 960 230 960 270 {lab=VGND}
N 1200 230 1200 270 {lab=VGND}
C {devices/gnd.sym} 0 270 0 0 {name=l17 lab=VGND global=false}
N 0 -70 240 -70 {lab=VDPWR}
N 240 -70 480 -70 {lab=VDPWR}
N 480 -70 720 -70 {lab=VDPWR}
N 720 -70 960 -70 {lab=VDPWR}
N 960 -70 1200 -70 {lab=VDPWR}
N 0 -30 0 -70 {lab=VDPWR}
N 240 -30 240 -70 {lab=VDPWR}
N 480 -30 480 -70 {lab=VDPWR}
N 720 -30 720 -70 {lab=VDPWR}
N 960 -30 960 -70 {lab=VDPWR}
N 1200 -30 1200 -70 {lab=VDPWR}
C {devices/vdd.sym} 0 -70 0 0 {name=l18 lab=VDPWR global=false}
N 0 370 0 350 {lab=VGND}
C {devices/lab_pin.sym} 0 350 1 0 {name=l19 sig_type=std_logic lab=VGND}
N 240 370 240 350 {lab=VGND}
C {devices/lab_pin.sym} 240 350 1 0 {name=l20 sig_type=std_logic lab=VGND}
N 480 370 480 350 {lab=VGND}
C {devices/lab_pin.sym} 480 350 1 0 {name=l21 sig_type=std_logic lab=VGND}
N 720 370 720 350 {lab=VGND}
C {devices/lab_pin.sym} 720 350 1 0 {name=l22 sig_type=std_logic lab=VGND}
N 0 470 240 470 {lab=VGND}
N 240 470 480 470 {lab=VGND}
N 480 470 720 470 {lab=VGND}
N 0 430 0 470 {lab=VGND}
N 240 430 240 470 {lab=VGND}
N 480 430 480 470 {lab=VGND}
N 720 430 720 470 {lab=VGND}
C {devices/gnd.sym} 0 470 0 0 {name=l23 lab=VGND global=false}
N 480 170 480 130 {lab=o0}
N 480 30 480 130 {lab=o0}
N -40 400 -60 400 {lab=o0}
N -60 400 -60 130 {lab=o0}
N -60 130 480 130 {lab=o0}
C {devices/lab_pin.sym} -60 130 0 0 {name=l24 sig_type=std_logic lab=o0}
N 720 170 720 120 {lab=o1}
N 720 30 720 120 {lab=o1}
N 200 400 180 400 {lab=o1}
N 180 400 180 120 {lab=o1}
N 180 120 720 120 {lab=o1}
C {devices/lab_pin.sym} 180 120 0 0 {name=l25 sig_type=std_logic lab=o1}
N 960 170 960 130 {lab=o2}
N 960 30 960 130 {lab=o2}
C {devices/lab_pin.sym} 960 130 0 0 {name=l26 sig_type=std_logic lab=o2}
N 440 400 420 400 {lab=o2}
C {devices/lab_pin.sym} 420 400 0 0 {name=l27 sig_type=std_logic lab=o2}
N 1200 170 1200 130 {lab=o3}
N 1200 30 1200 130 {lab=o3}
C {devices/lab_pin.sym} 1200 130 0 0 {name=l28 sig_type=std_logic lab=o3}
N 680 400 660 400 {lab=o3}
C {devices/lab_pin.sym} 660 400 0 0 {name=l29 sig_type=std_logic lab=o3}
N 0 170 0 70 {lab=b1}
N 0 30 0 70 {lab=b1}
N 200 200 160 200 {lab=b1}
N 160 200 160 70 {lab=b1}
N 200 0 160 0 {lab=b1}
N 160 0 160 70 {lab=b1}
N 0 70 160 70 {lab=b1}
C {devices/lab_pin.sym} 0 70 0 0 {name=l30 sig_type=std_logic lab=b1}
N 240 170 240 70 {lab=b2}
N 240 30 240 70 {lab=b2}
C {devices/lab_pin.sym} 240 70 0 0 {name=l31 sig_type=std_logic lab=b2}
N 520 200 540 200 {lab=b2}
C {devices/lab_pin.sym} 540 200 0 1 {name=l32 sig_type=std_logic lab=b2}
N 520 0 540 0 {lab=b2}
C {devices/lab_pin.sym} 540 0 0 1 {name=l33 sig_type=std_logic lab=b2}
N 760 200 780 200 {lab=b2}
C {devices/lab_pin.sym} 780 200 0 1 {name=l34 sig_type=std_logic lab=b2}
N 760 0 780 0 {lab=b2}
C {devices/lab_pin.sym} 780 0 0 1 {name=l35 sig_type=std_logic lab=b2}
N 1000 200 1020 200 {lab=b2}
C {devices/lab_pin.sym} 1020 200 0 1 {name=l36 sig_type=std_logic lab=b2}
N 1000 0 1020 0 {lab=b2}
C {devices/lab_pin.sym} 1020 0 0 1 {name=l37 sig_type=std_logic lab=b2}
N 1160 200 1140 200 {lab=b2}
C {devices/lab_pin.sym} 1140 200 0 0 {name=l38 sig_type=std_logic lab=b2}
N 1160 0 1140 0 {lab=b2}
C {devices/lab_pin.sym} 1140 0 0 0 {name=l39 sig_type=std_logic lab=b2}
N -40 200 -80 200 {lab=AGG_CLK}
N -80 200 -80 0 {lab=AGG_CLK}
N -40 0 -80 0 {lab=AGG_CLK}
N -140 0 -80 0 {lab=AGG_CLK}
C {devices/iopin.sym} -140 0 0 1 {name=p40 lab=AGG_CLK}
C {devices/iopin.sym} -300 -70 0 1 {name=p41 lab=VDPWR}
C {devices/iopin.sym} -300 -30 0 1 {name=p42 lab=VGND}
