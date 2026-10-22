v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -100 -100 -30 -100 {}
N -100 -100 -100 0 {}
N -100 0 -100 100 {}
N -100 100 -30 100 {}
N 30 -100 100 -100 {}
N 100 -100 100 0 {}
N 100 0 100 100 {}
N 30 100 100 100 {}
N -200 0 -100 0 {}
N 100 0 200 0 {}
N -200 -190 0 -190 {}
N 0 -190 0 -140 {}
N -200 190 0 190 {}
N 0 140 0 190 {}
N 0 -100 0 -20 {}
N 0 20 0 100 {}
N -200 -260 -150 -260 {}
N -200 260 -150 260 {}
C {devices/iopin.sym} -200 0 0 1 {name=p1 lab=A}
C {devices/iopin.sym} 200 0 0 0 {name=p2 lab=B}
C {devices/iopin.sym} -200 190 0 1 {name=p3 lab=EN}
C {devices/iopin.sym} -200 -190 0 1 {name=p4 lab=ENB}
C {devices/iopin.sym} -200 -260 0 1 {name=p5 lab=VDPWR}
C {devices/iopin.sym} -200 260 0 1 {name=p6 lab=VGND}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 0 -120 1 0 {name=MP model=pfet_01v8_lvt W=12 L=0.35 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 0 120 3 0 {name=MN model=nfet_01v8_lvt W=4 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {devices/lab_pin.sym} 0 -20 0 1 {name=l7 sig_type=std_logic lab=VDPWR}
C {devices/lab_pin.sym} 0 20 0 1 {name=l8 sig_type=std_logic lab=VGND}
C {devices/lab_pin.sym} -150 -260 0 1 {name=l9 sig_type=std_logic lab=VDPWR}
C {devices/lab_pin.sym} -150 260 0 1 {name=l10 sig_type=std_logic lab=VGND}
T {ELAD1_TGA: CMOS transmission gate, low-Vt} -200 -360 0 0 0.35 0.35 {}
T {PMOS gate = ENB, NMOS gate = EN; A-B connected when EN = 1} -200 -325 0 0 0.22 0.22 {}
