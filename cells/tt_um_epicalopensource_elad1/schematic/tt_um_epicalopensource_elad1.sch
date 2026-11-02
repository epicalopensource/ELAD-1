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
C {ELAD1_CORE.sym} 0 0 0 0 {name=xcore}
N -160 -180 -200 -180 {lab=ua[0]}
C {devices/lab_pin.sym} -200.0 -180.0 0 0 {name=l1 sig_type=std_logic lab=ua[0]}
N -160 -140 -200 -140 {lab=ua[1]}
C {devices/lab_pin.sym} -200.0 -140.0 0 0 {name=l2 sig_type=std_logic lab=ua[1]}
N -160 -100 -200 -100 {lab=ua[2]}
C {devices/lab_pin.sym} -200.0 -100.0 0 0 {name=l3 sig_type=std_logic lab=ua[2]}
N -160 -60 -200 -60 {lab=ua[3]}
C {devices/lab_pin.sym} -200.0 -60.0 0 0 {name=l4 sig_type=std_logic lab=ua[3]}
N -160 -20 -200 -20 {lab=ua[4]}
C {devices/lab_pin.sym} -200.0 -20.0 0 0 {name=l5 sig_type=std_logic lab=ua[4]}
N -160 20 -200 20 {lab=ua[5]}
C {devices/lab_pin.sym} -200.0 20.0 0 0 {name=l6 sig_type=std_logic lab=ua[5]}
N -160 60 -200 60 {lab=ui_in[7:0]}
C {devices/lab_pin.sym} -200.0 60.0 0 0 {name=l7 sig_type=std_logic lab=ui_in[7:0]}
N -160 100 -200 100 {lab=clk}
C {devices/lab_pin.sym} -200.0 100.0 0 0 {name=l8 sig_type=std_logic lab=clk}
N -160 140 -200 140 {lab=rst_n}
C {devices/lab_pin.sym} -200.0 140.0 0 0 {name=l9 sig_type=std_logic lab=rst_n}
N -160 180 -200 180 {lab=ena}
C {devices/lab_pin.sym} -200.0 180.0 0 0 {name=l10 sig_type=std_logic lab=ena}
N 160 -180 200 -180 {lab=uo_out[7:0]}
C {devices/lab_pin.sym} 200.0 -180.0 0 1 {name=l11 sig_type=std_logic lab=uo_out[7:0]}
N 0 -240 0 -280 {lab=VDPWR}
C {devices/lab_pin.sym} 0.0 -280.0 3 0 {name=l12 sig_type=std_logic lab=VDPWR}
N 0 240 0 280 {lab=VGND}
C {devices/lab_pin.sym} 0.0 280.0 1 0 {name=l13 sig_type=std_logic lab=VGND}
C {sky130_stdcells/conb_1.sym} 700 -500 0 0 {name=xtie_uio_out0 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 760 -520 800 -520 {}
C {devices/noconn.sym} 800.0 -520.0 0 0 {name=nc14}
N 760 -480 800 -480 {lab=uio_out[0]}
C {devices/lab_pin.sym} 800.0 -480.0 0 1 {name=l15 sig_type=std_logic lab=uio_out[0]}
C {sky130_stdcells/conb_1.sym} 1000 -500 0 0 {name=xtie_uio_oe0 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 1060 -520 1100 -520 {}
C {devices/noconn.sym} 1100.0 -520.0 0 0 {name=nc16}
N 1060 -480 1100 -480 {lab=uio_oe[0]}
C {devices/lab_pin.sym} 1100.0 -480.0 0 1 {name=l17 sig_type=std_logic lab=uio_oe[0]}
C {sky130_stdcells/conb_1.sym} 700 -380 0 0 {name=xtie_uio_out1 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 760 -400 800 -400 {}
C {devices/noconn.sym} 800.0 -400.0 0 0 {name=nc18}
N 760 -360 800 -360 {lab=uio_out[1]}
C {devices/lab_pin.sym} 800.0 -360.0 0 1 {name=l19 sig_type=std_logic lab=uio_out[1]}
C {sky130_stdcells/conb_1.sym} 1000 -380 0 0 {name=xtie_uio_oe1 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 1060 -400 1100 -400 {}
C {devices/noconn.sym} 1100.0 -400.0 0 0 {name=nc20}
N 1060 -360 1100 -360 {lab=uio_oe[1]}
C {devices/lab_pin.sym} 1100.0 -360.0 0 1 {name=l21 sig_type=std_logic lab=uio_oe[1]}
C {sky130_stdcells/conb_1.sym} 700 -260 0 0 {name=xtie_uio_out2 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 760 -280 800 -280 {}
C {devices/noconn.sym} 800.0 -280.0 0 0 {name=nc22}
N 760 -240 800 -240 {lab=uio_out[2]}
C {devices/lab_pin.sym} 800.0 -240.0 0 1 {name=l23 sig_type=std_logic lab=uio_out[2]}
C {sky130_stdcells/conb_1.sym} 1000 -260 0 0 {name=xtie_uio_oe2 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 1060 -280 1100 -280 {}
C {devices/noconn.sym} 1100.0 -280.0 0 0 {name=nc24}
N 1060 -240 1100 -240 {lab=uio_oe[2]}
C {devices/lab_pin.sym} 1100.0 -240.0 0 1 {name=l25 sig_type=std_logic lab=uio_oe[2]}
C {sky130_stdcells/conb_1.sym} 700 -140 0 0 {name=xtie_uio_out3 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 760 -160 800 -160 {}
C {devices/noconn.sym} 800.0 -160.0 0 0 {name=nc26}
N 760 -120 800 -120 {lab=uio_out[3]}
C {devices/lab_pin.sym} 800.0 -120.0 0 1 {name=l27 sig_type=std_logic lab=uio_out[3]}
C {sky130_stdcells/conb_1.sym} 1000 -140 0 0 {name=xtie_uio_oe3 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 1060 -160 1100 -160 {}
C {devices/noconn.sym} 1100.0 -160.0 0 0 {name=nc28}
N 1060 -120 1100 -120 {lab=uio_oe[3]}
C {devices/lab_pin.sym} 1100.0 -120.0 0 1 {name=l29 sig_type=std_logic lab=uio_oe[3]}
C {sky130_stdcells/conb_1.sym} 700 -20 0 0 {name=xtie_uio_out4 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 760 -40 800 -40 {}
C {devices/noconn.sym} 800.0 -40.0 0 0 {name=nc30}
N 760 0 800 0 {lab=uio_out[4]}
C {devices/lab_pin.sym} 800.0 0.0 0 1 {name=l31 sig_type=std_logic lab=uio_out[4]}
C {sky130_stdcells/conb_1.sym} 1000 -20 0 0 {name=xtie_uio_oe4 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 1060 -40 1100 -40 {}
C {devices/noconn.sym} 1100.0 -40.0 0 0 {name=nc32}
N 1060 0 1100 0 {lab=uio_oe[4]}
C {devices/lab_pin.sym} 1100.0 0.0 0 1 {name=l33 sig_type=std_logic lab=uio_oe[4]}
C {sky130_stdcells/conb_1.sym} 700 100 0 0 {name=xtie_uio_out5 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 760 80 800 80 {}
C {devices/noconn.sym} 800.0 80.0 0 0 {name=nc34}
N 760 120 800 120 {lab=uio_out[5]}
C {devices/lab_pin.sym} 800.0 120.0 0 1 {name=l35 sig_type=std_logic lab=uio_out[5]}
C {sky130_stdcells/conb_1.sym} 1000 100 0 0 {name=xtie_uio_oe5 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 1060 80 1100 80 {}
C {devices/noconn.sym} 1100.0 80.0 0 0 {name=nc36}
N 1060 120 1100 120 {lab=uio_oe[5]}
C {devices/lab_pin.sym} 1100.0 120.0 0 1 {name=l37 sig_type=std_logic lab=uio_oe[5]}
C {sky130_stdcells/conb_1.sym} 700 220 0 0 {name=xtie_uio_out6 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 760 200 800 200 {}
C {devices/noconn.sym} 800.0 200.0 0 0 {name=nc38}
N 760 240 800 240 {lab=uio_out[6]}
C {devices/lab_pin.sym} 800.0 240.0 0 1 {name=l39 sig_type=std_logic lab=uio_out[6]}
C {sky130_stdcells/conb_1.sym} 1000 220 0 0 {name=xtie_uio_oe6 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 1060 200 1100 200 {}
C {devices/noconn.sym} 1100.0 200.0 0 0 {name=nc40}
N 1060 240 1100 240 {lab=uio_oe[6]}
C {devices/lab_pin.sym} 1100.0 240.0 0 1 {name=l41 sig_type=std_logic lab=uio_oe[6]}
C {sky130_stdcells/conb_1.sym} 700 340 0 0 {name=xtie_uio_out7 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 760 320 800 320 {}
C {devices/noconn.sym} 800.0 320.0 0 0 {name=nc42}
N 760 360 800 360 {lab=uio_out[7]}
C {devices/lab_pin.sym} 800.0 360.0 0 1 {name=l43 sig_type=std_logic lab=uio_out[7]}
C {sky130_stdcells/conb_1.sym} 1000 340 0 0 {name=xtie_uio_oe7 VGND=VGND VNB=VGND VPB=VDPWR VPWR=VDPWR prefix=sky130_fd_sc_hd__}
N 1060 320 1100 320 {}
C {devices/noconn.sym} 1100.0 320.0 0 0 {name=nc44}
N 1060 360 1100 360 {lab=uio_oe[7]}
C {devices/lab_pin.sym} 1100.0 360.0 0 1 {name=l45 sig_type=std_logic lab=uio_oe[7]}
T {tt_um_epicalopensource_elad1: ELAD1_CORE (controller + analog core) + tie cells} -1100 -700 0 0 0.6 0.6 {}
T {ua[5:0] go straight to the core (analog_pins = 6); ua[7:6] not connected. uio_in unused.
No local ESD: the TT pads carry it; the selector switch junctions already clamp each ua pin to VDPWR/VGND.
uio_out / uio_oe tied low with sky130_fd_sc_hd__conb_1 (TT analog spec: unused outputs to GND).
uo_out driven by the controller status. Power: VDPWR 1.8 V, VGND.} -1100 -640 0 0 0.3 0.3 {}
