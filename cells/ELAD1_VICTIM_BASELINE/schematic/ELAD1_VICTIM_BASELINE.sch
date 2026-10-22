v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -220 -130 20 -130 {}
N 20 -70 20 -50 {}
N 20 -50 20 -30 {}
N 20 -50 180 -50 {}
N -220 0 -20 0 {}
N -220 80 -140 80 {}
N -140 80 -120 80 {}
N -120 80 -80 80 {}
N -80 80 20 80 {}
N 20 30 20 80 {}
N -80 80 -80 130 {}
N -120 80 -120 160 {}
N -140 190 -80 190 {}
N -140 80 -140 190 {}
N -80 160 -60 160 {}
N -60 160 -60 230 {}
N -220 230 -60 230 {}
N -60 230 60 230 {}
N 60 0 60 230 {}
N 20 0 60 0 {}
N -20 -100 0 -100 {}
C {devices/iopin.sym} -220 0 0 1 {name=p1 lab=VQUIET}
C {devices/iopin.sym} 180 -50 0 0 {name=p2 lab=OUT}
C {devices/iopin.sym} -220 -130 0 1 {name=p3 lab=VDPWR}
C {devices/iopin.sym} -220 80 0 1 {name=p4 lab=VGND}
C {devices/iopin.sym} -220 230 0 1 {name=p5 lab=SUBQ}
C {sky130_fd_pr/res_xhigh_po.sym} 20 -100 2 1 {name=RLD model=res_xhigh_po W=0.69 L=31.7 mult=1}
C {sky130_fd_pr/nfet_01v8.sym} 0 0 0 0 {name=MVIC model=nfet_01v8 W=2 L=1 nf=1 mult=1 sa=0 sb=0 sd=0}
C {sky130_fd_pr/nfet_01v8.sym} -100 160 0 0 {name=DUM[1:0] model=nfet_01v8 W=2 L=1 nf=1 mult=1 sa=0 sb=0 sd=0}
C {devices/lab_pin.sym} -20 -100 0 0 {name=l6 sig_type=std_logic lab=SUBQ}
T {ELAD1_VICTIM_BASELINE: common-source victim, poly resistor load} -220 -230 0 0 0.35 0.35 {}
T {Layout: no guard ring (baseline). DUM[1:0] = 2 dummy units. Bodies on SUBQ (substrate sense net).} -220 -195 0 0 0.22 0.22 {}
