v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -220 0 -100 0 {}
N -100 0 -30 0 {}
N 30 0 160 0 {}
N -100 -30 -100 0 {}
N -100 0 -100 30 {}
N -220 -130 -100 -130 {}
N -100 -130 -100 -90 {}
N -220 130 -100 130 {}
N -100 90 -100 130 {}
C {devices/iopin.sym} -220 0 0 1 {name=p1 lab=PAD}
C {devices/iopin.sym} 160 0 0 0 {name=p2 lab=CORE}
C {devices/iopin.sym} -220 -130 0 1 {name=p3 lab=VDPWR}
C {devices/iopin.sym} -220 130 0 1 {name=p4 lab=VGND}
C {devices/res.sym} 0 0 3 0 {name=RLINK value=0.001 footprint=1206 device=resistor}
C {sky130_fd_pr/diode.sym} -100 -60 0 0 {name=DP model=diode_pd2nw_05v5 area=36 perim=40}
C {sky130_fd_pr/diode.sym} -100 60 0 0 {name=DN model=diode_pw2nd_05v5 area=36 perim=40}
T {ELAD1_PINPROT: pad link + ESD diodes} -220 -220 0 0 0.35 0.35 {}
T {DP: PAD to VDPWR, DN: VGND to PAD} -220 -185 0 0 0.22 0.22 {}
