v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {tt_um_epicalopensource_elad1: ELAD1_CORE (controller + analog core) } 730 -1200 0 0 0.6 0.6 {}
T {ua[5:0] go straight to the core (analog_pins = 6); ua[7:6] not connected. uio_in unused.
No local ESD: the TT pads carry it; the selector switch junctions already clamp each ua pin to VDPWR/VGND.
uo_out driven by the controller status. Power: VDPWR 1.8 V, VGND.} 730 -1140 0 0 0.3 0.3 {}
N 850 -930 910 -930 {lab=ui_in[7:0]}
N 850 -890 910 -890 {lab=ua[7:0]}
N 850 -850 910 -850 {lab=ena}
N 850 -810 910 -810 {lab=clk}
N 850 -770 910 -770 {lab=rst_n}
N 850 -730 910 -730 {lab=uo_out[7:0]}
N 850 -690 910 -690 {lab=VDPWR}
N 850 -650 910 -650 {lab=VGND}
N 1260 -910 1300 -910 {lab=ua[0]}
N 1260 -870 1300 -870 {lab=ua[1]}
N 1260 -830 1300 -830 {lab=ua[2]}
N 1260 -790 1300 -790 {lab=ua[3]}
N 1260 -750 1300 -750 {lab=ua[4]}
N 1260 -710 1300 -710 {lab=ua[5]}
N 1260 -670 1300 -670 {lab=ui_in[7:0]}
N 1260 -630 1300 -630 {lab=clk}
N 1260 -590 1300 -590 {lab=rst_n}
N 1260 -550 1300 -550 {lab=ena}
N 1620 -910 1660 -910 {lab=uo_out[7:0]}
N 1460 -1010 1460 -970 {lab=VDPWR}
N 1460 -490 1460 -450 {lab=VGND}
C {devices/ipin.sym} 850 -930 0 0 {name=p1 lab=ui_in[7:0]}
C {devices/lab_pin.sym} 910 -930 0 1 {name=lp1 sig_type=std_logic lab=ui_in[7:0]}
C {devices/iopin.sym} 850 -890 0 1 {name=p3 lab=ua[7:0]}
C {devices/lab_pin.sym} 910 -890 0 1 {name=lp3 sig_type=std_logic lab=ua[7:0]}
C {devices/ipin.sym} 850 -850 0 0 {name=p4 lab=ena}
C {devices/lab_pin.sym} 910 -850 0 1 {name=lp4 sig_type=std_logic lab=ena}
C {devices/ipin.sym} 850 -810 0 0 {name=p5 lab=clk}
C {devices/lab_pin.sym} 910 -810 0 1 {name=lp5 sig_type=std_logic lab=clk}
C {devices/ipin.sym} 850 -770 0 0 {name=p6 lab=rst_n}
C {devices/lab_pin.sym} 910 -770 0 1 {name=lp6 sig_type=std_logic lab=rst_n}
C {devices/opin.sym} 850 -730 0 1 {name=p7 lab=uo_out[7:0]}
C {devices/lab_pin.sym} 910 -730 0 1 {name=lp7 sig_type=std_logic lab=uo_out[7:0]}
C {devices/iopin.sym} 850 -690 0 1 {name=p10 lab=VDPWR}
C {devices/lab_pin.sym} 910 -690 0 1 {name=lp10 sig_type=std_logic lab=VDPWR}
C {devices/iopin.sym} 850 -650 0 1 {name=p11 lab=VGND}
C {devices/lab_pin.sym} 910 -650 0 1 {name=lp11 sig_type=std_logic lab=VGND}
C {ELAD1_CORE.sym} 1460 -730 0 0 {name=xcore}
C {devices/lab_pin.sym} 1260 -910 0 0 {name=l1 sig_type=std_logic lab=ua[0]}
C {devices/lab_pin.sym} 1260 -870 0 0 {name=l2 sig_type=std_logic lab=ua[1]}
C {devices/lab_pin.sym} 1260 -830 0 0 {name=l3 sig_type=std_logic lab=ua[2]}
C {devices/lab_pin.sym} 1260 -790 0 0 {name=l4 sig_type=std_logic lab=ua[3]}
C {devices/lab_pin.sym} 1260 -750 0 0 {name=l5 sig_type=std_logic lab=ua[4]}
C {devices/lab_pin.sym} 1260 -710 0 0 {name=l6 sig_type=std_logic lab=ua[5]}
C {devices/lab_pin.sym} 1260 -670 0 0 {name=l7 sig_type=std_logic lab=ui_in[7:0]}
C {devices/lab_pin.sym} 1260 -630 0 0 {name=l8 sig_type=std_logic lab=clk}
C {devices/lab_pin.sym} 1260 -590 0 0 {name=l9 sig_type=std_logic lab=rst_n}
C {devices/lab_pin.sym} 1260 -550 0 0 {name=l10 sig_type=std_logic lab=ena}
C {devices/lab_pin.sym} 1660 -910 0 1 {name=l11 sig_type=std_logic lab=uo_out[7:0]}
C {devices/lab_pin.sym} 1460 -1010 3 0 {name=l12 sig_type=std_logic lab=VDPWR}
C {devices/lab_pin.sym} 1460 -450 1 0 {name=l13 sig_type=std_logic lab=VGND}
