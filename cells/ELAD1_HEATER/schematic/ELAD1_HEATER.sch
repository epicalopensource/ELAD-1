v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -120 -180 20 -180 {}
N 20 -180 20 -150 {}
N 20 -90 20 -60 {}
N 20 -60 20 -30 {}
N -120 0 -20 0 {}
N -120 80 20 80 {}
N 20 80 60 80 {}
N 20 30 20 80 {}
N 20 0 60 0 {}
N 60 0 60 80 {}
N 40 -120 60 -120 {}
N 60 -120 60 0 {}
C {devices/iopin.sym} -120 -180 0 1 {name=p1 lab=HIN}
C {devices/iopin.sym} -120 0 0 1 {name=p2 lab=HEN}
C {devices/iopin.sym} -120 80 0 1 {name=p3 lab=VGND}
C {sky130_fd_pr/res_high_po.sym} 20 -120 2 0 {name=RH[1:0] model=res_high_po W=5.73 L=52.9 mult=1}
C {sky130_fd_pr/nfet_01v8.sym} 0 0 0 0 {name=MSW model=nfet_01v8 W=40 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
C {devices/lab_pin.sym} 20 -60 0 1 {name=l4 sig_type=std_logic lab=HD}
T {ELAD1_HEATER} -120 -300 0 0 0.35 0.35 {}
T {RH[1:0]: 2 parallel poly resistors;} -120 -260 0 0 0.22 0.22 {}
T {MSW switches them to VGND (gate HEN)} -120 -235 0 0 0.22 0.22 {}
