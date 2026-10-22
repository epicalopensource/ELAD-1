v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -160 0 -60 0 {}
N 60 0 120 0 {}
N 120 0 180 0 {}
N 300 0 400 0 {}
N 120 0 120 170 {}
N 40 200 80 200 {}
N 120 230 120 290 {}
N 120 200 150 200 {}
N 150 200 150 290 {}
N -160 -130 0 -130 {}
N 0 -130 0 -60 {}
N 0 -130 240 -130 {}
N 240 -130 240 -60 {}
N -160 130 0 130 {}
N 0 60 0 130 {}
N 240 60 240 100 {}
N -160 -190 -100 -190 {}
N -160 290 120 290 {}
N 120 290 150 290 {}
C {devices/iopin.sym} -160 0 0 1 {name=p1 lab=A}
C {devices/iopin.sym} 400 0 0 0 {name=p2 lab=B}
C {devices/iopin.sym} -160 130 0 1 {name=p3 lab=EN}
C {devices/iopin.sym} -160 -130 0 1 {name=p4 lab=ENB}
C {devices/iopin.sym} -160 -190 0 1 {name=p5 lab=VDPWR}
C {devices/iopin.sym} -160 290 0 1 {name=p6 lab=VGND}
C {ELAD1_TGA.sym} 0 0 0 0 {name=X1}
C {ELAD1_TGA.sym} 240 0 0 0 {name=X2}
C {sky130_fd_pr/nfet_01v8.sym} 100 200 0 0 {name=SH model=nfet_01v8 W=1 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {devices/lab_pin.sym} 120 0 0 1 {name=l7 sig_type=std_logic lab=M}
C {devices/lab_pin.sym} 40 200 0 0 {name=l8 sig_type=std_logic lab=ENB}
C {devices/lab_pin.sym} 240 100 0 1 {name=l9 sig_type=std_logic lab=EN}
C {devices/vdd.sym} -100 -190 0 0 {name=l10 lab=VDPWR global=false}
C {devices/vdd.sym} 40 -60 0 0 {name=l11 lab=VDPWR global=false}
C {devices/gnd.sym} 40 60 0 0 {name=l12 lab=VGND global=false}
C {devices/vdd.sym} 280 -60 0 0 {name=l13 lab=VDPWR global=false}
C {devices/gnd.sym} 280 60 0 0 {name=l14 lab=VGND global=false}
T {ELAD1_TSW: T-switch, two low-Vt gates in series with a shunt to VGND on the middle node} -160 -280 0 0 0.35 0.35 {}
T {ON (EN=1): A-M-B connected, shunt off.  OFF: both gates open and M held at VGND (isolation)} -160 -245 0 0 0.22 0.22 {}
