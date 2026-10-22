v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {sky130_fd_pr/res_high_po.sym} 340 100 0 0 {name=RH0 model=res_high_po W=5.73 L=52.9 mult=1}
C {sky130_fd_pr/res_high_po.sym} 500 100 0 0 {name=RH1 model=res_high_po W=5.73 L=52.9 mult=1}
C {sky130_fd_pr/nfet_01v8.sym} -20 0 0 0 {name=MSW model=nfet_01v8 W=40 L=0.15 nf=1 mult=1 sa=0 sb=0 sd=0}
N 320 100 300 100 {lab=VGND}
C {devices/lab_pin.sym} 300 100 0 0 {name=l1 sig_type=std_logic lab=VGND}
N 480 100 460 100 {lab=VGND}
C {devices/lab_pin.sym} 460 100 0 0 {name=l2 sig_type=std_logic lab=VGND}
N 0 0 20 0 {lab=VGND}
C {devices/lab_pin.sym} 20 0 0 1 {name=l3 sig_type=std_logic lab=VGND}
N 0 30 0 50 {lab=VGND}
C {devices/gnd.sym} 0 50 0 0 {name=l4 lab=VGND global=false}
N -40 0 -60 0 {lab=HEN}
N -120 0 -60 0 {lab=HEN}
N 340 130 340 170 {lab=HIN}
N 500 130 500 170 {lab=HIN}
N 280 170 340 170 {lab=HIN}
N 340 170 500 170 {lab=HIN}
N 340 70 340 -30 {lab=HD}
N 500 70 500 -30 {lab=HD}
N 0 -30 340 -30 {lab=HD}
N 340 -30 500 -30 {lab=HD}
C {devices/lab_pin.sym} 0 -30 0 0 {name=l7 sig_type=std_logic lab=HD}
C {devices/iopin.sym} 280 170 0 1 {name=p6 lab=HIN}
C {devices/iopin.sym} -120 0 0 1 {name=p5 lab=HEN}
C {devices/iopin.sym} -280 -30 0 1 {name=p8 lab=VGND}
