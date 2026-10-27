v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -500 -480 -240 -480 {}
N -500 -360 -240 -360 {}
N -500 -240 -240 -240 {}
N -500 -120 -240 -120 {}
N -500 0 -240 0 {}
N 240 -560 430 -560 {}
N 430 -560 620 -560 {}
N 240 -520 430 -520 {}
N 430 -520 620 -520 {}
N 240 -400 430 -400 {}
N 430 -400 620 -400 {}
N 240 -360 430 -360 {}
N 430 -360 620 -360 {}
N 240 -240 430 -240 {}
N 430 -240 620 -240 {}
N 240 -200 430 -200 {}
N 430 -200 620 -200 {}
N 240 -160 430 -160 {}
N 430 -160 620 -160 {}
N 240 -120 430 -120 {}
N 430 -120 620 -120 {}
N 240 -80 430 -80 {}
N 430 -80 620 -80 {}
N 240 40 430 40 {}
N 430 40 620 40 {}
N 240 80 430 80 {}
N 430 80 620 80 {}
N 240 120 430 120 {}
N 430 120 620 120 {}
N 240 160 430 160 {}
N 430 160 620 160 {}
N 240 200 430 200 {}
N 430 200 620 200 {}
N 240 320 580 320 {}
N 580 320 920 320 {}
N 240 360 580 360 {}
N 580 360 920 360 {}
N 240 480 730 480 {}
N 730 480 1220 480 {}
N 240 520 730 520 {}
N 730 520 1220 520 {}
N -200 740 -200 860 {}
N -160 740 -160 860 {}
N -120 740 -120 860 {}
N -80 740 -80 860 {}
N -40 740 -40 860 {}
N 0 740 0 860 {}
N 40 740 40 860 {}
N 80 740 80 860 {}
N 120 740 120 860 {}
N 160 740 160 860 {}
N -500 1040 620 1040 {}
N -500 1080 620 1080 {}
N -500 1260 600 1260 {}
N 540 1300 600 1300 {}
N 800 1280 860 1280 {}
N 240 640 400 640 {}
N -500 1480 -400 1480 {}
N -500 1560 -400 1560 {}
C {devices/iopin.sym} -500 -480 0 1 {name=p1 lab=UA0}
C {devices/iopin.sym} -500 -360 0 1 {name=p2 lab=UA1}
C {devices/iopin.sym} -500 -240 0 1 {name=p3 lab=UA2}
C {devices/iopin.sym} -500 -120 0 1 {name=p4 lab=UA3}
C {devices/iopin.sym} -500 0 0 1 {name=p5 lab=UA4}
C {devices/iopin.sym} -500 1040 0 1 {name=p36 lab=UA5}
C {devices/iopin.sym} -200 860 1 0 {name=p_EN_MG lab=EN_MG}
C {devices/iopin.sym} -160 860 1 0 {name=p_EN_MC lab=EN_MC}
C {devices/iopin.sym} -120 860 1 0 {name=p_EN_PG lab=EN_PG}
C {devices/iopin.sym} -80 860 1 0 {name=p_EN_PC lab=EN_PC}
C {devices/iopin.sym} -40 860 1 0 {name=p_EN_N lab=EN_N}
C {devices/iopin.sym} 0 860 1 0 {name=p_CLR_MG lab=CLR_MG}
C {devices/iopin.sym} 40 860 1 0 {name=p_CLR_MC lab=CLR_MC}
C {devices/iopin.sym} 80 860 1 0 {name=p_CLR_PG lab=CLR_PG}
C {devices/iopin.sym} 120 860 1 0 {name=p_CLR_PC lab=CLR_PC}
C {devices/iopin.sym} 160 860 1 0 {name=p_CLR_N lab=CLR_N}
C {devices/iopin.sym} -500 1080 0 1 {name=p37 lab=HEN}
C {devices/iopin.sym} -500 1260 0 1 {name=p39 lab=AGG_CLK}
C {devices/iopin.sym} -500 1480 0 1 {name=p45 lab=VDPWR}
C {devices/iopin.sym} -500 1560 0 1 {name=p47 lab=VGND}
C {ELAD1_ANALOG_SELECTOR.sym} 0 0 0 0 {name=XSEL}
C {devices/vdd.sym} 0 -620 0 0 {name=l6 lab=VDPWR global=false}
C {devices/gnd.sym} 200 740 0 0 {name=l7 lab=VGND global=false}
C {ELAD1_MIRROR_GROUPED.sym} 700 -540 0 0 {name=XMIR_G}
C {devices/lab_pin.sym} 430 -560 0 1 {name=l8 sig_type=std_logic lab=REF_G}
C {devices/lab_pin.sym} 430 -520 0 1 {name=l9 sig_type=std_logic lab=OUT_G}
C {devices/gnd.sym} 700 -480 0 0 {name=l10 lab=VGND global=false}
C {ELAD1_MIRROR_CC.sym} 700 -380 0 0 {name=XMIR_C}
C {devices/lab_pin.sym} 430 -400 0 1 {name=l11 sig_type=std_logic lab=REF_C}
C {devices/lab_pin.sym} 430 -360 0 1 {name=l12 sig_type=std_logic lab=OUT_C}
C {devices/gnd.sym} 700 -320 0 0 {name=l13 lab=VGND global=false}
C {ELAD1_PAIR_GROUPED.sym} 700 -160 0 0 {name=XPAIR_G}
C {devices/lab_pin.sym} 430 -240 0 1 {name=l14 sig_type=std_logic lab=VBIAS_G}
C {devices/lab_pin.sym} 430 -200 0 1 {name=l15 sig_type=std_logic lab=VINP_G}
C {devices/lab_pin.sym} 430 -160 0 1 {name=l16 sig_type=std_logic lab=VINM_G}
C {devices/lab_pin.sym} 430 -120 0 1 {name=l17 sig_type=std_logic lab=D1_G}
C {devices/lab_pin.sym} 430 -80 0 1 {name=l18 sig_type=std_logic lab=D2_G}
C {devices/gnd.sym} 700 -40 0 0 {name=l19 lab=VGND global=false}
C {ELAD1_PAIR_CC.sym} 700 120 0 0 {name=XPAIR_C}
C {devices/lab_pin.sym} 430 40 0 1 {name=l20 sig_type=std_logic lab=VBIAS_C}
C {devices/lab_pin.sym} 430 80 0 1 {name=l21 sig_type=std_logic lab=VINP_C}
C {devices/lab_pin.sym} 430 120 0 1 {name=l22 sig_type=std_logic lab=VINM_C}
C {devices/lab_pin.sym} 430 160 0 1 {name=l23 sig_type=std_logic lab=D1_C}
C {devices/lab_pin.sym} 430 200 0 1 {name=l24 sig_type=std_logic lab=D2_C}
C {devices/gnd.sym} 700 240 0 0 {name=l25 lab=VGND global=false}
C {ELAD1_VICTIM_BASELINE.sym} 1000 340 0 0 {name=XVIC_A}
C {devices/lab_pin.sym} 580 320 0 1 {name=l26 sig_type=std_logic lab=VQUIET_A}
C {devices/lab_pin.sym} 580 360 0 1 {name=l27 sig_type=std_logic lab=OUT_A}
C {devices/gnd.sym} 980 400 0 0 {name=l28 lab=VGND global=false}
C {devices/gnd.sym} 1020 400 0 0 {name=l29 lab=VGND global=false}
C {devices/vdd.sym} 1000 280 0 0 {name=l30 lab=VDPWR global=false}
C {ELAD1_VICTIM_GUARDED.sym} 1300 500 0 0 {name=XVIC_B}
C {devices/lab_pin.sym} 730 480 0 1 {name=l31 sig_type=std_logic lab=VQUIET_B}
C {devices/lab_pin.sym} 730 520 0 1 {name=l32 sig_type=std_logic lab=OUT_B}
C {devices/gnd.sym} 1280 560 0 0 {name=l33 lab=VGND global=false}
C {devices/gnd.sym} 1320 560 0 0 {name=l34 lab=VGND global=false}
C {devices/vdd.sym} 1300 440 0 0 {name=l35 lab=VDPWR global=false}
C {ELAD1_HEATER.sym} 700 1060 0 0 {name=XHTR}
C {devices/gnd.sym} 700 1120 0 0 {name=l38 lab=VGND global=false}
C {ELAD1_AGGRESSOR.sym} 700 1280 0 0 {name=XAGG}
C {devices/vdd.sym} 700 1220 0 0 {name=l40 lab=VDPWR global=false}
C {devices/gnd.sym} 700 1340 0 0 {name=l41 lab=VGND global=false}
C {devices/lab_pin.sym} 540 1300 0 0 {name=l42 sig_type=std_logic lab=EN_N}
C {devices/lab_pin.sym} 860 1280 0 1 {name=l43 sig_type=std_logic lab=SUBI}
C {devices/lab_pin.sym} 400 640 0 1 {name=l44 sig_type=std_logic lab=SUBI}
C {devices/vdd.sym} -400 1480 0 0 {name=l46 lab=VDPWR global=false}
C {devices/gnd.sym} -400 1560 0 0 {name=l48 lab=VGND global=false}
T {ELAD1_ANALOG_CORE: everything except the digital controller} -500 -790 0 0 0.45 0.45 {}
T {UA0-UA4 reach the test structures through the selector; UA5 drives the heater. EN/CLR/HEN/AGG_CLK come from ELAD1_CONTROL.
SUBI: shared substrate tap island - driven by ua0 (force) / read by ua2 (sense) and by the aggressor, noise mode only.} -500 -740 0 0 0.25 0.25 {}
