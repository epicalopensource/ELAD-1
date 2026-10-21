v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {ELAD1_ANALOG_SELECTOR.sym} 580 0 0 0 {name=XSEL}
C {ELAD1_MIRROR_GROUPED.sym} 1000 0 0 0 {name=XMIR_G}
C {ELAD1_MIRROR_CC.sym} 1400 0 0 0 {name=XMIR_C}
C {ELAD1_PAIR_GROUPED.sym} 1800 0 0 0 {name=XPAIR_G}
C {ELAD1_PAIR_CC.sym} 2200 0 0 0 {name=XPAIR_C}
C {ELAD1_VICTIM_BASELINE.sym} 2620 0 0 0 {name=XVIC_A}
C {ELAD1_VICTIM_GUARDED.sym} 3040 0 0 0 {name=XVIC_B}
C {ELAD1_AGGRESSOR.sym} 3460 0 0 0 {name=XAGG}
C {ELAD1_HEATER.sym} 3880 0 0 0 {name=XHTR}
N 680 130 700 130 {lab=VDPWR}
C {devices/lab_pin.sym} 700 130 0 1 {name=l1 sig_type=std_logic lab=VDPWR}
N 680 150 680 170 {lab=VGND}
C {devices/gnd.sym} 680 170 0 0 {name=l2 lab=VGND}
N 1080 -10 1100 -10 {lab=VGND}
C {devices/lab_pin.sym} 1100 -10 0 1 {name=l3 sig_type=std_logic lab=VGND}
N 1480 -10 1500 -10 {lab=VGND}
C {devices/lab_pin.sym} 1500 -10 0 1 {name=l4 sig_type=std_logic lab=VGND}
N 3550 -10 3570 -10 {lab=VGND}
C {devices/lab_pin.sym} 3570 -10 0 1 {name=l5 sig_type=std_logic lab=VGND}
N 3960 -10 3980 -10 {lab=VGND}
C {devices/lab_pin.sym} 3980 -10 0 1 {name=l6 sig_type=std_logic lab=VGND}
N 1880 20 1900 20 {lab=VGND}
C {devices/lab_pin.sym} 1900 20 0 1 {name=l7 sig_type=std_logic lab=VGND}
N 2280 20 2300 20 {lab=VGND}
C {devices/lab_pin.sym} 2300 20 0 1 {name=l8 sig_type=std_logic lab=VGND}
N 2530 20 2510 20 {lab=VDPWR}
C {devices/lab_pin.sym} 2510 20 0 0 {name=l9 sig_type=std_logic lab=VDPWR}
N 2950 20 2930 20 {lab=VDPWR}
C {devices/lab_pin.sym} 2930 20 0 0 {name=l10 sig_type=std_logic lab=VDPWR}
N 2710 -20 2730 -20 {lab=VGND}
C {devices/lab_pin.sym} 2730 -20 0 1 {name=l11 sig_type=std_logic lab=VGND}
N 3130 -20 3150 -20 {lab=VGND}
C {devices/lab_pin.sym} 3150 -20 0 1 {name=l12 sig_type=std_logic lab=VGND}
N 2710 0 2730 0 {lab=VGND}
C {devices/lab_pin.sym} 2730 0 0 1 {name=l13 sig_type=std_logic lab=VGND}
N 3130 0 3150 0 {lab=VGND}
C {devices/lab_pin.sym} 3150 0 0 1 {name=l14 sig_type=std_logic lab=VGND}
N 3370 10 3350 10 {lab=VDPWR}
C {devices/lab_pin.sym} 3350 10 0 0 {name=l15 sig_type=std_logic lab=VDPWR}
N 480 -170 480 -190 {lab=UA0}
N 480 -190 460 -190 {lab=UA0}
N 460 -190 460 -130 {lab=UA0}
N 400 -130 460 -130 {lab=UA0}
N 480 -150 440 -150 {lab=UA1}
C {devices/lab_pin.sym} 440 -150 0 0 {name=l17 sig_type=std_logic lab=UA1}
C {devices/lab_pin.sym} 480 -130 0 0 {name=l18 sig_type=std_logic lab=UA2}
N 420 -110 480 -110 {lab=UA3}
N 480 -90 460 -90 {lab=UA4}
N 400 -90 460 -90 {lab=UA4}
N 680 -70 700 -70 {lab=EN_MG}
N 700 -70 760 -70 {lab=EN_MG}
N 680 -50 700 -50 {lab=EN_MC}
N 700 -50 760 -50 {lab=EN_MC}
N 680 -30 700 -30 {lab=EN_PG}
N 700 -30 760 -30 {lab=EN_PG}
N 680 -10 700 -10 {lab=EN_PC}
N 700 -10 760 -10 {lab=EN_PC}
N 680 10 700 10 {lab=EN_N}
N 700 10 760 10 {lab=EN_N}
N 680 30 700 30 {lab=CLR_MG}
N 700 30 760 30 {lab=CLR_MG}
N 680 50 700 50 {lab=CLR_MC}
N 700 50 760 50 {lab=CLR_MC}
N 680 70 700 70 {lab=CLR_PG}
N 700 70 760 70 {lab=CLR_PG}
N 680 90 700 90 {lab=CLR_PC}
N 700 90 760 90 {lab=CLR_PC}
N 680 110 740 110 {lab=CLR_N}
N 3370 -10 3350 -10 {lab=AGG_CLK}
N 3290 -10 3350 -10 {lab=AGG_CLK}
N 3800 -10 3780 -10 {lab=UA5}
N 3720 -10 3780 -10 {lab=UA5}
N 3800 10 3780 10 {lab=HEN}
N 3720 10 3780 10 {lab=HEN}
N 480 -70 460 -70 {lab=REF_G}
C {devices/lab_pin.sym} 460 -70 0 0 {name=l34 sig_type=std_logic lab=REF_G}
N 920 -10 900 -10 {lab=REF_G}
C {devices/lab_pin.sym} 900 -10 0 0 {name=l35 sig_type=std_logic lab=REF_G}
N 480 -50 460 -50 {lab=OUT_G}
C {devices/lab_pin.sym} 460 -50 0 0 {name=l36 sig_type=std_logic lab=OUT_G}
N 920 10 900 10 {lab=OUT_G}
C {devices/lab_pin.sym} 900 10 0 0 {name=l37 sig_type=std_logic lab=OUT_G}
N 480 -30 460 -30 {lab=REF_C}
C {devices/lab_pin.sym} 460 -30 0 0 {name=l38 sig_type=std_logic lab=REF_C}
N 1320 -10 1300 -10 {lab=REF_C}
C {devices/lab_pin.sym} 1300 -10 0 0 {name=l39 sig_type=std_logic lab=REF_C}
N 480 -10 460 -10 {lab=OUT_C}
C {devices/lab_pin.sym} 460 -10 0 0 {name=l40 sig_type=std_logic lab=OUT_C}
N 1320 10 1300 10 {lab=OUT_C}
C {devices/lab_pin.sym} 1300 10 0 0 {name=l41 sig_type=std_logic lab=OUT_C}
N 480 30 460 30 {lab=VINP_G}
C {devices/lab_pin.sym} 460 30 0 0 {name=l42 sig_type=std_logic lab=VINP_G}
N 1720 -20 1700 -20 {lab=VINP_G}
C {devices/lab_pin.sym} 1700 -20 0 0 {name=l43 sig_type=std_logic lab=VINP_G}
N 480 50 460 50 {lab=VINM_G}
C {devices/lab_pin.sym} 460 50 0 0 {name=l44 sig_type=std_logic lab=VINM_G}
N 1720 0 1700 0 {lab=VINM_G}
C {devices/lab_pin.sym} 1700 0 0 0 {name=l45 sig_type=std_logic lab=VINM_G}
N 480 70 460 70 {lab=D1_G}
C {devices/lab_pin.sym} 460 70 0 0 {name=l46 sig_type=std_logic lab=D1_G}
N 1720 20 1700 20 {lab=D1_G}
C {devices/lab_pin.sym} 1700 20 0 0 {name=l47 sig_type=std_logic lab=D1_G}
N 480 10 460 10 {lab=VBIAS_G}
C {devices/lab_pin.sym} 460 10 0 0 {name=l48 sig_type=std_logic lab=VBIAS_G}
N 1880 0 1900 0 {lab=VBIAS_G}
C {devices/lab_pin.sym} 1900 0 0 1 {name=l49 sig_type=std_logic lab=VBIAS_G}
N 480 90 460 90 {lab=D2_G}
C {devices/lab_pin.sym} 460 90 0 0 {name=l50 sig_type=std_logic lab=D2_G}
N 1880 -20 1900 -20 {lab=D2_G}
C {devices/lab_pin.sym} 1900 -20 0 1 {name=l51 sig_type=std_logic lab=D2_G}
N 680 -170 680 -190 {lab=D2_C}
N 680 -190 700 -190 {lab=D2_C}
N 700 -190 700 -90 {lab=D2_C}
N 2280 -20 2300 -20 {lab=D2_C}
N 2300 -20 2300 -90 {lab=D2_C}
N 700 -90 2300 -90 {lab=D2_C}
C {devices/lab_pin.sym} 700 -90 0 0 {name=l52 sig_type=std_logic lab=D2_C}
N 480 130 460 130 {lab=VINP_C}
C {devices/lab_pin.sym} 460 130 0 0 {name=l53 sig_type=std_logic lab=VINP_C}
N 2120 -20 2100 -20 {lab=VINP_C}
C {devices/lab_pin.sym} 2100 -20 0 0 {name=l54 sig_type=std_logic lab=VINP_C}
N 480 150 460 150 {lab=VINM_C}
C {devices/lab_pin.sym} 460 150 0 0 {name=l55 sig_type=std_logic lab=VINM_C}
N 2120 0 2100 0 {lab=VINM_C}
C {devices/lab_pin.sym} 2100 0 0 0 {name=l56 sig_type=std_logic lab=VINM_C}
N 480 170 480 190 {lab=D1_C}
C {devices/lab_pin.sym} 480 190 3 0 {name=l57 sig_type=std_logic lab=D1_C}
N 2120 20 2100 20 {lab=D1_C}
C {devices/lab_pin.sym} 2100 20 0 0 {name=l58 sig_type=std_logic lab=D1_C}
N 480 110 460 110 {lab=VBIAS_C}
C {devices/lab_pin.sym} 460 110 0 0 {name=l59 sig_type=std_logic lab=VBIAS_C}
N 2280 0 2300 0 {lab=VBIAS_C}
C {devices/lab_pin.sym} 2300 0 0 1 {name=l60 sig_type=std_logic lab=VBIAS_C}
N 2530 0 2510 0 {lab=OUT_A}
N 2510 0 2510 -110 {lab=OUT_A}
N 680 -110 2510 -110 {lab=OUT_A}
C {devices/lab_pin.sym} 680 -110 0 0 {name=l61 sig_type=std_logic lab=OUT_A}
N 680 -150 720 -150 {lab=VQUIET_A}
C {devices/lab_pin.sym} 720 -150 0 1 {name=l62 sig_type=std_logic lab=VQUIET_A}
N 2530 -20 2490 -20 {lab=VQUIET_A}
C {devices/lab_pin.sym} 2490 -20 0 0 {name=l63 sig_type=std_logic lab=VQUIET_A}
C {devices/lab_pin.sym} 680 -90 0 1 {name=l64 sig_type=std_logic lab=OUT_B}
N 2950 0 2930 0 {lab=OUT_B}
C {devices/lab_pin.sym} 2930 0 0 0 {name=l65 sig_type=std_logic lab=OUT_B}
N 2950 -20 2930 -20 {lab=VQUIET_B}
N 2930 -20 2930 -130 {lab=VQUIET_B}
N 680 -130 2930 -130 {lab=VQUIET_B}
C {devices/lab_pin.sym} 680 -130 0 0 {name=l66 sig_type=std_logic lab=VQUIET_B}
C {devices/iopin.sym} 400 -130 0 1 {name=p16 lab=UA0}
C {devices/iopin.sym} -160 -110 0 1 {name=p69 lab=UA1}
C {devices/iopin.sym} -160 -70 0 1 {name=p70 lab=UA2}
C {devices/iopin.sym} 420 -110 0 1 {name=p19 lab=UA3}
C {devices/iopin.sym} 400 -90 0 1 {name=p20 lab=UA4}
C {devices/iopin.sym} 3720 -10 0 1 {name=p32 lab=UA5}
C {devices/iopin.sym} 760 -70 0 0 {name=p21 lab=EN_MG}
C {devices/iopin.sym} 760 -50 0 0 {name=p22 lab=EN_MC}
C {devices/iopin.sym} 760 -30 0 0 {name=p23 lab=EN_PG}
C {devices/iopin.sym} 760 -10 0 0 {name=p24 lab=EN_PC}
C {devices/iopin.sym} 760 10 0 0 {name=p25 lab=EN_N}
C {devices/iopin.sym} 760 30 0 0 {name=p26 lab=CLR_MG}
C {devices/iopin.sym} 760 50 0 0 {name=p27 lab=CLR_MC}
C {devices/iopin.sym} 760 70 0 0 {name=p28 lab=CLR_PG}
C {devices/iopin.sym} 760 90 0 0 {name=p29 lab=CLR_PC}
C {devices/iopin.sym} 740 110 0 0 {name=p30 lab=CLR_N}
C {devices/iopin.sym} 3720 10 0 1 {name=p33 lab=HEN}
C {devices/iopin.sym} 3290 -10 0 1 {name=p31 lab=AGG_CLK}
C {devices/iopin.sym} -160 -190 0 1 {name=p67 lab=VDPWR}
C {devices/iopin.sym} -160 -150 0 1 {name=p68 lab=VGND}
