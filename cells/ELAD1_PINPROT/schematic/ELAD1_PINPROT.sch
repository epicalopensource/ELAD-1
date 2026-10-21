v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/res.sym} 360 300 0 0 {name=RLINK value=0.001}
C {sky130_fd_pr/diode.sym} 0 200 0 0 {name=DN model=diode_pw2nd_05v5 area=36 perim=40}
C {sky130_fd_pr/diode.sym} 0 0 0 0 {name=DP model=diode_pd2nw_05v5 area=36 perim=40}
N 0 230 0 250 {lab=VGND}
C {devices/gnd.sym} 0 250 0 0 {name=l1 lab=VGND}
N 0 -30 0 -50 {lab=VDPWR}
C {devices/vdd.sym} 0 -50 0 0 {name=l2 lab=VDPWR}
N 360 270 360 170 {lab=PAD}
N 0 30 0 170 {lab=PAD}
N -60 170 0 170 {lab=PAD}
N 0 170 360 170 {lab=PAD}
N 360 330 360 370 {lab=CORE}
N 300 370 360 370 {lab=CORE}
C {devices/iopin.sym} -60 170 0 1 {name=p3 lab=PAD}
C {devices/iopin.sym} 300 370 0 1 {name=p4 lab=CORE}
C {devices/iopin.sym} -220 -30 0 1 {name=p5 lab=VDPWR}
C {devices/iopin.sym} -220 10 0 1 {name=p6 lab=VGND}
