v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/ipin.sym} -1600 -500 0 0 {name=p1 lab=ui_in[7:0]}
N -1600 -500 -1540 -500 {lab=ui_in[7:0]}
C {devices/lab_pin.sym} -1540 -500 0 1 {name=lp1 sig_type=std_logic lab=ui_in[7:0]}
C {devices/ipin.sym} -1600 -460 0 0 {name=p2 lab=uio_in[7:0]}
N -1600 -460 -1540 -460 {lab=uio_in[7:0]}
C {devices/lab_pin.sym} -1540 -460 0 1 {name=lp2 sig_type=std_logic lab=uio_in[7:0]}
C {devices/iopin.sym} -1600 -420 0 1 {name=p3 lab=ua[7:0]}
N -1600 -420 -1540 -420 {lab=ua[7:0]}
C {devices/lab_pin.sym} -1540 -420 0 1 {name=lp3 sig_type=std_logic lab=ua[7:0]}
C {devices/ipin.sym} -1600 -380 0 0 {name=p4 lab=ena}
N -1600 -380 -1540 -380 {lab=ena}
C {devices/lab_pin.sym} -1540 -380 0 1 {name=lp4 sig_type=std_logic lab=ena}
C {devices/ipin.sym} -1600 -340 0 0 {name=p5 lab=clk}
N -1600 -340 -1540 -340 {lab=clk}
C {devices/lab_pin.sym} -1540 -340 0 1 {name=lp5 sig_type=std_logic lab=clk}
C {devices/ipin.sym} -1600 -300 0 0 {name=p6 lab=rst_n}
N -1600 -300 -1540 -300 {lab=rst_n}
C {devices/lab_pin.sym} -1540 -300 0 1 {name=lp6 sig_type=std_logic lab=rst_n}
C {devices/opin.sym} -1600 -260 0 1 {name=p7 lab=uo_out[7:0]}
N -1600 -260 -1540 -260 {lab=uo_out[7:0]}
C {devices/lab_pin.sym} -1540 -260 0 1 {name=lp7 sig_type=std_logic lab=uo_out[7:0]}
C {devices/opin.sym} -1600 -220 0 1 {name=p8 lab=uio_out[7:0]}
N -1600 -220 -1540 -220 {lab=uio_out[7:0]}
C {devices/lab_pin.sym} -1540 -220 0 1 {name=lp8 sig_type=std_logic lab=uio_out[7:0]}
C {devices/opin.sym} -1600 -180 0 1 {name=p9 lab=uio_oe[7:0]}
N -1600 -180 -1540 -180 {lab=uio_oe[7:0]}
C {devices/lab_pin.sym} -1540 -180 0 1 {name=lp9 sig_type=std_logic lab=uio_oe[7:0]}
C {devices/iopin.sym} -1600 -140 0 1 {name=p10 lab=VDPWR}
N -1600 -140 -1540 -140 {lab=VDPWR}
C {devices/lab_pin.sym} -1540 -140 0 1 {name=lp10 sig_type=std_logic lab=VDPWR}
C {devices/iopin.sym} -1600 -100 0 1 {name=p11 lab=VGND}
N -1600 -100 -1540 -100 {lab=VGND}
C {devices/lab_pin.sym} -1540 -100 0 1 {name=lp11 sig_type=std_logic lab=VGND}
C {ELAD1_IO.sym} -600 0 0 0 {name=xio}
N -730 -150 -770 -150 {lab=ua[0]}
C {devices/lab_pin.sym} -770.0 -150.0 0 0 {name=l1 sig_type=std_logic lab=ua[0]}
N -730 -90 -770 -90 {lab=ua[1]}
C {devices/lab_pin.sym} -770.0 -90.0 0 0 {name=l2 sig_type=std_logic lab=ua[1]}
N -730 -30 -770 -30 {lab=ua[2]}
C {devices/lab_pin.sym} -770.0 -30.0 0 0 {name=l3 sig_type=std_logic lab=ua[2]}
N -730 30 -770 30 {lab=ua[3]}
C {devices/lab_pin.sym} -770.0 30.0 0 0 {name=l4 sig_type=std_logic lab=ua[3]}
N -730 90 -770 90 {lab=ua[4]}
C {devices/lab_pin.sym} -770.0 90.0 0 0 {name=l5 sig_type=std_logic lab=ua[4]}
N -730 150 -770 150 {lab=ua[5]}
C {devices/lab_pin.sym} -770.0 150.0 0 0 {name=l6 sig_type=std_logic lab=ua[5]}
N -470 -150 -430 -150 {lab=UA0}
C {devices/lab_pin.sym} -430.0 -150.0 0 1 {name=l7 sig_type=std_logic lab=UA0}
N -470 -90 -430 -90 {lab=UA1}
C {devices/lab_pin.sym} -430.0 -90.0 0 1 {name=l8 sig_type=std_logic lab=UA1}
N -470 -30 -430 -30 {lab=UA2}
C {devices/lab_pin.sym} -430.0 -30.0 0 1 {name=l9 sig_type=std_logic lab=UA2}
N -470 30 -430 30 {lab=UA3}
C {devices/lab_pin.sym} -430.0 30.0 0 1 {name=l10 sig_type=std_logic lab=UA3}
N -470 90 -430 90 {lab=UA4}
C {devices/lab_pin.sym} -430.0 90.0 0 1 {name=l11 sig_type=std_logic lab=UA4}
N -470 150 -430 150 {lab=UA5}
C {devices/lab_pin.sym} -430.0 150.0 0 1 {name=l12 sig_type=std_logic lab=UA5}
N -610 -230 -610 -270 {lab=VDPWR}
C {devices/lab_pin.sym} -610.0 -270.0 3 0 {name=l13 sig_type=std_logic lab=VDPWR}
N -610 230 -610 270 {lab=VGND}
C {devices/lab_pin.sym} -610.0 270.0 1 0 {name=l14 sig_type=std_logic lab=VGND}
C {ELAD1_CORE.sym} 100 0 0 0 {name=xcore}
N -60 -180 -100 -180 {lab=UA0}
C {devices/lab_pin.sym} -100.0 -180.0 0 0 {name=l15 sig_type=std_logic lab=UA0}
N -60 -140 -100 -140 {lab=UA1}
C {devices/lab_pin.sym} -100.0 -140.0 0 0 {name=l16 sig_type=std_logic lab=UA1}
N -60 -100 -100 -100 {lab=UA2}
C {devices/lab_pin.sym} -100.0 -100.0 0 0 {name=l17 sig_type=std_logic lab=UA2}
N -60 -60 -100 -60 {lab=UA3}
C {devices/lab_pin.sym} -100.0 -60.0 0 0 {name=l18 sig_type=std_logic lab=UA3}
N -60 -20 -100 -20 {lab=UA4}
C {devices/lab_pin.sym} -100.0 -20.0 0 0 {name=l19 sig_type=std_logic lab=UA4}
N -60 20 -100 20 {lab=UA5}
C {devices/lab_pin.sym} -100.0 20.0 0 0 {name=l20 sig_type=std_logic lab=UA5}
N -60 60 -100 60 {lab=ui_in[7:0]}
C {devices/lab_pin.sym} -100.0 60.0 0 0 {name=l21 sig_type=std_logic lab=ui_in[7:0]}
N -60 100 -100 100 {lab=clk}
C {devices/lab_pin.sym} -100.0 100.0 0 0 {name=l22 sig_type=std_logic lab=clk}
N -60 140 -100 140 {lab=rst_n}
C {devices/lab_pin.sym} -100.0 140.0 0 0 {name=l23 sig_type=std_logic lab=rst_n}
N -60 180 -100 180 {lab=ena}
C {devices/lab_pin.sym} -100.0 180.0 0 0 {name=l24 sig_type=std_logic lab=ena}
N 260 -180 300 -180 {lab=uo_out[7:0]}
C {devices/lab_pin.sym} 300.0 -180.0 0 1 {name=l25 sig_type=std_logic lab=uo_out[7:0]}
N 100 -240 100 -280 {lab=VDPWR}
C {devices/lab_pin.sym} 100.0 -280.0 3 0 {name=l26 sig_type=std_logic lab=VDPWR}
N 100 240 100 280 {lab=VGND}
C {devices/lab_pin.sym} 100.0 280.0 1 0 {name=l27 sig_type=std_logic lab=VGND}
C {sky130_stdcells/conb_1.sym} 700 -500 0 0 {name=xtie_uio_out0 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 760 -520 800 -520 {}
C {devices/noconn.sym} 800.0 -520.0 0 0 {name=nc28}
N 760 -480 800 -480 {lab=uio_out[0]}
C {devices/lab_pin.sym} 800.0 -480.0 0 1 {name=l29 sig_type=std_logic lab=uio_out[0]}
C {sky130_stdcells/conb_1.sym} 1000 -500 0 0 {name=xtie_uio_oe0 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 1060 -520 1100 -520 {}
C {devices/noconn.sym} 1100.0 -520.0 0 0 {name=nc30}
N 1060 -480 1100 -480 {lab=uio_oe[0]}
C {devices/lab_pin.sym} 1100.0 -480.0 0 1 {name=l31 sig_type=std_logic lab=uio_oe[0]}
C {sky130_stdcells/conb_1.sym} 700 -380 0 0 {name=xtie_uio_out1 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 760 -400 800 -400 {}
C {devices/noconn.sym} 800.0 -400.0 0 0 {name=nc32}
N 760 -360 800 -360 {lab=uio_out[1]}
C {devices/lab_pin.sym} 800.0 -360.0 0 1 {name=l33 sig_type=std_logic lab=uio_out[1]}
C {sky130_stdcells/conb_1.sym} 1000 -380 0 0 {name=xtie_uio_oe1 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 1060 -400 1100 -400 {}
C {devices/noconn.sym} 1100.0 -400.0 0 0 {name=nc34}
N 1060 -360 1100 -360 {lab=uio_oe[1]}
C {devices/lab_pin.sym} 1100.0 -360.0 0 1 {name=l35 sig_type=std_logic lab=uio_oe[1]}
C {sky130_stdcells/conb_1.sym} 700 -260 0 0 {name=xtie_uio_out2 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 760 -280 800 -280 {}
C {devices/noconn.sym} 800.0 -280.0 0 0 {name=nc36}
N 760 -240 800 -240 {lab=uio_out[2]}
C {devices/lab_pin.sym} 800.0 -240.0 0 1 {name=l37 sig_type=std_logic lab=uio_out[2]}
C {sky130_stdcells/conb_1.sym} 1000 -260 0 0 {name=xtie_uio_oe2 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 1060 -280 1100 -280 {}
C {devices/noconn.sym} 1100.0 -280.0 0 0 {name=nc38}
N 1060 -240 1100 -240 {lab=uio_oe[2]}
C {devices/lab_pin.sym} 1100.0 -240.0 0 1 {name=l39 sig_type=std_logic lab=uio_oe[2]}
C {sky130_stdcells/conb_1.sym} 700 -140 0 0 {name=xtie_uio_out3 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 760 -160 800 -160 {}
C {devices/noconn.sym} 800.0 -160.0 0 0 {name=nc40}
N 760 -120 800 -120 {lab=uio_out[3]}
C {devices/lab_pin.sym} 800.0 -120.0 0 1 {name=l41 sig_type=std_logic lab=uio_out[3]}
C {sky130_stdcells/conb_1.sym} 1000 -140 0 0 {name=xtie_uio_oe3 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 1060 -160 1100 -160 {}
C {devices/noconn.sym} 1100.0 -160.0 0 0 {name=nc42}
N 1060 -120 1100 -120 {lab=uio_oe[3]}
C {devices/lab_pin.sym} 1100.0 -120.0 0 1 {name=l43 sig_type=std_logic lab=uio_oe[3]}
C {sky130_stdcells/conb_1.sym} 700 -20 0 0 {name=xtie_uio_out4 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 760 -40 800 -40 {}
C {devices/noconn.sym} 800.0 -40.0 0 0 {name=nc44}
N 760 0 800 0 {lab=uio_out[4]}
C {devices/lab_pin.sym} 800.0 0.0 0 1 {name=l45 sig_type=std_logic lab=uio_out[4]}
C {sky130_stdcells/conb_1.sym} 1000 -20 0 0 {name=xtie_uio_oe4 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 1060 -40 1100 -40 {}
C {devices/noconn.sym} 1100.0 -40.0 0 0 {name=nc46}
N 1060 0 1100 0 {lab=uio_oe[4]}
C {devices/lab_pin.sym} 1100.0 0.0 0 1 {name=l47 sig_type=std_logic lab=uio_oe[4]}
C {sky130_stdcells/conb_1.sym} 700 100 0 0 {name=xtie_uio_out5 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 760 80 800 80 {}
C {devices/noconn.sym} 800.0 80.0 0 0 {name=nc48}
N 760 120 800 120 {lab=uio_out[5]}
C {devices/lab_pin.sym} 800.0 120.0 0 1 {name=l49 sig_type=std_logic lab=uio_out[5]}
C {sky130_stdcells/conb_1.sym} 1000 100 0 0 {name=xtie_uio_oe5 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 1060 80 1100 80 {}
C {devices/noconn.sym} 1100.0 80.0 0 0 {name=nc50}
N 1060 120 1100 120 {lab=uio_oe[5]}
C {devices/lab_pin.sym} 1100.0 120.0 0 1 {name=l51 sig_type=std_logic lab=uio_oe[5]}
C {sky130_stdcells/conb_1.sym} 700 220 0 0 {name=xtie_uio_out6 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 760 200 800 200 {}
C {devices/noconn.sym} 800.0 200.0 0 0 {name=nc52}
N 760 240 800 240 {lab=uio_out[6]}
C {devices/lab_pin.sym} 800.0 240.0 0 1 {name=l53 sig_type=std_logic lab=uio_out[6]}
C {sky130_stdcells/conb_1.sym} 1000 220 0 0 {name=xtie_uio_oe6 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 1060 200 1100 200 {}
C {devices/noconn.sym} 1100.0 200.0 0 0 {name=nc54}
N 1060 240 1100 240 {lab=uio_oe[6]}
C {devices/lab_pin.sym} 1100.0 240.0 0 1 {name=l55 sig_type=std_logic lab=uio_oe[6]}
C {sky130_stdcells/conb_1.sym} 700 340 0 0 {name=xtie_uio_out7 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 760 320 800 320 {}
C {devices/noconn.sym} 800.0 320.0 0 0 {name=nc56}
N 760 360 800 360 {lab=uio_out[7]}
C {devices/lab_pin.sym} 800.0 360.0 0 1 {name=l57 sig_type=std_logic lab=uio_out[7]}
C {sky130_stdcells/conb_1.sym} 1000 340 0 0 {name=xtie_uio_oe7 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 1060 320 1100 320 {}
C {devices/noconn.sym} 1100.0 320.0 0 0 {name=nc58}
N 1060 360 1100 360 {lab=uio_oe[7]}
C {devices/lab_pin.sym} 1100.0 360.0 0 1 {name=l59 sig_type=std_logic lab=uio_oe[7]}
T {tt_um_epicalopensource_elad1: ELAD1_IO (pin protection) + ELAD1_CORE (controller + analog core)} -1100 -700 0 0 0.6 0.6 {}
T {ua[5:0] used (analog_pins = 6); ua[7:6] not connected. uio_in unused.
uio_out / uio_oe tied low with sky130_fd_sc_hd__conb_1 (TT analog spec: unused outputs to GND).
uo_out driven by the controller status. Power: VDPWR 1.8 V, VGND.} -1100 -640 0 0 0.3 0.3 {}
