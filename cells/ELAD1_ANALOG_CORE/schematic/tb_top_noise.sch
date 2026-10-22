v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -380 870 -360 870 {}
N -360 870 -340 870 {}
N -500 870 -500 890 {}
N -500 870 -380 870 {}
N -530 870 -500 870 {}
N -620 870 -590 870 {}
N -740 870 -740 890 {}
N -860 870 -860 890 {}
N -860 870 -740 870 {}
N -740 870 -620 870 {}
N -380 730 -360 730 {}
N -360 730 -340 730 {}
N -500 730 -500 750 {}
N -500 730 -380 730 {}
N -530 730 -500 730 {}
N -620 730 -590 730 {}
N -740 730 -740 750 {}
N -860 730 -860 750 {}
N -980 730 -980 750 {}
N -980 730 -860 730 {}
N -860 730 -740 730 {}
N -740 730 -620 730 {}
N -380 590 -360 590 {}
N -360 590 -340 590 {}
N -500 590 -500 610 {}
N -500 590 -380 590 {}
N -530 590 -500 590 {}
N -620 590 -590 590 {}
N -740 590 -740 610 {}
N -860 590 -860 610 {}
N -980 590 -980 610 {}
N -980 590 -860 590 {}
N -860 590 -740 590 {}
N -740 590 -620 590 {}
N -380 450 -360 450 {}
N -360 450 -340 450 {}
N -500 450 -500 470 {}
N -500 450 -380 450 {}
N -530 450 -500 450 {}
N -620 450 -590 450 {}
N -740 450 -740 470 {}
N -860 450 -860 470 {}
N -860 450 -740 450 {}
N -740 450 -620 450 {}
N -380 310 -360 310 {}
N -360 310 -340 310 {}
N -500 310 -500 330 {}
N -500 310 -380 310 {}
N -530 310 -500 310 {}
N -620 310 -590 310 {}
N -740 310 -740 330 {}
N -860 310 -860 330 {}
N -860 310 -740 310 {}
N -740 310 -620 310 {}
N -380 170 -360 170 {}
N -360 170 -340 170 {}
N -500 170 -500 190 {}
N -500 170 -380 170 {}
N -530 170 -500 170 {}
N -620 170 -590 170 {}
N -740 170 -740 190 {}
N -860 170 -860 190 {}
N -860 170 -740 170 {}
N -740 170 -620 170 {}
N 280 1000 300 1000 {}
N 300 1000 320 1000 {}
N 440 1000 440 1020 {}
N 320 1000 440 1000 {}
N -240 1000 -240 1020 {}
N -200 1000 -200 1020 {}
N -160 1000 -160 1020 {}
N -120 1000 -120 1020 {}
N -80 1000 -80 1020 {}
N -40 1000 -40 1020 {}
N 0 1000 0 1020 {}
N 40 1000 40 1020 {}
N 80 1000 80 1020 {}
N 120 1000 120 1020 {}
N 160 1000 160 1020 {}
N 200 1000 200 1020 {}
N -860 1170 -860 1190 {}
N -980 1170 -860 1170 {}
N -600 1170 -600 1190 {}
N -720 1170 -600 1170 {}
N -340 1170 -340 1190 {}
N -460 1170 -340 1170 {}
N -80 1170 -80 1190 {}
N -200 1170 -80 1170 {}
N 180 1170 180 1190 {}
N 60 1170 180 1170 {}
N 440 1170 440 1190 {}
N 320 1170 440 1170 {}
N 700 1170 700 1190 {}
N 580 1170 700 1170 {}
N 960 1170 960 1190 {}
N 840 1170 960 1170 {}
N 1220 1170 1220 1190 {}
N 1100 1170 1220 1170 {}
N 1480 1170 1480 1190 {}
N 1360 1170 1480 1170 {}
N -860 1390 -860 1410 {}
N -980 1390 -860 1390 {}
N -600 1390 -600 1410 {}
N -720 1390 -600 1390 {}
N -460 1390 -430 1390 {}
N -370 1390 -340 1390 {}
N -220 1390 -220 1410 {}
N -340 1390 -220 1390 {}
C {ELAD1_ANALOG_CORE.sym} 0 520 0 0 {name=XCORE}
C {devices/lab_pin.sym} -360 870 0 0 {name=l1 sig_type=std_logic lab=UA5}
C {devices/capa.sym} -500 920 0 0 {name=CPI5 value=2.5p}
C {devices/gnd.sym} -500 950 0 0 {name=l2 lab=0 global=false}
C {devices/res.sym} -560 870 3 0 {name=RPA5 value=500}
C {devices/lab_pin.sym} -620 870 0 0 {name=l3 sig_type=std_logic lab=P5}
C {devices/capa.sym} -740 920 0 0 {name=CPE5 value=2.5p}
C {devices/gnd.sym} -740 950 0 0 {name=l4 lab=0 global=false}
C {devices/vsource.sym} -860 920 0 0 {name=VP5 value=0}
C {devices/gnd.sym} -860 950 0 0 {name=l5 lab=0 global=false}
C {devices/lab_pin.sym} -360 730 0 0 {name=l6 sig_type=std_logic lab=UA4}
C {devices/capa.sym} -500 780 0 0 {name=CPI4 value=2.5p}
C {devices/gnd.sym} -500 810 0 0 {name=l7 lab=0 global=false}
C {devices/res.sym} -560 730 3 0 {name=RPA4 value=500}
C {devices/lab_pin.sym} -620 730 0 0 {name=l8 sig_type=std_logic lab=P4}
C {devices/capa.sym} -740 780 0 0 {name=CPE4 value=2.5p}
C {devices/gnd.sym} -740 810 0 0 {name=l9 lab=0 global=false}
C {devices/res.sym} -860 780 0 0 {name=RL4 value=1e9}
C {devices/gnd.sym} -860 810 0 0 {name=l10 lab=0 global=false}
C {devices/capa.sym} -980 780 0 0 {name=CL4 value=5p}
C {devices/gnd.sym} -980 810 0 0 {name=l11 lab=0 global=false}
C {devices/lab_pin.sym} -360 590 0 0 {name=l12 sig_type=std_logic lab=UA3}
C {devices/capa.sym} -500 640 0 0 {name=CPI3 value=2.5p}
C {devices/gnd.sym} -500 670 0 0 {name=l13 lab=0 global=false}
C {devices/res.sym} -560 590 3 0 {name=RPA3 value=500}
C {devices/lab_pin.sym} -620 590 0 0 {name=l14 sig_type=std_logic lab=P3}
C {devices/capa.sym} -740 640 0 0 {name=CPE3 value=2.5p}
C {devices/gnd.sym} -740 670 0 0 {name=l15 lab=0 global=false}
C {devices/res.sym} -860 640 0 0 {name=RL3 value=1e9}
C {devices/gnd.sym} -860 670 0 0 {name=l16 lab=0 global=false}
C {devices/capa.sym} -980 640 0 0 {name=CL3 value=5p}
C {devices/gnd.sym} -980 670 0 0 {name=l17 lab=0 global=false}
C {devices/lab_pin.sym} -360 450 0 0 {name=l18 sig_type=std_logic lab=UA2}
C {devices/capa.sym} -500 500 0 0 {name=CPI2 value=2.5p}
C {devices/gnd.sym} -500 530 0 0 {name=l19 lab=0 global=false}
C {devices/res.sym} -560 450 3 0 {name=RPA2 value=500}
C {devices/lab_pin.sym} -620 450 0 0 {name=l20 sig_type=std_logic lab=P2}
C {devices/capa.sym} -740 500 0 0 {name=CPE2 value=2.5p}
C {devices/gnd.sym} -740 530 0 0 {name=l21 lab=0 global=false}
C {devices/vsource.sym} -860 500 0 0 {name=VP2 value=0}
C {devices/gnd.sym} -860 530 0 0 {name=l22 lab=0 global=false}
C {devices/lab_pin.sym} -360 310 0 0 {name=l23 sig_type=std_logic lab=UA1}
C {devices/capa.sym} -500 360 0 0 {name=CPI1 value=2.5p}
C {devices/gnd.sym} -500 390 0 0 {name=l24 lab=0 global=false}
C {devices/res.sym} -560 310 3 0 {name=RPA1 value=500}
C {devices/lab_pin.sym} -620 310 0 0 {name=l25 sig_type=std_logic lab=P1}
C {devices/capa.sym} -740 360 0 0 {name=CPE1 value=2.5p}
C {devices/gnd.sym} -740 390 0 0 {name=l26 lab=0 global=false}
C {devices/vsource.sym} -860 360 0 0 {name=VQ value=0.7712}
C {devices/gnd.sym} -860 390 0 0 {name=l27 lab=0 global=false}
C {devices/lab_pin.sym} -360 170 0 0 {name=l28 sig_type=std_logic lab=UA0}
C {devices/capa.sym} -500 220 0 0 {name=CPI0 value=2.5p}
C {devices/gnd.sym} -500 250 0 0 {name=l29 lab=0 global=false}
C {devices/res.sym} -560 170 3 0 {name=RPA0 value=500}
C {devices/lab_pin.sym} -620 170 0 0 {name=l30 sig_type=std_logic lab=P0}
C {devices/capa.sym} -740 220 0 0 {name=CPE0 value=2.5p}
C {devices/gnd.sym} -740 250 0 0 {name=l31 lab=0 global=false}
C {devices/vsource.sym} -860 220 0 0 {name=VP0 value=0}
C {devices/gnd.sym} -860 250 0 0 {name=l32 lab=0 global=false}
C {devices/lab_pin.sym} 300 1000 0 1 {name=l33 sig_type=std_logic lab=VGND}
C {devices/vsource.sym} 440 1050 0 0 {name=VGNDS value=0}
C {devices/gnd.sym} 440 1080 0 0 {name=l34 lab=0 global=false}
C {devices/vdd.sym} 0 60 0 0 {name=l35 lab=VDPWR global=false}
C {devices/lab_pin.sym} -240 1020 1 1 {name=l36 sig_type=std_logic lab=EN_MG}
C {devices/lab_pin.sym} -200 1020 1 1 {name=l37 sig_type=std_logic lab=EN_MC}
C {devices/lab_pin.sym} -160 1020 1 1 {name=l38 sig_type=std_logic lab=EN_PG}
C {devices/lab_pin.sym} -120 1020 1 1 {name=l39 sig_type=std_logic lab=EN_PC}
C {devices/lab_pin.sym} -80 1020 1 1 {name=l40 sig_type=std_logic lab=EN_N}
C {devices/lab_pin.sym} -40 1020 1 1 {name=l41 sig_type=std_logic lab=CLR_MG}
C {devices/lab_pin.sym} 0 1020 1 1 {name=l42 sig_type=std_logic lab=CLR_MC}
C {devices/lab_pin.sym} 40 1020 1 1 {name=l43 sig_type=std_logic lab=CLR_PG}
C {devices/lab_pin.sym} 80 1020 1 1 {name=l44 sig_type=std_logic lab=CLR_PC}
C {devices/lab_pin.sym} 120 1020 1 1 {name=l45 sig_type=std_logic lab=CLR_N}
C {devices/lab_pin.sym} 160 1020 1 1 {name=l46 sig_type=std_logic lab=HEN}
C {devices/lab_pin.sym} 200 1020 1 1 {name=l47 sig_type=std_logic lab=AGG_CLK}
C {devices/lab_pin.sym} -980 1170 0 0 {name=l48 sig_type=std_logic lab=EN_MG}
C {devices/vsource.sym} -860 1220 0 0 {name=VEMG value=0}
C {devices/gnd.sym} -860 1250 0 0 {name=l49 lab=0 global=false}
C {devices/lab_pin.sym} -720 1170 0 0 {name=l50 sig_type=std_logic lab=EN_MC}
C {devices/vsource.sym} -600 1220 0 0 {name=VEMC value=0}
C {devices/gnd.sym} -600 1250 0 0 {name=l51 lab=0 global=false}
C {devices/lab_pin.sym} -460 1170 0 0 {name=l52 sig_type=std_logic lab=EN_PG}
C {devices/vsource.sym} -340 1220 0 0 {name=VEPG value=0}
C {devices/gnd.sym} -340 1250 0 0 {name=l53 lab=0 global=false}
C {devices/lab_pin.sym} -200 1170 0 0 {name=l54 sig_type=std_logic lab=EN_PC}
C {devices/vsource.sym} -80 1220 0 0 {name=VEPC value=0}
C {devices/gnd.sym} -80 1250 0 0 {name=l55 lab=0 global=false}
C {devices/lab_pin.sym} 60 1170 0 0 {name=l56 sig_type=std_logic lab=EN_N}
C {devices/vsource.sym} 180 1220 0 0 {name=VEN value=1.8}
C {devices/gnd.sym} 180 1250 0 0 {name=l57 lab=0 global=false}
C {devices/lab_pin.sym} 320 1170 0 0 {name=l58 sig_type=std_logic lab=CLR_MG}
C {devices/vsource.sym} 440 1220 0 0 {name=VCMG value=1.8}
C {devices/gnd.sym} 440 1250 0 0 {name=l59 lab=0 global=false}
C {devices/lab_pin.sym} 580 1170 0 0 {name=l60 sig_type=std_logic lab=CLR_MC}
C {devices/vsource.sym} 700 1220 0 0 {name=VCMC value=1.8}
C {devices/gnd.sym} 700 1250 0 0 {name=l61 lab=0 global=false}
C {devices/lab_pin.sym} 840 1170 0 0 {name=l62 sig_type=std_logic lab=CLR_PG}
C {devices/vsource.sym} 960 1220 0 0 {name=VCPG value=1.8}
C {devices/gnd.sym} 960 1250 0 0 {name=l63 lab=0 global=false}
C {devices/lab_pin.sym} 1100 1170 0 0 {name=l64 sig_type=std_logic lab=CLR_PC}
C {devices/vsource.sym} 1220 1220 0 0 {name=VCPC value=1.8}
C {devices/gnd.sym} 1220 1250 0 0 {name=l65 lab=0 global=false}
C {devices/lab_pin.sym} 1360 1170 0 0 {name=l66 sig_type=std_logic lab=CLR_N}
C {devices/vsource.sym} 1480 1220 0 0 {name=VCN value=0}
C {devices/gnd.sym} 1480 1250 0 0 {name=l67 lab=0 global=false}
C {devices/lab_pin.sym} -980 1390 0 0 {name=l68 sig_type=std_logic lab=HEN}
C {devices/vsource.sym} -860 1440 0 0 {name=VHEN value=0}
C {devices/gnd.sym} -860 1470 0 0 {name=l69 lab=0 global=false}
C {devices/lab_pin.sym} -720 1390 0 0 {name=l70 sig_type=std_logic lab=AGG_CLK}
C {devices/vsource.sym} -600 1440 0 0 {name=VAGG value="PULSE(0 1.8 1u 100p 100p 9.99e-08 2e-07)"}
C {devices/gnd.sym} -600 1470 0 0 {name=l71 lab=0 global=false}
C {devices/vdd.sym} -460 1390 0 0 {name=l72 lab=VDPWR global=false}
C {devices/res.sym} -400 1390 1 0 {name=RPDN value=5}
C {devices/lab_pin.sym} -340 1390 0 1 {name=l73 sig_type=std_logic lab=vsup}
C {devices/vsource.sym} -220 1440 0 0 {name=VSUP value=1.8}
C {devices/gnd.sym} -220 1470 0 0 {name=l74 lab=0 global=false}
T {tb_top_noise - noise mode (both victim stages, baseline and guarded) with the aggressor running.} -1020 -220 0 0 0.4 0.4 {}
T {ua1: VQUIET, the common bias of both victims   ua3 / ua4: victim outputs into the board load RL || CL
The aggressor clock AGG_CLK is the controller clock (10 MHz) divided by 2: period 2e-07 s.
For the clock divided by 16 set PULSE(0 1.8 1u 100p 100p 7.999e-7 1.6e-6).
The 5 ohm PDN puts the aggressor's switching current on the shared rail VDPWR.
Measured over 3..6 us: peak-to-peak on each output (p3pp, p4pp), between them (dpp) and on VDPWR.} -1020 -175 0 0 0.22 0.22 {}
C {devices/code_shown.sym} 1680 200 0 0 {name=s1 only_toplevel=false value=".option reltol=1e-4 abstol=1e-13 vntol=1e-7 gmin=1e-15 method=gear
.save v(P1) v(P3) v(P4) v(VDPWR) v(AGG_CLK)
.tran 0.2n 6u
.control
run
meas tran v3dc avg v(P3) from=0.5u to=0.95u
meas tran v4dc avg v(P4) from=0.5u to=0.95u
let vdiff = v(P3)-v(P4)
meas tran p3pp pp v(P3) from=3u to=6u
meas tran p4pp pp v(P4) from=3u to=6u
meas tran dpp pp vdiff from=3u to=6u
meas tran vdd_pp pp v(VDPWR) from=3u to=6u
echo ROW noise div=2 v3dc=$&v3dc v4dc=$&v4dc p3pp=$&p3pp p4pp=$&p4pp dpp=$&dpp vdd_pp=$&vdd_pp
.endc"}
C {sky130_fd_pr/corner.sym} 1680 0 0 0 {name=CORNER only_toplevel=true corner=tt}
