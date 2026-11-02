v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/iopin.sym} -1600 -500 0 1 {name=p1 lab=UA0}
N -1600 -500 -1540 -500 {lab=UA0}
C {devices/lab_pin.sym} -1540 -500 0 1 {name=lp1 sig_type=std_logic lab=UA0}
C {devices/iopin.sym} -1600 -460 0 1 {name=p2 lab=UA1}
N -1600 -460 -1540 -460 {lab=UA1}
C {devices/lab_pin.sym} -1540 -460 0 1 {name=lp2 sig_type=std_logic lab=UA1}
C {devices/iopin.sym} -1600 -420 0 1 {name=p3 lab=UA2}
N -1600 -420 -1540 -420 {lab=UA2}
C {devices/lab_pin.sym} -1540 -420 0 1 {name=lp3 sig_type=std_logic lab=UA2}
C {devices/iopin.sym} -1600 -380 0 1 {name=p4 lab=UA3}
N -1600 -380 -1540 -380 {lab=UA3}
C {devices/lab_pin.sym} -1540 -380 0 1 {name=lp4 sig_type=std_logic lab=UA3}
C {devices/iopin.sym} -1600 -340 0 1 {name=p5 lab=UA4}
N -1600 -340 -1540 -340 {lab=UA4}
C {devices/lab_pin.sym} -1540 -340 0 1 {name=lp5 sig_type=std_logic lab=UA4}
C {devices/iopin.sym} -1600 -300 0 1 {name=p6 lab=UA5}
N -1600 -300 -1540 -300 {lab=UA5}
C {devices/lab_pin.sym} -1540 -300 0 1 {name=lp6 sig_type=std_logic lab=UA5}
C {devices/ipin.sym} -1600 -260 0 0 {name=p7 lab=ui_in[7:0]}
N -1600 -260 -1540 -260 {lab=ui_in[7:0]}
C {devices/lab_pin.sym} -1540 -260 0 1 {name=lp7 sig_type=std_logic lab=ui_in[7:0]}
C {devices/ipin.sym} -1600 -220 0 0 {name=p8 lab=clk}
N -1600 -220 -1540 -220 {lab=clk}
C {devices/lab_pin.sym} -1540 -220 0 1 {name=lp8 sig_type=std_logic lab=clk}
C {devices/ipin.sym} -1600 -180 0 0 {name=p9 lab=rst_n}
N -1600 -180 -1540 -180 {lab=rst_n}
C {devices/lab_pin.sym} -1540 -180 0 1 {name=lp9 sig_type=std_logic lab=rst_n}
C {devices/ipin.sym} -1600 -140 0 0 {name=p10 lab=ena}
N -1600 -140 -1540 -140 {lab=ena}
C {devices/lab_pin.sym} -1540 -140 0 1 {name=lp10 sig_type=std_logic lab=ena}
C {devices/opin.sym} -1600 -100 0 1 {name=p11 lab=uo_out[7:0]}
N -1600 -100 -1540 -100 {lab=uo_out[7:0]}
C {devices/lab_pin.sym} -1540 -100 0 1 {name=lp11 sig_type=std_logic lab=uo_out[7:0]}
C {devices/iopin.sym} -1600 -60 0 1 {name=p12 lab=VDPWR}
N -1600 -60 -1540 -60 {lab=VDPWR}
C {devices/lab_pin.sym} -1540 -60 0 1 {name=lp12 sig_type=std_logic lab=VDPWR}
C {devices/iopin.sym} -1600 -20 0 1 {name=p13 lab=VGND}
N -1600 -20 -1540 -20 {lab=VGND}
C {devices/lab_pin.sym} -1540 -20 0 1 {name=lp13 sig_type=std_logic lab=VGND}
C {ELAD1_CONTROL.sym} -700 0 0 0 {name=xctl}
N -860 -240 -900 -240 {lab=clk}
C {devices/lab_pin.sym} -900.0 -240.0 0 0 {name=l1 sig_type=std_logic lab=clk}
N -860 -200 -900 -200 {lab=rst_n}
C {devices/lab_pin.sym} -900.0 -200.0 0 0 {name=l2 sig_type=std_logic lab=rst_n}
N -860 -160 -900 -160 {lab=ena}
C {devices/lab_pin.sym} -900.0 -160.0 0 0 {name=l3 sig_type=std_logic lab=ena}
N -860 -120 -900 -120 {lab=ui_in[7:0]}
C {devices/lab_pin.sym} -900.0 -120.0 0 0 {name=l4 sig_type=std_logic lab=ui_in[7:0]}
N -540 -240 -500 -240 {lab=EN_MG}
C {devices/lab_pin.sym} -500.0 -240.0 0 1 {name=l5 sig_type=std_logic lab=EN_MG}
N -540 -200 -500 -200 {lab=EN_MC}
C {devices/lab_pin.sym} -500.0 -200.0 0 1 {name=l6 sig_type=std_logic lab=EN_MC}
N -540 -160 -500 -160 {lab=EN_PG}
C {devices/lab_pin.sym} -500.0 -160.0 0 1 {name=l7 sig_type=std_logic lab=EN_PG}
N -540 -120 -500 -120 {lab=EN_PC}
C {devices/lab_pin.sym} -500.0 -120.0 0 1 {name=l8 sig_type=std_logic lab=EN_PC}
N -540 -80 -500 -80 {lab=EN_N}
C {devices/lab_pin.sym} -500.0 -80.0 0 1 {name=l9 sig_type=std_logic lab=EN_N}
N -540 -40 -500 -40 {lab=CLR_MG}
C {devices/lab_pin.sym} -500.0 -40.0 0 1 {name=l10 sig_type=std_logic lab=CLR_MG}
N -540 0 -500 0 {lab=CLR_MC}
C {devices/lab_pin.sym} -500.0 0.0 0 1 {name=l11 sig_type=std_logic lab=CLR_MC}
N -540 40 -500 40 {lab=CLR_PG}
C {devices/lab_pin.sym} -500.0 40.0 0 1 {name=l12 sig_type=std_logic lab=CLR_PG}
N -540 80 -500 80 {lab=CLR_PC}
C {devices/lab_pin.sym} -500.0 80.0 0 1 {name=l13 sig_type=std_logic lab=CLR_PC}
N -540 120 -500 120 {lab=CLR_N}
C {devices/lab_pin.sym} -500.0 120.0 0 1 {name=l14 sig_type=std_logic lab=CLR_N}
N -540 160 -500 160 {lab=HEN}
C {devices/lab_pin.sym} -500.0 160.0 0 1 {name=l15 sig_type=std_logic lab=HEN}
N -540 200 -500 200 {lab=AGG_CLK}
C {devices/lab_pin.sym} -500.0 200.0 0 1 {name=l16 sig_type=std_logic lab=AGG_CLK}
N -540 240 -500 240 {lab=uo_out[7:0]}
C {devices/lab_pin.sym} -500.0 240.0 0 1 {name=l17 sig_type=std_logic lab=uo_out[7:0]}
N -700 -300 -700 -340 {lab=VDPWR}
C {devices/lab_pin.sym} -700.0 -340.0 3 0 {name=l18 sig_type=std_logic lab=VDPWR}
N -700 300 -700 340 {lab=VGND}
C {devices/lab_pin.sym} -700.0 340.0 1 0 {name=l19 sig_type=std_logic lab=VGND}
C {ELAD1_ANALOG_CORE.sym} 400 0 0 0 {name=xana}
N 60 -350 20 -350 {lab=UA0}
C {devices/lab_pin.sym} 20.0 -350.0 0 0 {name=l20 sig_type=std_logic lab=UA0}
N 60 -210 20 -210 {lab=UA1}
C {devices/lab_pin.sym} 20.0 -210.0 0 0 {name=l21 sig_type=std_logic lab=UA1}
N 60 -70 20 -70 {lab=UA2}
C {devices/lab_pin.sym} 20.0 -70.0 0 0 {name=l22 sig_type=std_logic lab=UA2}
N 60 70 20 70 {lab=UA3}
C {devices/lab_pin.sym} 20.0 70.0 0 0 {name=l23 sig_type=std_logic lab=UA3}
N 60 210 20 210 {lab=UA4}
C {devices/lab_pin.sym} 20.0 210.0 0 0 {name=l24 sig_type=std_logic lab=UA4}
N 60 350 20 350 {lab=UA5}
C {devices/lab_pin.sym} 20.0 350.0 0 0 {name=l25 sig_type=std_logic lab=UA5}
N 160 480 160 520 {lab=EN_MG}
C {devices/lab_pin.sym} 160.0 520.0 1 0 {name=l26 sig_type=std_logic lab=EN_MG}
N 200 480 200 520 {lab=EN_MC}
C {devices/lab_pin.sym} 200.0 520.0 1 0 {name=l27 sig_type=std_logic lab=EN_MC}
N 240 480 240 520 {lab=EN_PG}
C {devices/lab_pin.sym} 240.0 520.0 1 0 {name=l28 sig_type=std_logic lab=EN_PG}
N 280 480 280 520 {lab=EN_PC}
C {devices/lab_pin.sym} 280.0 520.0 1 0 {name=l29 sig_type=std_logic lab=EN_PC}
N 320 480 320 520 {lab=EN_N}
C {devices/lab_pin.sym} 320.0 520.0 1 0 {name=l30 sig_type=std_logic lab=EN_N}
N 360 480 360 520 {lab=CLR_MG}
C {devices/lab_pin.sym} 360.0 520.0 1 0 {name=l31 sig_type=std_logic lab=CLR_MG}
N 400 480 400 520 {lab=CLR_MC}
C {devices/lab_pin.sym} 400.0 520.0 1 0 {name=l32 sig_type=std_logic lab=CLR_MC}
N 440 480 440 520 {lab=CLR_PG}
C {devices/lab_pin.sym} 440.0 520.0 1 0 {name=l33 sig_type=std_logic lab=CLR_PG}
N 480 480 480 520 {lab=CLR_PC}
C {devices/lab_pin.sym} 480.0 520.0 1 0 {name=l34 sig_type=std_logic lab=CLR_PC}
N 520 480 520 520 {lab=CLR_N}
C {devices/lab_pin.sym} 520.0 520.0 1 0 {name=l35 sig_type=std_logic lab=CLR_N}
N 560 480 560 520 {lab=HEN}
C {devices/lab_pin.sym} 560.0 520.0 1 0 {name=l36 sig_type=std_logic lab=HEN}
N 600 480 600 520 {lab=AGG_CLK}
C {devices/lab_pin.sym} 600.0 520.0 1 0 {name=l37 sig_type=std_logic lab=AGG_CLK}
N 400 -460 400 -500 {lab=VDPWR}
C {devices/lab_pin.sym} 400.0 -500.0 3 0 {name=l38 sig_type=std_logic lab=VDPWR}
N 680 480 680 520 {lab=VGND}
C {devices/lab_pin.sym} 680.0 520.0 1 0 {name=l39 sig_type=std_logic lab=VGND}
T {ELAD1_CORE: configuration controller + analog core} -1000 -700 0 0 0.6 0.6 {}
T {Controller outputs are flop outputs (glitch-free). Net names EN_x / CLR_x / HEN / AGG_CLK connect the two blocks.
status[7:0] -> uo_out: [0] ACTIVE [1] BUSY [3:2] MODE [4] STRUCT [5] HEAT_ON [6] AGG_ON [7] ERR} -1000 -640 0 0 0.3 0.3 {}
