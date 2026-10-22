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
N -740 730 -620 730 {}
N -770 730 -740 730 {}
N -860 730 -830 730 {}
N -380 590 -360 590 {}
N -360 590 -340 590 {}
N -500 590 -500 610 {}
N -500 590 -380 590 {}
N -530 590 -500 590 {}
N -620 590 -590 590 {}
N -740 590 -740 610 {}
N -740 590 -620 590 {}
N -380 450 -360 450 {}
N -360 450 -340 450 {}
N -500 450 -500 470 {}
N -500 450 -380 450 {}
N -530 450 -500 450 {}
N -620 450 -590 450 {}
N -740 450 -740 470 {}
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
N -980 170 -980 190 {}
N -980 170 -860 170 {}
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
N 40 1390 40 1410 {}
N 160 1390 160 1410 {}
N -80 1390 40 1390 {}
N 40 1390 160 1390 {}
N 360 1470 360 1490 {}
N 300 1420 320 1420 {}
N 300 1460 320 1460 {}
N 560 1390 560 1410 {}
N 500 1420 520 1420 {}
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
C {devices/vsource.sym} -800 730 3 0 {name=VM4 value=0}
C {devices/lab_pin.sym} -860 730 0 0 {name=l10 sig_type=std_logic lab=P4x}
C {devices/lab_pin.sym} -360 590 0 0 {name=l11 sig_type=std_logic lab=UA3}
C {devices/capa.sym} -500 640 0 0 {name=CPI3 value=2.5p}
C {devices/gnd.sym} -500 670 0 0 {name=l12 lab=0 global=false}
C {devices/res.sym} -560 590 3 0 {name=RPA3 value=500}
C {devices/lab_pin.sym} -620 590 0 0 {name=l13 sig_type=std_logic lab=P3}
C {devices/capa.sym} -740 640 0 0 {name=CPE3 value=2.5p}
C {devices/gnd.sym} -740 670 0 0 {name=l14 lab=0 global=false}
C {devices/lab_pin.sym} -360 450 0 0 {name=l15 sig_type=std_logic lab=UA2}
C {devices/capa.sym} -500 500 0 0 {name=CPI2 value=2.5p}
C {devices/gnd.sym} -500 530 0 0 {name=l16 lab=0 global=false}
C {devices/res.sym} -560 450 3 0 {name=RPA2 value=500}
C {devices/lab_pin.sym} -620 450 0 0 {name=l17 sig_type=std_logic lab=P2}
C {devices/capa.sym} -740 500 0 0 {name=CPE2 value=2.5p}
C {devices/gnd.sym} -740 530 0 0 {name=l18 lab=0 global=false}
C {devices/lab_pin.sym} -360 310 0 0 {name=l19 sig_type=std_logic lab=UA1}
C {devices/capa.sym} -500 360 0 0 {name=CPI1 value=2.5p}
C {devices/gnd.sym} -500 390 0 0 {name=l20 lab=0 global=false}
C {devices/res.sym} -560 310 3 0 {name=RPA1 value=500}
C {devices/lab_pin.sym} -620 310 0 0 {name=l21 sig_type=std_logic lab=P1}
C {devices/capa.sym} -740 360 0 0 {name=CPE1 value=2.5p}
C {devices/gnd.sym} -740 390 0 0 {name=l22 lab=0 global=false}
C {devices/vsource.sym} -860 360 0 0 {name=VP1 value=0}
C {devices/gnd.sym} -860 390 0 0 {name=l23 lab=0 global=false}
C {devices/lab_pin.sym} -360 170 0 0 {name=l24 sig_type=std_logic lab=UA0}
C {devices/capa.sym} -500 220 0 0 {name=CPI0 value=2.5p}
C {devices/gnd.sym} -500 250 0 0 {name=l25 lab=0 global=false}
C {devices/res.sym} -560 170 3 0 {name=RPA0 value=500}
C {devices/lab_pin.sym} -620 170 0 0 {name=l26 sig_type=std_logic lab=P0}
C {devices/capa.sym} -740 220 0 0 {name=CPE0 value=2.5p}
C {devices/gnd.sym} -740 250 0 0 {name=l27 lab=0 global=false}
C {devices/isource.sym} -860 220 2 0 {name=IREF value="DC 10u"}
C {devices/gnd.sym} -860 250 0 0 {name=l28 lab=0 global=false}
C {devices/bsource.sym} -980 220 0 0 {name=BCMP VAR=I FUNC="'max(0, v(P0)-1.8)*0.1'" m=1}
C {devices/gnd.sym} -980 250 0 0 {name=l29 lab=0 global=false}
C {devices/lab_pin.sym} 300 1000 0 1 {name=l30 sig_type=std_logic lab=VGND}
C {devices/vsource.sym} 440 1050 0 0 {name=VGNDS value=0}
C {devices/gnd.sym} 440 1080 0 0 {name=l31 lab=0 global=false}
C {devices/vdd.sym} 0 60 0 0 {name=l32 lab=VDPWR global=false}
C {devices/lab_pin.sym} -240 1020 1 1 {name=l33 sig_type=std_logic lab=EN_MG}
C {devices/lab_pin.sym} -200 1020 1 1 {name=l34 sig_type=std_logic lab=EN_MC}
C {devices/lab_pin.sym} -160 1020 1 1 {name=l35 sig_type=std_logic lab=EN_PG}
C {devices/lab_pin.sym} -120 1020 1 1 {name=l36 sig_type=std_logic lab=EN_PC}
C {devices/lab_pin.sym} -80 1020 1 1 {name=l37 sig_type=std_logic lab=EN_N}
C {devices/lab_pin.sym} -40 1020 1 1 {name=l38 sig_type=std_logic lab=CLR_MG}
C {devices/lab_pin.sym} 0 1020 1 1 {name=l39 sig_type=std_logic lab=CLR_MC}
C {devices/lab_pin.sym} 40 1020 1 1 {name=l40 sig_type=std_logic lab=CLR_PG}
C {devices/lab_pin.sym} 80 1020 1 1 {name=l41 sig_type=std_logic lab=CLR_PC}
C {devices/lab_pin.sym} 120 1020 1 1 {name=l42 sig_type=std_logic lab=CLR_N}
C {devices/lab_pin.sym} 160 1020 1 1 {name=l43 sig_type=std_logic lab=HEN}
C {devices/lab_pin.sym} 200 1020 1 1 {name=l44 sig_type=std_logic lab=AGG_CLK}
C {devices/lab_pin.sym} -980 1170 0 0 {name=l45 sig_type=std_logic lab=EN_MG}
C {devices/vsource.sym} -860 1220 0 0 {name=VEMG value="PWL(0 1.8 2.5u 1.8 2.501u 0)"}
C {devices/gnd.sym} -860 1250 0 0 {name=l46 lab=0 global=false}
C {devices/lab_pin.sym} -720 1170 0 0 {name=l47 sig_type=std_logic lab=EN_MC}
C {devices/vsource.sym} -600 1220 0 0 {name=VEMC value="PWL(0 0 3.2u 0 3.201u 1.8)"}
C {devices/gnd.sym} -600 1250 0 0 {name=l48 lab=0 global=false}
C {devices/lab_pin.sym} -460 1170 0 0 {name=l49 sig_type=std_logic lab=EN_PG}
C {devices/vsource.sym} -340 1220 0 0 {name=VEPG value=0}
C {devices/gnd.sym} -340 1250 0 0 {name=l50 lab=0 global=false}
C {devices/lab_pin.sym} -200 1170 0 0 {name=l51 sig_type=std_logic lab=EN_PC}
C {devices/vsource.sym} -80 1220 0 0 {name=VEPC value=0}
C {devices/gnd.sym} -80 1250 0 0 {name=l52 lab=0 global=false}
C {devices/lab_pin.sym} 60 1170 0 0 {name=l53 sig_type=std_logic lab=EN_N}
C {devices/vsource.sym} 180 1220 0 0 {name=VEN value=0}
C {devices/gnd.sym} 180 1250 0 0 {name=l54 lab=0 global=false}
C {devices/lab_pin.sym} 320 1170 0 0 {name=l55 sig_type=std_logic lab=CLR_MG}
C {devices/vsource.sym} 440 1220 0 0 {name=VCMG value="PWL(0 0 2.9u 0 2.901u 1.8)"}
C {devices/gnd.sym} 440 1250 0 0 {name=l56 lab=0 global=false}
C {devices/lab_pin.sym} 580 1170 0 0 {name=l57 sig_type=std_logic lab=CLR_MC}
C {devices/vsource.sym} 700 1220 0 0 {name=VCMC value="PWL(0 1.8 2.9u 1.8 2.901u 0)"}
C {devices/gnd.sym} 700 1250 0 0 {name=l58 lab=0 global=false}
C {devices/lab_pin.sym} 840 1170 0 0 {name=l59 sig_type=std_logic lab=CLR_PG}
C {devices/vsource.sym} 960 1220 0 0 {name=VCPG value=1.8}
C {devices/gnd.sym} 960 1250 0 0 {name=l60 lab=0 global=false}
C {devices/lab_pin.sym} 1100 1170 0 0 {name=l61 sig_type=std_logic lab=CLR_PC}
C {devices/vsource.sym} 1220 1220 0 0 {name=VCPC value=1.8}
C {devices/gnd.sym} 1220 1250 0 0 {name=l62 lab=0 global=false}
C {devices/lab_pin.sym} 1360 1170 0 0 {name=l63 sig_type=std_logic lab=CLR_N}
C {devices/vsource.sym} 1480 1220 0 0 {name=VCN value=1.8}
C {devices/gnd.sym} 1480 1250 0 0 {name=l64 lab=0 global=false}
C {devices/lab_pin.sym} -980 1390 0 0 {name=l65 sig_type=std_logic lab=HEN}
C {devices/vsource.sym} -860 1440 0 0 {name=VHEN value=0}
C {devices/gnd.sym} -860 1470 0 0 {name=l66 lab=0 global=false}
C {devices/lab_pin.sym} -720 1390 0 0 {name=l67 sig_type=std_logic lab=AGG_CLK}
C {devices/vsource.sym} -600 1440 0 0 {name=VAGG value=0}
C {devices/gnd.sym} -600 1470 0 0 {name=l68 lab=0 global=false}
C {devices/vdd.sym} -460 1390 0 0 {name=l69 lab=VDPWR global=false}
C {devices/res.sym} -400 1390 1 0 {name=RPDN value=5}
C {devices/lab_pin.sym} -340 1390 0 1 {name=l70 sig_type=std_logic lab=vsup}
C {devices/vsource.sym} -220 1440 0 0 {name=VSUP value=1.8}
C {devices/gnd.sym} -220 1470 0 0 {name=l71 lab=0 global=false}
C {devices/lab_pin.sym} -80 1390 0 0 {name=l72 sig_type=std_logic lab=nint}
C {devices/capa.sym} 40 1440 0 0 {name=CINT value=1n}
C {devices/gnd.sym} 40 1470 0 0 {name=l73 lab=0 global=false}
C {devices/res.sym} 160 1440 0 0 {name=RINT value=1e12}
C {devices/gnd.sym} 160 1470 0 0 {name=l74 lab=0 global=false}
C {devices/vccs.sym} 360 1440 0 0 {name=GINT value=1e-3}
C {devices/gnd.sym} 360 1410 0 0 {name=l75 lab=0 global=false}
C {devices/lab_pin.sym} 360 1490 0 1 {name=l76 sig_type=std_logic lab=nint}
C {devices/lab_pin.sym} 300 1420 0 0 {name=l77 sig_type=std_logic lab=P3}
C {devices/lab_pin.sym} 300 1460 0 0 {name=l78 sig_type=std_logic lab=P2}
C {devices/vcvs.sym} 560 1440 0 0 {name=E4 value=1}
C {devices/lab_pin.sym} 560 1390 0 1 {name=l79 sig_type=std_logic lab=P4x}
C {devices/gnd.sym} 560 1470 0 0 {name=l80 lab=0 global=false}
C {devices/lab_pin.sym} 500 1420 0 0 {name=l81 sig_type=std_logic lab=nint}
C {devices/gnd.sym} 520 1460 0 0 {name=l82 lab=0 global=false}
T {tb_top_transition - live reconfiguration MIRROR grouped -> MIRROR centroid while 10 uA flows.} -1020 -330 0 0 0.4 0.4 {}
T {Controller timing (from the RTL, clk = 10 MHz, APPLY at 2.0 us):
2.5 us  EN_MG -> 0                   (STOP state end: paths open)
2.9 us  CLR_MG -> 1, CLR_MC -> 0     (QUIET end: clamps follow the new configuration)
3.2 us  EN_MC -> 1                   (CONNECT)
ua0: 10 uA source with 1.8 V compliance (GCMP bleeds current above 1.8 V).
ua4: servo, an integrator (GINT into CINT, about 160 kHz unity-gain bandwidth) forcing
V(OUT internal, sensed on ua2) = V(REF, sensed on ua3).
Measured: vp0max = highest ua0 voltage during the change, iout_g / iout_c = output current
before / after, tsettle = time after CONNECT until the current is within 1e-4 of its final
value, ipk = peak servo current. wrdata writes transition.dat (P0, P3, i(VM4), REF_G, REF_C).} -1020 -285 0 0 0.22 0.22 {}
C {devices/code_shown.sym} 1680 200 0 0 {name=s1 only_toplevel=false value=".option reltol=1e-4 abstol=1e-13 vntol=1e-7 gmin=1e-15 method=gear
.ic v(nint)=0.672
.save v(P0) v(P2) v(P3) v(P4) i(VM4) v(nint) v(EN_MG) v(EN_MC) v(xcore.ref_g) v(xcore.out_g) v(xcore.ref_c) v(xcore.out_c)
.tran 1n 10u
.control
run
meas tran vp0max max v(P0) from=2.4u to=3.6u
meas tran iout_g avg i(VM4) from=1.8u to=2.0u
meas tran iout_c avg i(VM4) from=9.5u to=10u
let e = abs(i(VM4)-iout_c)/10e-6
meas tran tset when e=1e-4 fall=last
let tsettle = tset - 3.2e-6
meas tran ipk max i(VM4) from=3.2u to=10u
echo ROW transition vp0max=$&vp0max iout_g=$&iout_g iout_c=$&iout_c tsettle=$&tsettle ipk=$&ipk
wrdata transition.dat v(P0) v(P3) i(VM4) v(xcore.ref_g) v(xcore.ref_c)
.endc"}
C {sky130_fd_pr/corner.sym} 1680 0 0 0 {name=CORNER only_toplevel=true corner=tt}
