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
N -860 590 -860 610 {}
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
N 420 1390 420 1410 {}
N 300 1390 420 1390 {}
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
C {devices/vsource.sym} -860 780 0 0 {name=VD4 value=1.2}
C {devices/gnd.sym} -860 810 0 0 {name=l10 lab=0 global=false}
C {devices/lab_pin.sym} -360 590 0 0 {name=l11 sig_type=std_logic lab=UA3}
C {devices/capa.sym} -500 640 0 0 {name=CPI3 value=2.5p}
C {devices/gnd.sym} -500 670 0 0 {name=l12 lab=0 global=false}
C {devices/res.sym} -560 590 3 0 {name=RPA3 value=500}
C {devices/lab_pin.sym} -620 590 0 0 {name=l13 sig_type=std_logic lab=P3}
C {devices/capa.sym} -740 640 0 0 {name=CPE3 value=2.5p}
C {devices/gnd.sym} -740 670 0 0 {name=l14 lab=0 global=false}
C {devices/vsource.sym} -860 640 0 0 {name=VD3 value=1.2}
C {devices/gnd.sym} -860 670 0 0 {name=l15 lab=0 global=false}
C {devices/lab_pin.sym} -360 450 0 0 {name=l16 sig_type=std_logic lab=UA2}
C {devices/capa.sym} -500 500 0 0 {name=CPI2 value=2.5p}
C {devices/gnd.sym} -500 530 0 0 {name=l17 lab=0 global=false}
C {devices/res.sym} -560 450 3 0 {name=RPA2 value=500}
C {devices/lab_pin.sym} -620 450 0 0 {name=l18 sig_type=std_logic lab=P2}
C {devices/capa.sym} -740 500 0 0 {name=CPE2 value=2.5p}
C {devices/gnd.sym} -740 530 0 0 {name=l19 lab=0 global=false}
C {devices/bsource.sym} -860 500 0 0 {name=BM VAR=V FUNC="'1.0-v(dif)/2'" m=1}
C {devices/gnd.sym} -860 530 0 0 {name=l20 lab=0 global=false}
C {devices/lab_pin.sym} -360 310 0 0 {name=l21 sig_type=std_logic lab=UA1}
C {devices/capa.sym} -500 360 0 0 {name=CPI1 value=2.5p}
C {devices/gnd.sym} -500 390 0 0 {name=l22 lab=0 global=false}
C {devices/res.sym} -560 310 3 0 {name=RPA1 value=500}
C {devices/lab_pin.sym} -620 310 0 0 {name=l23 sig_type=std_logic lab=P1}
C {devices/capa.sym} -740 360 0 0 {name=CPE1 value=2.5p}
C {devices/gnd.sym} -740 390 0 0 {name=l24 lab=0 global=false}
C {devices/bsource.sym} -860 360 0 0 {name=BP VAR=V FUNC="'1.0+v(dif)/2'" m=1}
C {devices/gnd.sym} -860 390 0 0 {name=l25 lab=0 global=false}
C {devices/lab_pin.sym} -360 170 0 0 {name=l26 sig_type=std_logic lab=UA0}
C {devices/capa.sym} -500 220 0 0 {name=CPI0 value=2.5p}
C {devices/gnd.sym} -500 250 0 0 {name=l27 lab=0 global=false}
C {devices/res.sym} -560 170 3 0 {name=RPA0 value=500}
C {devices/lab_pin.sym} -620 170 0 0 {name=l28 sig_type=std_logic lab=P0}
C {devices/capa.sym} -740 220 0 0 {name=CPE0 value=2.5p}
C {devices/gnd.sym} -740 250 0 0 {name=l29 lab=0 global=false}
C {devices/isource.sym} -860 220 2 0 {name=IT value="DC 10u"}
C {devices/gnd.sym} -860 250 0 0 {name=l30 lab=0 global=false}
C {devices/lab_pin.sym} 300 1000 0 1 {name=l31 sig_type=std_logic lab=VGND}
C {devices/vsource.sym} 440 1050 0 0 {name=VGNDS value=0}
C {devices/gnd.sym} 440 1080 0 0 {name=l32 lab=0 global=false}
C {devices/vdd.sym} 0 60 0 0 {name=l33 lab=VDPWR global=false}
C {devices/lab_pin.sym} -240 1020 1 1 {name=l34 sig_type=std_logic lab=EN_MG}
C {devices/lab_pin.sym} -200 1020 1 1 {name=l35 sig_type=std_logic lab=EN_MC}
C {devices/lab_pin.sym} -160 1020 1 1 {name=l36 sig_type=std_logic lab=EN_PG}
C {devices/lab_pin.sym} -120 1020 1 1 {name=l37 sig_type=std_logic lab=EN_PC}
C {devices/lab_pin.sym} -80 1020 1 1 {name=l38 sig_type=std_logic lab=EN_N}
C {devices/lab_pin.sym} -40 1020 1 1 {name=l39 sig_type=std_logic lab=CLR_MG}
C {devices/lab_pin.sym} 0 1020 1 1 {name=l40 sig_type=std_logic lab=CLR_MC}
C {devices/lab_pin.sym} 40 1020 1 1 {name=l41 sig_type=std_logic lab=CLR_PG}
C {devices/lab_pin.sym} 80 1020 1 1 {name=l42 sig_type=std_logic lab=CLR_PC}
C {devices/lab_pin.sym} 120 1020 1 1 {name=l43 sig_type=std_logic lab=CLR_N}
C {devices/lab_pin.sym} 160 1020 1 1 {name=l44 sig_type=std_logic lab=HEN}
C {devices/lab_pin.sym} 200 1020 1 1 {name=l45 sig_type=std_logic lab=AGG_CLK}
C {devices/lab_pin.sym} -860 1170 0 0 {name=l46 sig_type=std_logic lab=EN_MG}
C {devices/vsource.sym} -740 1220 0 0 {name=VEMG value=0}
C {devices/gnd.sym} -740 1250 0 0 {name=l47 lab=0 global=false}
C {devices/lab_pin.sym} -600 1170 0 0 {name=l48 sig_type=std_logic lab=EN_MC}
C {devices/vsource.sym} -480 1220 0 0 {name=VEMC value=0}
C {devices/gnd.sym} -480 1250 0 0 {name=l49 lab=0 global=false}
C {devices/lab_pin.sym} -340 1170 0 0 {name=l50 sig_type=std_logic lab=EN_PG}
C {devices/vsource.sym} -220 1220 0 0 {name=VEPG value=1.8}
C {devices/gnd.sym} -220 1250 0 0 {name=l51 lab=0 global=false}
C {devices/lab_pin.sym} -80 1170 0 0 {name=l52 sig_type=std_logic lab=EN_PC}
C {devices/vsource.sym} 40 1220 0 0 {name=VEPC value=0}
C {devices/gnd.sym} 40 1250 0 0 {name=l53 lab=0 global=false}
C {devices/lab_pin.sym} 180 1170 0 0 {name=l54 sig_type=std_logic lab=EN_N}
C {devices/vsource.sym} 300 1220 0 0 {name=VEN value=0}
C {devices/gnd.sym} 300 1250 0 0 {name=l55 lab=0 global=false}
C {devices/lab_pin.sym} 440 1170 0 0 {name=l56 sig_type=std_logic lab=CLR_MG}
C {devices/vsource.sym} 560 1220 0 0 {name=VCMG value=1.8}
C {devices/gnd.sym} 560 1250 0 0 {name=l57 lab=0 global=false}
C {devices/lab_pin.sym} 700 1170 0 0 {name=l58 sig_type=std_logic lab=CLR_MC}
C {devices/vsource.sym} 820 1220 0 0 {name=VCMC value=1.8}
C {devices/gnd.sym} 820 1250 0 0 {name=l59 lab=0 global=false}
C {devices/lab_pin.sym} 960 1170 0 0 {name=l60 sig_type=std_logic lab=CLR_PG}
C {devices/vsource.sym} 1080 1220 0 0 {name=VCPG value=0}
C {devices/gnd.sym} 1080 1250 0 0 {name=l61 lab=0 global=false}
C {devices/lab_pin.sym} 1220 1170 0 0 {name=l62 sig_type=std_logic lab=CLR_PC}
C {devices/vsource.sym} 1340 1220 0 0 {name=VCPC value=1.8}
C {devices/gnd.sym} 1340 1250 0 0 {name=l63 lab=0 global=false}
C {devices/lab_pin.sym} -860 1390 0 0 {name=l64 sig_type=std_logic lab=CLR_N}
C {devices/vsource.sym} -740 1440 0 0 {name=VCN value=1.8}
C {devices/gnd.sym} -740 1470 0 0 {name=l65 lab=0 global=false}
C {devices/lab_pin.sym} -600 1390 0 0 {name=l66 sig_type=std_logic lab=HEN}
C {devices/vsource.sym} -480 1440 0 0 {name=VHEN value=0}
C {devices/gnd.sym} -480 1470 0 0 {name=l67 lab=0 global=false}
C {devices/lab_pin.sym} -340 1390 0 0 {name=l68 sig_type=std_logic lab=AGG_CLK}
C {devices/vsource.sym} -220 1440 0 0 {name=VAGG value=0}
C {devices/gnd.sym} -220 1470 0 0 {name=l69 lab=0 global=false}
C {devices/vdd.sym} -80 1390 0 0 {name=l70 lab=VDPWR global=false}
C {devices/res.sym} -20 1390 1 0 {name=RPDN value=5}
C {devices/lab_pin.sym} 40 1390 0 1 {name=l71 sig_type=std_logic lab=vsup}
C {devices/vsource.sym} 160 1440 0 0 {name=VSUP value=1.8}
C {devices/gnd.sym} 160 1470 0 0 {name=l72 lab=0 global=false}
C {devices/lab_pin.sym} 300 1390 0 0 {name=l73 sig_type=std_logic lab=dif}
C {devices/vsource.sym} 420 1440 0 0 {name=VDIF value=0}
C {devices/gnd.sym} 420 1470 0 0 {name=l74 lab=0 global=false}
T {tb_top_pair - differential-pair mode through the selector and the TT analog path.} -900 -220 0 0 0.4 0.4 {}
T {ua0: ITAIL forced into the on-chip tail diode   ua1 / ua2: VCM +/- VDIF/2
ua3 / ua4: drain voltage sources VD3, VD4 (ammeters)
Loop: both pair variants (1 = GROUPED, 2 = CENTROID) x ITAIL 4 / 10 / 20 uA. For each case an
operating point (ROW pairop: isum = total drain current, drop = drain-path voltage drop) and a VDIF sweep of
+/-2 mV in 1 mV steps; ROW pairvos: vos = input offset, the VDIF where the two drain currents are equal.} -900 -175 0 0 0.22 0.22 {}
C {devices/code_shown.sym} 1540 200 0 0 {name=s1 only_toplevel=false value=".option reltol=1e-6 abstol=1e-15 vntol=1e-8 gmin=1e-15 itl1=500 itl2=500
.control
foreach var 1 2
foreach it 4e-6 10e-6 20e-6
if $var = 1
alter VEPG dc = 1.8
alter VEPC dc = 0
alter VCPG dc = 0
alter VCPC dc = 1.8
else
alter VEPG dc = 0
alter VEPC dc = 1.8
alter VCPG dc = 1.8
alter VCPC dc = 0
end
alter IT dc = $it
op
let isum = -(i(VD3)+i(VD4))
let vbias_pin = v(P0)
if $var = 1
let vd1_int = v(xcore.d1_g)
else
let vd1_int = v(xcore.d1_c)
end
let drop_mv = 1000*(1.2 - vd1_int)
let isum_ratio = isum/$it
echo ROW pairop var=$var itail=$it isum=$&isum isum_ratio=$&isum_ratio vbias_pin=$&vbias_pin drop_mv=$&drop_mv
dc VDIF -0.002 0.002 0.001
let did = i(VD4)-i(VD3)
meas dc vos find v(dif) when did=0
let vos_uv = 1e6*vos
echo ROW pairvos var=$var itail=$it vos_uv=$&vos_uv
end
end
.endc"}
C {sky130_fd_pr/corner.sym} 1540 0 0 0 {name=CORNER only_toplevel=true corner=tt}
