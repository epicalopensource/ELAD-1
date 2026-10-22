v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {ELAD1_TGA.sym} 540 0 0 0 {name=X1}
C {ELAD1_TGA.sym} 940 0 0 0 {name=X2}
C {sky130_fd_pr/nfet_01v8.sym} -20 0 0 0 {name=SH model=nfet_01v8 W=1 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
N 0 0 20 0 {lab=VGND}
C {devices/lab_pin.sym} 20 0 0 1 {name=l1 sig_type=std_logic lab=VGND}
N 620 0 640 0 {lab=VDPWR}
C {devices/lab_pin.sym} 640 0 0 1 {name=l2 sig_type=std_logic lab=VDPWR}
N 1020 0 1040 0 {lab=VDPWR}
C {devices/lab_pin.sym} 1040 0 0 1 {name=l3 sig_type=std_logic lab=VDPWR}
N 620 20 640 20 {lab=VGND}
C {devices/lab_pin.sym} 640 20 0 1 {name=l4 sig_type=std_logic lab=VGND}
N 1020 20 1040 20 {lab=VGND}
C {devices/lab_pin.sym} 1040 20 0 1 {name=l5 sig_type=std_logic lab=VGND}
N 0 30 0 50 {lab=VGND}
C {devices/gnd.sym} 0 50 0 0 {name=l6 lab=VGND global=false}
N 460 -20 440 -20 {lab=A}
N 380 -20 440 -20 {lab=A}
N 860 0 840 0 {lab=B}
N 780 0 840 0 {lab=B}
N 460 20 440 20 {lab=EN}
N 440 20 440 70 {lab=EN}
N 860 20 840 20 {lab=EN}
N 840 20 840 70 {lab=EN}
N 380 70 440 70 {lab=EN}
N 440 70 840 70 {lab=EN}
N 460 0 420 0 {lab=M}
N 420 0 420 -70 {lab=M}
N 860 -20 820 -20 {lab=M}
N 820 -20 820 -70 {lab=M}
N 0 -30 0 -70 {lab=M}
N 0 -70 420 -70 {lab=M}
N 420 -70 820 -70 {lab=M}
C {devices/lab_pin.sym} 0 -70 0 0 {name=l10 sig_type=std_logic lab=M}
N 620 -20 640 -20 {lab=ENB}
N 640 -20 640 -80 {lab=ENB}
N 1020 -20 1040 -20 {lab=ENB}
N 1040 -20 1040 -80 {lab=ENB}
N -40 0 -60 0 {lab=ENB}
N -60 0 -60 -80 {lab=ENB}
N -120 -80 -60 -80 {lab=ENB}
N -60 -80 640 -80 {lab=ENB}
N 640 -80 1040 -80 {lab=ENB}
C {devices/iopin.sym} 380 -20 0 1 {name=p7 lab=A}
C {devices/iopin.sym} 780 0 0 1 {name=p8 lab=B}
C {devices/iopin.sym} 380 70 0 1 {name=p9 lab=EN}
C {devices/iopin.sym} -120 -80 0 1 {name=p11 lab=ENB}
C {devices/iopin.sym} -280 -80 0 1 {name=p12 lab=VDPWR}
C {devices/iopin.sym} -280 -40 0 1 {name=p13 lab=VGND}
