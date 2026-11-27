v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {ELAD1_AGGRESSOR: on-chip substrate aggressor, steered current into the shared tap SUBI} -760 -470 0 0 0.4 0.4 {}
T {EN = 1 (noise mode): ~90 uA from VDPWR through RL is steered by AGG_CLK -
AGG_CLK = 1: through MINJ out of SUBI into the substrate tap (the tap rises ~60 mV)
AGG_CLK = 0: through MDUM and RDUM to VGND.  The supply current stays the same in both states.
EN = 0: both switches off, no current.  SUBI is the same tap that ua0 (force) and ua2 (sense) reach.} -760 -425 0 0 0.22 0.22 {}
T {Layout: SUBI = P+ taps of an isolated tap island (SUBCUT), equidistant from both victims;
no VGND taps inside it.  RL, RDUM and the logic outside the island, away from the victims.} -760 380 0 0 0.22 0.22 {}
N -760 -300 -700 -300 {lab=VDPWR}
N -790 300 -730 300 {lab=VGND}
N -390 -140 -330 -140 {lab=CKB}
N -180 -80 -160 -80 {lab=gip}
N -180 -20 -180 10 {lab=GI}
N -180 10 -180 30 {lab=GI}
N -180 -110 -100 -110 {lab=VDPWR}
N -100 -140 -100 -110 {lab=VDPWR}
N -180 -140 -100 -140 {lab=VDPWR}
N -180 -50 -100 -50 {lab=VDPWR}
N -100 -110 -100 -50 {lab=VDPWR}
N -180 10 -40 10 {lab=GI}
N -40 10 -40 30 {lab=GI}
N -40 10 60 10 {lab=GI}
N -180 90 -180 120 {lab=VGND}
N -180 120 -150 120 {lab=VGND}
N -150 120 -110 120 {lab=VGND}
N -110 120 -70 120 {lab=VGND}
N -70 120 -40 120 {lab=VGND}
N -40 90 -40 120 {lab=VGND}
N -180 60 -150 60 {lab=VGND}
N -150 60 -150 120 {lab=VGND}
N -70 60 -40 60 {lab=VGND}
N -70 60 -70 120 {lab=VGND}
N -260 -110 -220 -110 {lab=ENB}
N -260 -50 -220 -50 {lab=CKB}
N -260 60 -220 60 {lab=ENB}
N 0 60 60 60 {lab=CKB}
N 300 -80 320 -80 {lab=gdp}
N 300 -20 300 10 {lab=GD}
N 300 10 300 30 {lab=GD}
N 300 -110 380 -110 {lab=VDPWR}
N 380 -140 380 -110 {lab=VDPWR}
N 300 -140 380 -140 {lab=VDPWR}
N 300 -50 380 -50 {lab=VDPWR}
N 380 -110 380 -50 {lab=VDPWR}
N 300 10 440 10 {lab=GD}
N 440 10 440 30 {lab=GD}
N 440 10 540 10 {lab=GD}
N 300 90 300 120 {lab=VGND}
N 300 120 330 120 {lab=VGND}
N 330 120 370 120 {lab=VGND}
N 370 120 410 120 {lab=VGND}
N 410 120 440 120 {lab=VGND}
N 440 90 440 120 {lab=VGND}
N 300 60 330 60 {lab=VGND}
N 330 60 330 120 {lab=VGND}
N 410 60 440 60 {lab=VGND}
N 410 60 410 120 {lab=VGND}
N 220 -110 260 -110 {lab=ENB}
N 220 -50 260 -50 {lab=AGG_CLK}
N 220 60 260 60 {lab=ENB}
N 480 60 540 60 {lab=AGG_CLK}
N 800 -220 840 -220 {lab=VGND}
N 860 -190 860 -130 {lab=X}
N 780 -130 780 -100 {lab=X}
N 780 -130 860 -130 {lab=X}
N 860 -130 920 -130 {lab=X}
N 920 -130 980 -130 {lab=X}
N 980 -130 980 -100 {lab=X}
N 700 -70 740 -70 {lab=GI}
N 780 -70 820 -70 {lab=VGND}
N 820 -70 820 -30 {lab=VGND}
N 780 -40 780 30 {lab=SUBI}
N 660 30 780 30 {lab=SUBI}
N 1020 -70 1060 -70 {lab=GD}
N 940 -70 980 -70 {lab=VGND}
N 940 -70 940 -30 {lab=VGND}
N 980 -40 980 -10 {lab=D}
N 980 -10 980 20 {lab=D}
N 980 -10 1020 -10 {lab=D}
N -650 -140 -580 -140 {lab=AGG_CLK}
N -580 -200 -550 -200 {lab=AGG_CLK}
N -580 -200 -580 -140 {lab=AGG_CLK}
N -580 -140 -580 -80 {lab=AGG_CLK}
N -580 -80 -550 -80 {lab=AGG_CLK}
N -510 -140 -510 -110 {lab=CKB}
N -510 -140 -390 -140 {lab=CKB}
N -650 -260 -510 -260 {lab=VDPWR}
N -510 -260 -470 -260 {lab=VDPWR}
N -510 -260 -510 -230 {lab=VDPWR}
N -510 -200 -470 -200 {lab=VDPWR}
N -470 -260 -470 -200 {lab=VDPWR}
N -650 -20 -510 -20 {lab=VGND}
N -510 -20 -470 -20 {lab=VGND}
N -510 -50 -510 -20 {lab=VGND}
N -510 -80 -470 -80 {lab=VGND}
N -470 -80 -470 -20 {lab=VGND}
N -390 180 -330 180 {lab=ENB}
N -650 180 -580 180 {lab=EN}
N -580 120 -550 120 {lab=EN}
N -580 120 -580 180 {lab=EN}
N -580 180 -580 240 {lab=EN}
N -580 240 -550 240 {lab=EN}
N -510 180 -510 210 {lab=ENB}
N -510 180 -390 180 {lab=ENB}
N -650 60 -510 60 {lab=VDPWR}
N -510 60 -470 60 {lab=VDPWR}
N -510 60 -510 90 {lab=VDPWR}
N -510 120 -470 120 {lab=VDPWR}
N -470 60 -470 120 {lab=VDPWR}
N -650 300 -510 300 {lab=VGND}
N -510 300 -470 300 {lab=VGND}
N -510 270 -510 300 {lab=VGND}
N -510 240 -470 240 {lab=VGND}
N -470 240 -470 300 {lab=VGND}
N -510 -170 -510 -140 {lab=CKB}
N -510 150 -510 180 {lab=ENB}
C {devices/iopin.sym} -650 -140 0 1 {name=p1 lab=AGG_CLK}
C {devices/iopin.sym} -650 180 0 1 {name=p2 lab=EN}
C {devices/iopin.sym} -760 -300 0 1 {name=p3 lab=VDPWR}
C {devices/iopin.sym} -790 300 0 1 {name=p4 lab=VGND}
C {devices/iopin.sym} 660 30 0 1 {name=p34 lab=SUBI}
C {devices/vdd.sym} -700 -300 0 0 {name=l5 lab=VDPWR global=false}
C {devices/gnd.sym} -730 300 0 0 {name=l6 lab=VGND global=false}
C {devices/lab_pin.sym} -330 -140 0 1 {name=l7 sig_type=std_logic lab=CKB}
C {devices/vdd.sym} -650 -260 0 0 {name=l8 lab=VDPWR global=false}
C {devices/gnd.sym} -650 -20 0 0 {name=l9 lab=VGND global=false}
C {devices/lab_pin.sym} -330 180 0 1 {name=l10 sig_type=std_logic lab=ENB}
C {sky130_fd_pr/pfet_01v8.sym} -200 -110 0 0 {name=MGIP1 model=pfet_01v8 W=2 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/pfet_01v8.sym} -200 -50 0 0 {name=MGIP2 model=pfet_01v8 W=2 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} -200 60 0 0 {name=MGIN1 model=nfet_01v8 W=0.42 L=1 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} -20 60 0 1 {name=MGIN2 model=nfet_01v8 W=0.42 L=1 nf=1 mult=1 sa=0 sb=0 sd=0}
C {devices/vdd.sym} -180 -140 0 0 {name=l13 lab=VDPWR global=false}
C {devices/lab_pin.sym} -160 -80 0 1 {name=l14 sig_type=std_logic lab=gip}
C {devices/lab_pin.sym} 60 10 0 1 {name=l15 sig_type=std_logic lab=GI}
C {devices/gnd.sym} -110 120 0 0 {name=l16 lab=VGND global=false}
C {devices/lab_pin.sym} -260 -110 0 0 {name=l17 sig_type=std_logic lab=ENB}
C {devices/lab_pin.sym} -260 -50 0 0 {name=l18 sig_type=std_logic lab=CKB}
C {devices/lab_pin.sym} -260 60 0 0 {name=l19 sig_type=std_logic lab=ENB}
C {devices/lab_pin.sym} 60 60 0 1 {name=l20 sig_type=std_logic lab=CKB}
C {sky130_fd_pr/pfet_01v8.sym} 280 -110 0 0 {name=MGDP1 model=pfet_01v8 W=2 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/pfet_01v8.sym} 280 -50 0 0 {name=MGDP2 model=pfet_01v8 W=2 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 280 60 0 0 {name=MGDN1 model=nfet_01v8 W=0.42 L=1 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 460 60 0 1 {name=MGDN2 model=nfet_01v8 W=0.42 L=1 nf=1 mult=1 sa=0 sb=0 sd=0}
C {devices/vdd.sym} 300 -140 0 0 {name=l21 lab=VDPWR global=false}
C {devices/lab_pin.sym} 320 -80 0 1 {name=l22 sig_type=std_logic lab=gdp}
C {devices/lab_pin.sym} 540 10 0 1 {name=l23 sig_type=std_logic lab=GD}
C {devices/gnd.sym} 370 120 0 0 {name=l24 lab=VGND global=false}
C {devices/lab_pin.sym} 220 -110 0 0 {name=l25 sig_type=std_logic lab=ENB}
C {devices/lab_pin.sym} 220 -50 0 0 {name=l26 sig_type=std_logic lab=AGG_CLK}
C {devices/lab_pin.sym} 220 60 0 0 {name=l27 sig_type=std_logic lab=ENB}
C {devices/lab_pin.sym} 540 60 0 1 {name=l28 sig_type=std_logic lab=AGG_CLK}
C {sky130_fd_pr/res_xhigh_po_0p69.sym} 860 -220 0 0 {name=RL model=res_xhigh_po_0p69 L=7.3 mult=1}
C {devices/vdd.sym} 860 -250 0 0 {name=l29 lab=VDPWR global=false}
C {devices/lab_pin.sym} 800 -220 0 0 {name=l30 sig_type=std_logic lab=VGND}
C {sky130_fd_pr/nfet_01v8.sym} 760 -70 0 0 {name=MINJ model=nfet_01v8 W=2 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} 1000 -70 0 1 {name=MDUM model=nfet_01v8 W=2 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {devices/lab_pin.sym} 920 -130 0 1 {name=l31 sig_type=std_logic lab=X}
C {devices/lab_pin.sym} 700 -70 0 0 {name=l32 sig_type=std_logic lab=GI}
C {devices/gnd.sym} 820 -30 0 0 {name=l33 lab=VGND global=false}
C {devices/lab_pin.sym} 1060 -70 0 1 {name=l35 sig_type=std_logic lab=GD}
C {devices/gnd.sym} 940 -30 0 0 {name=l36 lab=VGND global=false}
C {sky130_fd_pr/res_generic_po.sym} 980 50 0 0 {name=RDUM model=res_generic_po W=1 L=15 mult=1}
C {devices/lab_pin.sym} 1020 -10 0 1 {name=l37 sig_type=std_logic lab=D}
C {devices/gnd.sym} 980 80 0 0 {name=l38 lab=VGND global=false}
C {sky130_fd_pr/pfet_01v8.sym} -530 -200 0 0 {name=MP model=pfet_01v8 W=1 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} -530 -80 0 0 {name=MN model=nfet_01v8 W=0.65 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {devices/vdd.sym} -650 60 0 0 {name=l2 lab=VDPWR global=false}
C {devices/gnd.sym} -650 300 0 0 {name=l3 lab=VGND global=false}
C {sky130_fd_pr/pfet_01v8.sym} -530 120 0 0 {name=MP1 model=pfet_01v8 W=1 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} -530 240 0 0 {name=MN1 model=nfet_01v8 W=0.65 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
