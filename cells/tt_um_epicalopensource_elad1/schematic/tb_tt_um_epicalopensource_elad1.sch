v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {tt_um_epicalopensource_elad1.sym} 0 0 0 0 {name=xdut}
N -170 -100 -230 -100 {lab=UI7,UI6,UI5,UI4,UI3,UI2,UI1,UI0}
C {devices/lab_pin.sym} -230.0 -100.0 0 0 {name=l1 sig_type=std_logic lab=UI7,UI6,UI5,UI4,UI3,UI2,UI1,UI0}
N -170 -60 -230 -60 {lab=UIOI7,UIOI6,UIOI5,UIOI4,UIOI3,UIOI2,UIOI1,UIOI0}
C {devices/lab_pin.sym} -230.0 -60.0 0 0 {name=l2 sig_type=std_logic lab=UIOI7,UIOI6,UIOI5,UIOI4,UIOI3,UIOI2,UIOI1,UIOI0}
N -170 -20 -230 -20 {lab=PIN7,PIN6,PIN5,PIN4,PIN3,PIN2,PIN1,PIN0}
C {devices/lab_pin.sym} -230.0 -20.0 0 0 {name=l3 sig_type=std_logic lab=PIN7,PIN6,PIN5,PIN4,PIN3,PIN2,PIN1,PIN0}
N -170 20 -230 20 {lab=ENA}
C {devices/lab_pin.sym} -230.0 20.0 0 0 {name=l4 sig_type=std_logic lab=ENA}
N -170 60 -230 60 {lab=CLK}
C {devices/lab_pin.sym} -230.0 60.0 0 0 {name=l5 sig_type=std_logic lab=CLK}
N -170 100 -230 100 {lab=RST_N}
C {devices/lab_pin.sym} -230.0 100.0 0 0 {name=l6 sig_type=std_logic lab=RST_N}
N 170 -100 230 -100 {lab=UO7,UO6,UO5,UO4,UO3,UO2,UO1,UO0}
C {devices/lab_pin.sym} 230.0 -100.0 0 1 {name=l7 sig_type=std_logic lab=UO7,UO6,UO5,UO4,UO3,UO2,UO1,UO0}
N 170 -60 230 -60 {lab=UIOO7,UIOO6,UIOO5,UIOO4,UIOO3,UIOO2,UIOO1,UIOO0}
C {devices/lab_pin.sym} 230.0 -60.0 0 1 {name=l8 sig_type=std_logic lab=UIOO7,UIOO6,UIOO5,UIOO4,UIOO3,UIOO2,UIOO1,UIOO0}
N 170 -20 230 -20 {lab=OE7,OE6,OE5,OE4,OE3,OE2,OE1,OE0}
C {devices/lab_pin.sym} 230.0 -20.0 0 1 {name=l9 sig_type=std_logic lab=OE7,OE6,OE5,OE4,OE3,OE2,OE1,OE0}
N -10 -160 -10 -200 {lab=VDPWR}
C {devices/lab_pin.sym} -10.0 -200.0 3 0 {name=l10 sig_type=std_logic lab=VDPWR}
N -10 160 -10 200 {lab=VGND}
C {devices/lab_pin.sym} -10.0 200.0 1 0 {name=l11 sig_type=std_logic lab=VGND}
C {devices/vsource.sym} -1200 -150 0 0 {name=VDD value="1.8"}
N -1200 -180 -1200 -200 {lab=VDPWR}
C {devices/lab_pin.sym} -1200 -200 3 0 {name=l12 sig_type=std_logic lab=VDPWR}
N -1200 -120 -1200 -100 {lab=0}
C {devices/lab_pin.sym} -1200 -100 1 0 {name=l13 sig_type=std_logic lab=0}
C {devices/vsource.sym} -1000 -150 0 0 {name=VSS value="0"}
N -1000 -180 -1000 -200 {lab=VGND}
C {devices/lab_pin.sym} -1000 -200 3 0 {name=l14 sig_type=std_logic lab=VGND}
N -1000 -120 -1000 -100 {lab=0}
C {devices/lab_pin.sym} -1000 -100 1 0 {name=l15 sig_type=std_logic lab=0}
C {devices/isource.sym} -1200 700 0 0 {name=IT value="DC 10u"}
N -1200 670 -1200 650 {lab=0}
C {devices/lab_pin.sym} -1200 650 3 0 {name=l16 sig_type=std_logic lab=0}
N -1200 730 -1200 750 {lab=BRD0}
C {devices/lab_pin.sym} -1200 750 1 0 {name=l17 sig_type=std_logic lab=BRD0}
C {devices/capa.sym} -1140 900 0 0 {name=CPE0 value="2.5p"}
N -1140 870 -1140 850 {lab=BRD0}
C {devices/lab_pin.sym} -1140 850 3 0 {name=l18 sig_type=std_logic lab=BRD0}
N -1140 930 -1140 950 {lab=0}
C {devices/lab_pin.sym} -1140 950 1 0 {name=l19 sig_type=std_logic lab=0}
C {devices/res.sym} -1200 1100 0 0 {name=RPA0 value="500"}
N -1200 1070 -1200 1050 {lab=BRD0}
C {devices/lab_pin.sym} -1200 1050 3 0 {name=l20 sig_type=std_logic lab=BRD0}
N -1200 1130 -1200 1150 {lab=PIN0}
C {devices/lab_pin.sym} -1200 1150 1 0 {name=l21 sig_type=std_logic lab=PIN0}
C {devices/capa.sym} -1140 1300 0 0 {name=CPI0 value="2.5p"}
N -1140 1270 -1140 1250 {lab=PIN0}
C {devices/lab_pin.sym} -1140 1250 3 0 {name=l22 sig_type=std_logic lab=PIN0}
N -1140 1330 -1140 1350 {lab=0}
C {devices/lab_pin.sym} -1140 1350 1 0 {name=l23 sig_type=std_logic lab=0}
C {devices/vsource.sym} -1000 700 0 0 {name=VP value="1.0"}
N -1000 670 -1000 650 {lab=BRD1}
C {devices/lab_pin.sym} -1000 650 3 0 {name=l24 sig_type=std_logic lab=BRD1}
N -1000 730 -1000 750 {lab=0}
C {devices/lab_pin.sym} -1000 750 1 0 {name=l25 sig_type=std_logic lab=0}
C {devices/capa.sym} -940 900 0 0 {name=CPE1 value="2.5p"}
N -940 870 -940 850 {lab=BRD1}
C {devices/lab_pin.sym} -940 850 3 0 {name=l26 sig_type=std_logic lab=BRD1}
N -940 930 -940 950 {lab=0}
C {devices/lab_pin.sym} -940 950 1 0 {name=l27 sig_type=std_logic lab=0}
C {devices/res.sym} -1000 1100 0 0 {name=RPA1 value="500"}
N -1000 1070 -1000 1050 {lab=BRD1}
C {devices/lab_pin.sym} -1000 1050 3 0 {name=l28 sig_type=std_logic lab=BRD1}
N -1000 1130 -1000 1150 {lab=PIN1}
C {devices/lab_pin.sym} -1000 1150 1 0 {name=l29 sig_type=std_logic lab=PIN1}
C {devices/capa.sym} -940 1300 0 0 {name=CPI1 value="2.5p"}
N -940 1270 -940 1250 {lab=PIN1}
C {devices/lab_pin.sym} -940 1250 3 0 {name=l30 sig_type=std_logic lab=PIN1}
N -940 1330 -940 1350 {lab=0}
C {devices/lab_pin.sym} -940 1350 1 0 {name=l31 sig_type=std_logic lab=0}
C {devices/vsource.sym} -800 700 0 0 {name=VM value="1.0"}
N -800 670 -800 650 {lab=BRD2}
C {devices/lab_pin.sym} -800 650 3 0 {name=l32 sig_type=std_logic lab=BRD2}
N -800 730 -800 750 {lab=0}
C {devices/lab_pin.sym} -800 750 1 0 {name=l33 sig_type=std_logic lab=0}
C {devices/capa.sym} -740 900 0 0 {name=CPE2 value="2.5p"}
N -740 870 -740 850 {lab=BRD2}
C {devices/lab_pin.sym} -740 850 3 0 {name=l34 sig_type=std_logic lab=BRD2}
N -740 930 -740 950 {lab=0}
C {devices/lab_pin.sym} -740 950 1 0 {name=l35 sig_type=std_logic lab=0}
C {devices/res.sym} -800 1100 0 0 {name=RPA2 value="500"}
N -800 1070 -800 1050 {lab=BRD2}
C {devices/lab_pin.sym} -800 1050 3 0 {name=l36 sig_type=std_logic lab=BRD2}
N -800 1130 -800 1150 {lab=PIN2}
C {devices/lab_pin.sym} -800 1150 1 0 {name=l37 sig_type=std_logic lab=PIN2}
C {devices/capa.sym} -740 1300 0 0 {name=CPI2 value="2.5p"}
N -740 1270 -740 1250 {lab=PIN2}
C {devices/lab_pin.sym} -740 1250 3 0 {name=l38 sig_type=std_logic lab=PIN2}
N -740 1330 -740 1350 {lab=0}
C {devices/lab_pin.sym} -740 1350 1 0 {name=l39 sig_type=std_logic lab=0}
C {devices/vsource.sym} -600 700 0 0 {name=VD3 value="1.2"}
N -600 670 -600 650 {lab=BRD3}
C {devices/lab_pin.sym} -600 650 3 0 {name=l40 sig_type=std_logic lab=BRD3}
N -600 730 -600 750 {lab=0}
C {devices/lab_pin.sym} -600 750 1 0 {name=l41 sig_type=std_logic lab=0}
C {devices/capa.sym} -540 900 0 0 {name=CPE3 value="2.5p"}
N -540 870 -540 850 {lab=BRD3}
C {devices/lab_pin.sym} -540 850 3 0 {name=l42 sig_type=std_logic lab=BRD3}
N -540 930 -540 950 {lab=0}
C {devices/lab_pin.sym} -540 950 1 0 {name=l43 sig_type=std_logic lab=0}
C {devices/res.sym} -600 1100 0 0 {name=RPA3 value="500"}
N -600 1070 -600 1050 {lab=BRD3}
C {devices/lab_pin.sym} -600 1050 3 0 {name=l44 sig_type=std_logic lab=BRD3}
N -600 1130 -600 1150 {lab=PIN3}
C {devices/lab_pin.sym} -600 1150 1 0 {name=l45 sig_type=std_logic lab=PIN3}
C {devices/capa.sym} -540 1300 0 0 {name=CPI3 value="2.5p"}
N -540 1270 -540 1250 {lab=PIN3}
C {devices/lab_pin.sym} -540 1250 3 0 {name=l46 sig_type=std_logic lab=PIN3}
N -540 1330 -540 1350 {lab=0}
C {devices/lab_pin.sym} -540 1350 1 0 {name=l47 sig_type=std_logic lab=0}
C {devices/vsource.sym} -400 700 0 0 {name=VD4 value="1.2"}
N -400 670 -400 650 {lab=BRD4}
C {devices/lab_pin.sym} -400 650 3 0 {name=l48 sig_type=std_logic lab=BRD4}
N -400 730 -400 750 {lab=0}
C {devices/lab_pin.sym} -400 750 1 0 {name=l49 sig_type=std_logic lab=0}
C {devices/capa.sym} -340 900 0 0 {name=CPE4 value="2.5p"}
N -340 870 -340 850 {lab=BRD4}
C {devices/lab_pin.sym} -340 850 3 0 {name=l50 sig_type=std_logic lab=BRD4}
N -340 930 -340 950 {lab=0}
C {devices/lab_pin.sym} -340 950 1 0 {name=l51 sig_type=std_logic lab=0}
C {devices/res.sym} -400 1100 0 0 {name=RPA4 value="500"}
N -400 1070 -400 1050 {lab=BRD4}
C {devices/lab_pin.sym} -400 1050 3 0 {name=l52 sig_type=std_logic lab=BRD4}
N -400 1130 -400 1150 {lab=PIN4}
C {devices/lab_pin.sym} -400 1150 1 0 {name=l53 sig_type=std_logic lab=PIN4}
C {devices/capa.sym} -340 1300 0 0 {name=CPI4 value="2.5p"}
N -340 1270 -340 1250 {lab=PIN4}
C {devices/lab_pin.sym} -340 1250 3 0 {name=l54 sig_type=std_logic lab=PIN4}
N -340 1330 -340 1350 {lab=0}
C {devices/lab_pin.sym} -340 1350 1 0 {name=l55 sig_type=std_logic lab=0}
C {devices/vsource.sym} -200 700 0 0 {name=VH value="0"}
N -200 670 -200 650 {lab=BRD5}
C {devices/lab_pin.sym} -200 650 3 0 {name=l56 sig_type=std_logic lab=BRD5}
N -200 730 -200 750 {lab=0}
C {devices/lab_pin.sym} -200 750 1 0 {name=l57 sig_type=std_logic lab=0}
C {devices/capa.sym} -140 900 0 0 {name=CPE5 value="2.5p"}
N -140 870 -140 850 {lab=BRD5}
C {devices/lab_pin.sym} -140 850 3 0 {name=l58 sig_type=std_logic lab=BRD5}
N -140 930 -140 950 {lab=0}
C {devices/lab_pin.sym} -140 950 1 0 {name=l59 sig_type=std_logic lab=0}
C {devices/res.sym} -200 1100 0 0 {name=RPA5 value="500"}
N -200 1070 -200 1050 {lab=BRD5}
C {devices/lab_pin.sym} -200 1050 3 0 {name=l60 sig_type=std_logic lab=BRD5}
N -200 1130 -200 1150 {lab=PIN5}
C {devices/lab_pin.sym} -200 1150 1 0 {name=l61 sig_type=std_logic lab=PIN5}
C {devices/capa.sym} -140 1300 0 0 {name=CPI5 value="2.5p"}
N -140 1270 -140 1250 {lab=PIN5}
C {devices/lab_pin.sym} -140 1250 3 0 {name=l62 sig_type=std_logic lab=PIN5}
N -140 1330 -140 1350 {lab=0}
C {devices/lab_pin.sym} -140 1350 1 0 {name=l63 sig_type=std_logic lab=0}
T {TT analog pin model per pin: BRDk (board) - 2.5 pF - 500 ohm - 2.5 pF - PINk (= ua[k]).  ua0: 10 uA forced; ua1 = ua2 = 1.0 V; ua3 = ua4 = 1.2 V (drain ammeters VD3, VD4); ua5 = 0 V (heater off)} -1260 560 0 0 0.3 0.3 {}
C {devices/vsource.sym} 1200 -600 0 0 {name=VCLK value="PULSE(0 1.8 0 1n 1n 49n 100n)"}
N 1200 -630 1200 -650 {lab=CLK}
C {devices/lab_pin.sym} 1200 -650 3 0 {name=l64 sig_type=std_logic lab=CLK}
N 1200 -570 1200 -550 {lab=0}
C {devices/lab_pin.sym} 1200 -550 1 0 {name=l65 sig_type=std_logic lab=0}
C {devices/vsource.sym} 1360 -600 0 0 {name=VRST value="PWL(0 0 300n 0 301n 1.8)"}
N 1360 -630 1360 -650 {lab=RST_N}
C {devices/lab_pin.sym} 1360 -650 3 0 {name=l66 sig_type=std_logic lab=RST_N}
N 1360 -570 1360 -550 {lab=0}
C {devices/lab_pin.sym} 1360 -550 1 0 {name=l67 sig_type=std_logic lab=0}
C {devices/vsource.sym} 1520 -600 0 0 {name=VENA value="PWL(0 1.8 4.5u 1.8 4.501u 0)"}
N 1520 -630 1520 -650 {lab=ENA}
C {devices/lab_pin.sym} 1520 -650 3 0 {name=l68 sig_type=std_logic lab=ENA}
N 1520 -570 1520 -550 {lab=0}
C {devices/lab_pin.sym} 1520 -550 1 0 {name=l69 sig_type=std_logic lab=0}
C {devices/vsource.sym} 1680 -600 0 0 {name=VU7 value="PWL(0 0 800n 0 801n 1.8 1.3u 1.8 1.301u 0)"}
N 1680 -630 1680 -650 {lab=UI7}
C {devices/lab_pin.sym} 1680 -650 3 0 {name=l70 sig_type=std_logic lab=UI7}
N 1680 -570 1680 -550 {lab=0}
C {devices/lab_pin.sym} 1680 -550 1 0 {name=l71 sig_type=std_logic lab=0}
C {devices/vsource.sym} 1840 -600 0 0 {name=VU6 value="0"}
N 1840 -630 1840 -650 {lab=UI6}
C {devices/lab_pin.sym} 1840 -650 3 0 {name=l72 sig_type=std_logic lab=UI6}
N 1840 -570 1840 -550 {lab=0}
C {devices/lab_pin.sym} 1840 -550 1 0 {name=l73 sig_type=std_logic lab=0}
C {devices/vsource.sym} 2000 -600 0 0 {name=VU5 value="0"}
N 2000 -630 2000 -650 {lab=UI5}
C {devices/lab_pin.sym} 2000 -650 3 0 {name=l74 sig_type=std_logic lab=UI5}
N 2000 -570 2000 -550 {lab=0}
C {devices/lab_pin.sym} 2000 -550 1 0 {name=l75 sig_type=std_logic lab=0}
C {devices/vsource.sym} 2160 -600 0 0 {name=VU4 value="0"}
N 2160 -630 2160 -650 {lab=UI4}
C {devices/lab_pin.sym} 2160 -650 3 0 {name=l76 sig_type=std_logic lab=UI4}
N 2160 -570 2160 -550 {lab=0}
C {devices/lab_pin.sym} 2160 -550 1 0 {name=l77 sig_type=std_logic lab=0}
C {devices/vsource.sym} 2320 -600 0 0 {name=VU3 value="0"}
N 2320 -630 2320 -650 {lab=UI3}
C {devices/lab_pin.sym} 2320 -650 3 0 {name=l78 sig_type=std_logic lab=UI3}
N 2320 -570 2320 -550 {lab=0}
C {devices/lab_pin.sym} 2320 -550 1 0 {name=l79 sig_type=std_logic lab=0}
C {devices/vsource.sym} 2480 -600 0 0 {name=VU2 value="1.8"}
N 2480 -630 2480 -650 {lab=UI2}
C {devices/lab_pin.sym} 2480 -650 3 0 {name=l80 sig_type=std_logic lab=UI2}
N 2480 -570 2480 -550 {lab=0}
C {devices/lab_pin.sym} 2480 -550 1 0 {name=l81 sig_type=std_logic lab=0}
C {devices/vsource.sym} 2640 -600 0 0 {name=VU1 value="1.8"}
N 2640 -630 2640 -650 {lab=UI1}
C {devices/lab_pin.sym} 2640 -650 3 0 {name=l82 sig_type=std_logic lab=UI1}
N 2640 -570 2640 -550 {lab=0}
C {devices/lab_pin.sym} 2640 -550 1 0 {name=l83 sig_type=std_logic lab=0}
C {devices/vsource.sym} 1200 -340 0 0 {name=VU0 value="0"}
N 1200 -370 1200 -390 {lab=UI0}
C {devices/lab_pin.sym} 1200 -390 3 0 {name=l84 sig_type=std_logic lab=UI0}
N 1200 -310 1200 -290 {lab=0}
C {devices/lab_pin.sym} 1200 -290 1 0 {name=l85 sig_type=std_logic lab=0}
C {devices/vsource.sym} 1360 -340 0 0 {name=VUI0 value="0"}
N 1360 -370 1360 -390 {lab=UIOI0}
C {devices/lab_pin.sym} 1360 -390 3 0 {name=l86 sig_type=std_logic lab=UIOI0}
N 1360 -310 1360 -290 {lab=0}
C {devices/lab_pin.sym} 1360 -290 1 0 {name=l87 sig_type=std_logic lab=0}
C {devices/vsource.sym} 1520 -340 0 0 {name=VUI1 value="0"}
N 1520 -370 1520 -390 {lab=UIOI1}
C {devices/lab_pin.sym} 1520 -390 3 0 {name=l88 sig_type=std_logic lab=UIOI1}
N 1520 -310 1520 -290 {lab=0}
C {devices/lab_pin.sym} 1520 -290 1 0 {name=l89 sig_type=std_logic lab=0}
C {devices/vsource.sym} 1680 -340 0 0 {name=VUI2 value="0"}
N 1680 -370 1680 -390 {lab=UIOI2}
C {devices/lab_pin.sym} 1680 -390 3 0 {name=l90 sig_type=std_logic lab=UIOI2}
N 1680 -310 1680 -290 {lab=0}
C {devices/lab_pin.sym} 1680 -290 1 0 {name=l91 sig_type=std_logic lab=0}
C {devices/vsource.sym} 1840 -340 0 0 {name=VUI3 value="0"}
N 1840 -370 1840 -390 {lab=UIOI3}
C {devices/lab_pin.sym} 1840 -390 3 0 {name=l92 sig_type=std_logic lab=UIOI3}
N 1840 -310 1840 -290 {lab=0}
C {devices/lab_pin.sym} 1840 -290 1 0 {name=l93 sig_type=std_logic lab=0}
C {devices/vsource.sym} 2000 -340 0 0 {name=VUI4 value="0"}
N 2000 -370 2000 -390 {lab=UIOI4}
C {devices/lab_pin.sym} 2000 -390 3 0 {name=l94 sig_type=std_logic lab=UIOI4}
N 2000 -310 2000 -290 {lab=0}
C {devices/lab_pin.sym} 2000 -290 1 0 {name=l95 sig_type=std_logic lab=0}
C {devices/vsource.sym} 2160 -340 0 0 {name=VUI5 value="0"}
N 2160 -370 2160 -390 {lab=UIOI5}
C {devices/lab_pin.sym} 2160 -390 3 0 {name=l96 sig_type=std_logic lab=UIOI5}
N 2160 -310 2160 -290 {lab=0}
C {devices/lab_pin.sym} 2160 -290 1 0 {name=l97 sig_type=std_logic lab=0}
C {devices/vsource.sym} 2320 -340 0 0 {name=VUI6 value="0"}
N 2320 -370 2320 -390 {lab=UIOI6}
C {devices/lab_pin.sym} 2320 -390 3 0 {name=l98 sig_type=std_logic lab=UIOI6}
N 2320 -310 2320 -290 {lab=0}
C {devices/lab_pin.sym} 2320 -290 1 0 {name=l99 sig_type=std_logic lab=0}
C {devices/vsource.sym} 2480 -340 0 0 {name=VUI7 value="0"}
N 2480 -370 2480 -390 {lab=UIOI7}
C {devices/lab_pin.sym} 2480 -390 3 0 {name=l100 sig_type=std_logic lab=UIOI7}
N 2480 -310 2480 -290 {lab=0}
C {devices/lab_pin.sym} 2480 -290 1 0 {name=l101 sig_type=std_logic lab=0}
T {Digital: clk 10 MHz, reset released at 300 ns, APPLY (ui_in[7]) 0.8-1.3 us with MODE = 10 (pair), STRUCT = 1 (CC); ena dropped at 4.5 us (safe-state check). uio_in held at 0.} 1160 -760 0 0 0.3 0.3 {}
C {sky130_fd_pr/corner.sym} -1200 -1000 0 0 {name=CORNER only_toplevel=true corner=tt}
C {devices/code_shown.sym} -1200 -900 0 0 {name=s1 only_toplevel=false value=".option method=gear
.control
tran 2n 5.5u
let id3 = -i(VD3)
let id4 = -i(VD4)
meas tran t_busy   when v(UO1)=0.9 rise=1
meas tran t_active when v(UO0)=0.9 rise=1
meas tran t_safe   when v(UO0)=0.9 fall=1
meas tran i3_on    avg id3 from=3.5u to=4.4u
meas tran i4_on    avg id4 from=3.5u to=4.4u
let di = id3 - id4
meas tran di_on    avg di  from=3.5u to=4.4u
meas tran vbias_on avg v(PIN0) from=3.5u to=4.4u
meas tran i3_off   avg id3 from=5.2u to=5.5u
meas tran mode1    find v(UO3) at=4u
meas tran mode0    find v(UO2) at=4u
meas tran struct   find v(UO4) at=4u
meas tran heat_on  find v(UO5) at=4u
meas tran err      find v(UO7) at=4u
meas tran uio_max  max v(UIOO3) from=1u to=5u
meas tran oe_max   max v(OE5)   from=1u to=5u
write tb_top.raw v(UO0) v(UO1) v(UI7) v(PIN0) id3 id4
.endc"}
T {tb_tt_um_epicalopensource_elad1: whole chip, transistor level. Pass/fail limits in cells/tt_um_epicalopensource_elad1/sim/specs.txt} -1260 -1200 0 0 0.6 0.6 {}
