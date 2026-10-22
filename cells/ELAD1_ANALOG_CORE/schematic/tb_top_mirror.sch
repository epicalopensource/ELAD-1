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
N -860 730 -740 730 {}
N -740 730 -620 730 {}
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
N -740 1170 -740 1190 {}
N -860 1170 -740 1170 {}
N -480 1170 -480 1190 {}
N -600 1170 -480 1170 {}
N -220 1170 -220 1190 {}
N -340 1170 -220 1170 {}
N 40 1170 40 1190 {}
N -80 1170 40 1170 {}
N 300 1170 300 1190 {}
N 180 1170 300 1170 {}
N 560 1170 560 1190 {}
N 440 1170 560 1170 {}
N 820 1170 820 1190 {}
N 700 1170 820 1170 {}
N 1080 1170 1080 1190 {}
N 960 1170 1080 1170 {}
N 1340 1170 1340 1190 {}
N 1220 1170 1340 1170 {}
N -740 1390 -740 1410 {}
N -860 1390 -740 1390 {}
N -480 1390 -480 1410 {}
N -600 1390 -480 1390 {}
N -220 1390 -220 1410 {}
N -340 1390 -220 1390 {}
N -80 1390 -50 1390 {}
N 10 1390 40 1390 {}
N 160 1390 160 1410 {}
N 40 1390 160 1390 {}
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
C {devices/vsource.sym} -860 780 0 0 {name=VS4 value=0.65}
C {devices/gnd.sym} -860 810 0 0 {name=l10 lab=0 global=false}
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
C {devices/lab_pin.sym} 300 1000 0 1 {name=l29 sig_type=std_logic lab=VGND}
C {devices/vsource.sym} 440 1050 0 0 {name=VGNDS value=0}
C {devices/gnd.sym} 440 1080 0 0 {name=l30 lab=0 global=false}
C {devices/vdd.sym} 0 60 0 0 {name=l31 lab=VDPWR global=false}
C {devices/lab_pin.sym} -240 1020 1 1 {name=l32 sig_type=std_logic lab=EN_MG}
C {devices/lab_pin.sym} -200 1020 1 1 {name=l33 sig_type=std_logic lab=EN_MC}
C {devices/lab_pin.sym} -160 1020 1 1 {name=l34 sig_type=std_logic lab=EN_PG}
C {devices/lab_pin.sym} -120 1020 1 1 {name=l35 sig_type=std_logic lab=EN_PC}
C {devices/lab_pin.sym} -80 1020 1 1 {name=l36 sig_type=std_logic lab=EN_N}
C {devices/lab_pin.sym} -40 1020 1 1 {name=l37 sig_type=std_logic lab=CLR_MG}
C {devices/lab_pin.sym} 0 1020 1 1 {name=l38 sig_type=std_logic lab=CLR_MC}
C {devices/lab_pin.sym} 40 1020 1 1 {name=l39 sig_type=std_logic lab=CLR_PG}
C {devices/lab_pin.sym} 80 1020 1 1 {name=l40 sig_type=std_logic lab=CLR_PC}
C {devices/lab_pin.sym} 120 1020 1 1 {name=l41 sig_type=std_logic lab=CLR_N}
C {devices/lab_pin.sym} 160 1020 1 1 {name=l42 sig_type=std_logic lab=HEN}
C {devices/lab_pin.sym} 200 1020 1 1 {name=l43 sig_type=std_logic lab=AGG_CLK}
C {devices/lab_pin.sym} -860 1170 0 0 {name=l44 sig_type=std_logic lab=EN_MG}
C {devices/vsource.sym} -740 1220 0 0 {name=VEMG value=1.8}
C {devices/gnd.sym} -740 1250 0 0 {name=l45 lab=0 global=false}
C {devices/lab_pin.sym} -600 1170 0 0 {name=l46 sig_type=std_logic lab=EN_MC}
C {devices/vsource.sym} -480 1220 0 0 {name=VEMC value=0}
C {devices/gnd.sym} -480 1250 0 0 {name=l47 lab=0 global=false}
C {devices/lab_pin.sym} -340 1170 0 0 {name=l48 sig_type=std_logic lab=EN_PG}
C {devices/vsource.sym} -220 1220 0 0 {name=VEPG value=0}
C {devices/gnd.sym} -220 1250 0 0 {name=l49 lab=0 global=false}
C {devices/lab_pin.sym} -80 1170 0 0 {name=l50 sig_type=std_logic lab=EN_PC}
C {devices/vsource.sym} 40 1220 0 0 {name=VEPC value=0}
C {devices/gnd.sym} 40 1250 0 0 {name=l51 lab=0 global=false}
C {devices/lab_pin.sym} 180 1170 0 0 {name=l52 sig_type=std_logic lab=EN_N}
C {devices/vsource.sym} 300 1220 0 0 {name=VEN value=0}
C {devices/gnd.sym} 300 1250 0 0 {name=l53 lab=0 global=false}
C {devices/lab_pin.sym} 440 1170 0 0 {name=l54 sig_type=std_logic lab=CLR_MG}
C {devices/vsource.sym} 560 1220 0 0 {name=VCMG value=0}
C {devices/gnd.sym} 560 1250 0 0 {name=l55 lab=0 global=false}
C {devices/lab_pin.sym} 700 1170 0 0 {name=l56 sig_type=std_logic lab=CLR_MC}
C {devices/vsource.sym} 820 1220 0 0 {name=VCMC value=1.8}
C {devices/gnd.sym} 820 1250 0 0 {name=l57 lab=0 global=false}
C {devices/lab_pin.sym} 960 1170 0 0 {name=l58 sig_type=std_logic lab=CLR_PG}
C {devices/vsource.sym} 1080 1220 0 0 {name=VCPG value=1.8}
C {devices/gnd.sym} 1080 1250 0 0 {name=l59 lab=0 global=false}
C {devices/lab_pin.sym} 1220 1170 0 0 {name=l60 sig_type=std_logic lab=CLR_PC}
C {devices/vsource.sym} 1340 1220 0 0 {name=VCPC value=1.8}
C {devices/gnd.sym} 1340 1250 0 0 {name=l61 lab=0 global=false}
C {devices/lab_pin.sym} -860 1390 0 0 {name=l62 sig_type=std_logic lab=CLR_N}
C {devices/vsource.sym} -740 1440 0 0 {name=VCN value=1.8}
C {devices/gnd.sym} -740 1470 0 0 {name=l63 lab=0 global=false}
C {devices/lab_pin.sym} -600 1390 0 0 {name=l64 sig_type=std_logic lab=HEN}
C {devices/vsource.sym} -480 1440 0 0 {name=VHEN value=0}
C {devices/gnd.sym} -480 1470 0 0 {name=l65 lab=0 global=false}
C {devices/lab_pin.sym} -340 1390 0 0 {name=l66 sig_type=std_logic lab=AGG_CLK}
C {devices/vsource.sym} -220 1440 0 0 {name=VAGG value=0}
C {devices/gnd.sym} -220 1470 0 0 {name=l67 lab=0 global=false}
C {devices/vdd.sym} -80 1390 0 0 {name=l68 lab=VDPWR global=false}
C {devices/res.sym} -20 1390 1 0 {name=RPDN value=5}
C {devices/lab_pin.sym} 40 1390 0 1 {name=l69 sig_type=std_logic lab=vsup}
C {devices/vsource.sym} 160 1440 0 0 {name=VSUP value=1.8}
C {devices/gnd.sym} 160 1470 0 0 {name=l70 lab=0 global=false}
T {tb_top_mirror - current-mirror mode through the selector and the TT analog path.} -900 -307.5 0 0 0.4 0.4 {}
T {ua0: IREF (ideal current source, board side)   ua3: REF sense   ua2: OUT Kelvin sense
ua4: SMU voltage VS4. Kelvin on: VS4 is corrected by V(P3)-V(P2) over 3 operating points until
V(P2) = V(P3), i.e. equal VDS inside the macro (what the chip's Kelvin servo does).
Kelvin off: VS4 = V(P3), the unguided baseline. (The package wrote the servo as a 1e5-gain
source inside the circuit; with the full sky130 models that stops the solver at some
points, the relaxation here gives the same result without feedback in the matrix.)
Loop: both mirror variants (1 = GROUPED, 2 = CENTROID) x Kelvin on/off x four IREF values, one
'ROW mirror ...' line per case: err_pct = 100*(IOUT-IREF)/IREF, dvds_mv = VDS(OUT)-VDS(REF)
inside the macro, v_ua0 = voltage the current source needs on ua0 (compliance).} -900 -262.5 0 0 0.22 0.22 {}
C {devices/code_shown.sym} 1540 200 0 0 {name=s1 only_toplevel=false value=".option reltol=1e-6 abstol=1e-15 vntol=1e-8 gmin=1e-15 itl1=500 itl2=500
.control
foreach var 1 2
if $var = 1
alter VEMG dc = 1.8
alter VEMC dc = 0
alter VCMG dc = 0
alter VCMC dc = 1.8
else
alter VEMG dc = 0
alter VEMC dc = 1.8
alter VCMG dc = 1.8
alter VCMC dc = 0
end
foreach kelv 1 0
foreach ir 2e-6 5e-6 10e-6 20e-6
alter IREF dc = $ir
let vf = 0.65
alter VS4 dc = $&vf
op
if $kelv = 1
let vf = vf + v(P3) - v(P2)
alter VS4 dc = $&vf
op
let vf = vf + v(P3) - v(P2)
alter VS4 dc = $&vf
op
else
let vf = v(P3)
alter VS4 dc = $&vf
op
end
let iout = -i(VS4)
let err_pct = 100*(iout-$ir)/$ir
if $var = 1
let vref_int = v(xcore.ref_g)
let vout_int = v(xcore.out_g)
else
let vref_int = v(xcore.ref_c)
let vout_int = v(xcore.out_c)
end
let dvds_mv = 1000*(vout_int - vref_int)
let vua0 = v(P0)
echo ROW mirror var=$var kelvin=$kelv iref=$ir err_pct=$&err_pct dvds_mv=$&dvds_mv v_ua0=$&vua0
end
end
end
.endc"}
C {sky130_fd_pr/corner.sym} 1540 0 0 0 {name=CORNER only_toplevel=true corner=tt}
