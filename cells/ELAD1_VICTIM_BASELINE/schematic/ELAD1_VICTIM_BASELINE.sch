v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {sky130_fd_pr/nfet_01v8.sym} -20 200 0 0 {name=MVIC model=nfet_01v8 W=2 L=1}
C {sky130_fd_pr/res_xhigh_po.sym} 0 0 2 1 {name=RLD model=res_xhigh_po W=0.69 L=31.7}
C {sky130_fd_pr/nfet_01v8.sym} 20 400 0 1 {name=DUM0 model=nfet_01v8 W=2 L=1}
C {sky130_fd_pr/nfet_01v8.sym} 220 400 0 0 {name=DUM1 model=nfet_01v8 W=2 L=1}
N 0 200 20 200 {lab=SUBQ}
C {devices/lab_pin.sym} 20 200 0 1 {name=l1 sig_type=std_logic lab=SUBQ}
N -20 0 -40 0 {lab=SUBQ}
C {devices/lab_pin.sym} -40 0 0 0 {name=l2 sig_type=std_logic lab=SUBQ}
N 0 400 -20 400 {lab=SUBQ}
C {devices/lab_pin.sym} -20 400 0 0 {name=l3 sig_type=std_logic lab=SUBQ}
N 240 400 260 400 {lab=SUBQ}
C {devices/lab_pin.sym} 260 400 0 1 {name=l4 sig_type=std_logic lab=SUBQ}
N 0 230 0 250 {lab=VGND}
C {devices/gnd.sym} 0 250 0 0 {name=l5 lab=VGND}
N 0 -30 0 -50 {lab=VDPWR}
C {devices/vdd.sym} 0 -50 0 0 {name=l6 lab=VDPWR}
N 0 370 0 350 {lab=VGND}
C {devices/lab_pin.sym} 0 350 1 0 {name=l7 sig_type=std_logic lab=VGND}
N 240 370 240 350 {lab=VGND}
C {devices/lab_pin.sym} 240 350 1 0 {name=l8 sig_type=std_logic lab=VGND}
N 40 400 60 400 {lab=VGND}
C {devices/lab_pin.sym} 60 400 0 1 {name=l9 sig_type=std_logic lab=VGND}
N 0 470 240 470 {lab=VGND}
N 0 430 0 470 {lab=VGND}
N 240 430 240 470 {lab=VGND}
C {devices/gnd.sym} 0 470 0 0 {name=l10 lab=VGND}
N 200 400 180 400 {lab=VGND}
C {devices/lab_pin.sym} 180 400 0 0 {name=l11 sig_type=std_logic lab=VGND}
N 0 170 0 130 {lab=OUT}
N 0 30 0 130 {lab=OUT}
N -60 130 0 130 {lab=OUT}
N -40 200 -60 200 {lab=VQUIET}
N -120 200 -60 200 {lab=VQUIET}
C {devices/iopin.sym} -120 200 0 1 {name=p13 lab=VQUIET}
C {devices/iopin.sym} -60 130 0 1 {name=p12 lab=OUT}
C {devices/iopin.sym} -280 -30 0 1 {name=p14 lab=VDPWR}
C {devices/iopin.sym} -280 10 0 1 {name=p15 lab=VGND}
C {devices/iopin.sym} -280 50 0 1 {name=p16 lab=SUBQ}
