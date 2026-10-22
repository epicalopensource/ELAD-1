v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {sky130_fd_pr/nfet_01v8_lvt.sym} -20 0 0 0 {name=MN model=nfet_01v8_lvt W=4 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 220 0 0 0 {name=MP model=pfet_01v8_lvt W=12 L=0.35 nf=1 mult=1 sa=0 sb=0 sd=0}
N 0 0 20 0 {lab=VGND}
C {devices/lab_pin.sym} 20 0 0 1 {name=l1 sig_type=std_logic lab=VGND}
N 240 0 260 0 {lab=VDPWR}
C {devices/lab_pin.sym} 260 0 0 1 {name=l2 sig_type=std_logic lab=VDPWR}
N 0 -30 0 -50 {lab=A}
C {devices/lab_pin.sym} 0 -50 1 0 {name=l3 sig_type=std_logic lab=A}
N 240 30 240 50 {lab=A}
C {devices/lab_pin.sym} 240 50 3 0 {name=l4 sig_type=std_logic lab=A}
N 0 30 0 50 {lab=B}
C {devices/lab_pin.sym} 0 50 3 0 {name=l5 sig_type=std_logic lab=B}
N 240 -30 240 -50 {lab=B}
C {devices/lab_pin.sym} 240 -50 1 0 {name=l6 sig_type=std_logic lab=B}
N -40 0 -60 0 {lab=EN}
N -120 0 -60 0 {lab=EN}
N 200 0 180 0 {lab=ENB}
N 120 0 180 0 {lab=ENB}
C {devices/iopin.sym} -280 50 0 1 {name=p11 lab=A}
C {devices/iopin.sym} -280 90 0 1 {name=p12 lab=B}
C {devices/iopin.sym} -120 0 0 1 {name=p7 lab=EN}
C {devices/iopin.sym} 120 0 0 1 {name=p8 lab=ENB}
C {devices/iopin.sym} -280 -30 0 1 {name=p9 lab=VDPWR}
C {devices/iopin.sym} -280 10 0 1 {name=p10 lab=VGND}
