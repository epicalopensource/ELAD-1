v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {ELAD1_HEATER} -120 -300 0 0 0.35 0.35 {}
T {RH[1:0]: 2 parallel poly resistors;} -120 -260 0 0 0.22 0.22 {}
T {MSW switches them to VGND (gate HEN)} -120 -235 0 0 0.22 0.22 {}
N -120 -180 20 -180 {lab=HIN}
N 20 -180 20 -150 {lab=HIN}
N 20 -90 20 -60 {lab=HD}
N 20 -60 20 -30 {lab=HD}
N -120 0 -20 0 {lab=HEN}
N -120 80 20 80 {lab=VGND}
N 20 80 60 80 {lab=VGND}
N 20 30 20 80 {lab=VGND}
N 20 0 60 0 {lab=VGND}
N 60 0 60 80 {lab=VGND}
N 40 -120 60 -120 {lab=VGND}
N 60 -120 60 0 {lab=VGND}
C {devices/iopin.sym} -120 -180 0 1 {name=p1 lab=HIN}
C {devices/iopin.sym} -120 0 0 1 {name=p2 lab=HEN}
C {devices/iopin.sym} -120 80 0 1 {name=p3 lab=VGND}
C {sky130_fd_pr/nfet_01v8.sym} 0 0 0 0 {name=MSW model=nfet_01v8 W=40 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {devices/lab_pin.sym} 20 -60 0 1 {name=l4 sig_type=std_logic lab=HD}
C {sky130_fd_pr/res_high_po_5p73.sym} 20 -120 0 1 {name=R1[1:0]
L=51.8
model=res_high_po_5p73
spiceprefix=X
mult=1}
