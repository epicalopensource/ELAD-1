v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -280 680 -260 680 {}
N -260 680 -240 680 {}
N -400 680 -400 700 {}
N -400 680 -280 680 {}
N -460 560 -350 560 {}
N -350 560 -240 560 {}
N -520 440 -380 440 {}
N -380 440 -240 440 {}
N -580 320 -410 320 {}
N -410 320 -240 320 {}
N -640 200 -440 200 {}
N -440 200 -240 200 {}
N -760 200 -760 220 {}
N -760 200 -640 200 {}
N 240 1200 260 1200 {}
N 260 1200 280 1200 {}
N 240 1160 290 1160 {}
N 290 1160 340 1160 {}
N 240 1040 320 1040 {}
N 320 1040 400 1040 {}
N 240 1000 350 1000 {}
N 350 1000 460 1000 {}
N 240 880 380 880 {}
N 380 880 520 880 {}
N 240 840 410 840 {}
N 410 840 580 840 {}
N 240 800 440 800 {}
N 440 800 640 800 {}
N 240 760 470 760 {}
N 470 760 700 760 {}
N 240 720 500 720 {}
N 500 720 760 720 {}
N 240 600 530 600 {}
N 530 600 820 600 {}
N 240 560 560 560 {}
N 560 560 880 560 {}
N 240 520 590 520 {}
N 590 520 940 520 {}
N 240 480 620 480 {}
N 620 480 1000 480 {}
N 240 440 650 440 {}
N 650 440 1060 440 {}
N 240 320 680 320 {}
N 680 320 1120 320 {}
N 240 280 710 280 {}
N 710 280 1180 280 {}
N 1300 260 1300 280 {}
N 1180 280 1300 280 {}
N 240 160 800 160 {}
N 800 160 1360 160 {}
N 1480 160 1480 180 {}
N 1360 160 1480 160 {}
N 240 120 890 120 {}
N 890 120 1540 120 {}
N 1660 120 1660 140 {}
N 1540 120 1660 120 {}
N -200 1300 -200 1320 {}
N 0 1300 0 1320 {}
N 40 1300 40 1320 {}
N 80 1300 80 1320 {}
N 120 1300 120 1320 {}
N 160 1300 160 1320 {}
N -640 1470 -640 1490 {}
N -760 1470 -640 1470 {}
N -380 1470 -380 1490 {}
N -500 1470 -380 1470 {}
N -120 1470 -120 1490 {}
N -240 1470 -120 1470 {}
N 140 1470 140 1490 {}
N 20 1470 140 1470 {}
N 400 1470 400 1490 {}
N 280 1470 400 1470 {}
N 660 1470 660 1490 {}
N 540 1470 660 1470 {}
N 920 1470 920 1490 {}
N 800 1470 920 1470 {}
C {ELAD1_ANALOG_SELECTOR.sym} 0 680 0 0 {name=XDUT}
C {devices/lab_pin.sym} -260 680 0 0 {name=l1 sig_type=std_logic lab=UA4}
C {devices/vsource.sym} -400 730 0 0 {name=VUA4 value=0.7}
C {devices/gnd.sym} -400 760 0 0 {name=l2 lab=0 global=false}
C {devices/lab_pin.sym} -350 560 0 0 {name=l3 sig_type=std_logic lab=UA3}
C {devices/lab_pin.sym} -380 440 0 0 {name=l4 sig_type=std_logic lab=UA2}
C {devices/lab_pin.sym} -410 320 0 0 {name=l5 sig_type=std_logic lab=UA1}
C {devices/lab_pin.sym} -440 200 0 0 {name=l6 sig_type=std_logic lab=UA0}
C {devices/vsource.sym} -760 250 0 0 {name=VUA0 value=0.7}
C {devices/gnd.sym} -760 280 0 0 {name=l7 lab=0 global=false}
C {devices/lab_pin.sym} 260 1200 0 1 {name=l8 sig_type=std_logic lab=OUT_B}
C {devices/lab_pin.sym} 290 1160 0 1 {name=l9 sig_type=std_logic lab=VQUIET_B}
C {devices/lab_pin.sym} 320 1040 0 1 {name=l10 sig_type=std_logic lab=OUT_A}
C {devices/lab_pin.sym} 350 1000 0 1 {name=l11 sig_type=std_logic lab=VQUIET_A}
C {devices/lab_pin.sym} 380 880 0 1 {name=l12 sig_type=std_logic lab=D2_C}
C {devices/lab_pin.sym} 410 840 0 1 {name=l13 sig_type=std_logic lab=D1_C}
C {devices/lab_pin.sym} 440 800 0 1 {name=l14 sig_type=std_logic lab=VINM_C}
C {devices/lab_pin.sym} 470 760 0 1 {name=l15 sig_type=std_logic lab=VINP_C}
C {devices/lab_pin.sym} 500 720 0 1 {name=l16 sig_type=std_logic lab=VBIAS_C}
C {devices/lab_pin.sym} 530 600 0 1 {name=l17 sig_type=std_logic lab=D2_G}
C {devices/lab_pin.sym} 560 560 0 1 {name=l18 sig_type=std_logic lab=D1_G}
C {devices/lab_pin.sym} 590 520 0 1 {name=l19 sig_type=std_logic lab=VINM_G}
C {devices/lab_pin.sym} 620 480 0 1 {name=l20 sig_type=std_logic lab=VINP_G}
C {devices/lab_pin.sym} 650 440 0 1 {name=l21 sig_type=std_logic lab=VBIAS_G}
C {devices/lab_pin.sym} 680 320 0 1 {name=l22 sig_type=std_logic lab=OUT_C}
C {devices/lab_pin.sym} 710 280 0 1 {name=l23 sig_type=std_logic lab=REF_C}
C {devices/res.sym} 1300 230 0 0 {name=RPU value=1meg}
C {devices/vdd.sym} 1300 200 0 0 {name=l24 lab=VDPWR global=false}
C {devices/lab_pin.sym} 800 160 0 1 {name=l25 sig_type=std_logic lab=OUT_G}
C {devices/isource.sym} 1480 210 0 0 {name=ISINK4 value=10u}
C {devices/gnd.sym} 1480 240 0 0 {name=l26 lab=0 global=false}
C {devices/lab_pin.sym} 890 120 0 1 {name=l27 sig_type=std_logic lab=REF_G}
C {devices/isource.sym} 1660 170 0 0 {name=ISINK0 value=10u}
C {devices/gnd.sym} 1660 200 0 0 {name=l28 lab=0 global=false}
C {devices/vdd.sym} 0 60 0 0 {name=l29 lab=VDPWR global=false}
C {devices/lab_pin.sym} -200 1320 1 1 {name=l30 sig_type=std_logic lab=EN_MG}
C {devices/gnd.sym} -160 1300 0 0 {name=l31 lab=0 global=false}
C {devices/gnd.sym} -120 1300 0 0 {name=l32 lab=0 global=false}
C {devices/gnd.sym} -80 1300 0 0 {name=l33 lab=0 global=false}
C {devices/gnd.sym} -40 1300 0 0 {name=l34 lab=0 global=false}
C {devices/lab_pin.sym} 0 1320 1 1 {name=l35 sig_type=std_logic lab=CLR_MG}
C {devices/lab_pin.sym} 40 1320 1 1 {name=l36 sig_type=std_logic lab=CLR_MC}
C {devices/lab_pin.sym} 80 1320 1 1 {name=l37 sig_type=std_logic lab=CLR_PG}
C {devices/lab_pin.sym} 120 1320 1 1 {name=l38 sig_type=std_logic lab=CLR_PC}
C {devices/lab_pin.sym} 160 1320 1 1 {name=l39 sig_type=std_logic lab=CLR_N}
C {devices/gnd.sym} 200 1300 0 0 {name=l40 lab=0 global=false}
C {devices/lab_pin.sym} -760 1470 0 0 {name=l41 sig_type=std_logic lab=EN_MG}
C {devices/vsource.sym} -640 1520 0 0 {name=VENMG value=1.8}
C {devices/gnd.sym} -640 1550 0 0 {name=l42 lab=0 global=false}
C {devices/lab_pin.sym} -500 1470 0 0 {name=l43 sig_type=std_logic lab=CLR_MG}
C {devices/vsource.sym} -380 1520 0 0 {name=VCLRMG value=0}
C {devices/gnd.sym} -380 1550 0 0 {name=l44 lab=0 global=false}
C {devices/lab_pin.sym} -240 1470 0 0 {name=l45 sig_type=std_logic lab=CLR_MC}
C {devices/vsource.sym} -120 1520 0 0 {name=VCLRMC value=1.8}
C {devices/gnd.sym} -120 1550 0 0 {name=l46 lab=0 global=false}
C {devices/lab_pin.sym} 20 1470 0 0 {name=l47 sig_type=std_logic lab=CLR_PG}
C {devices/vsource.sym} 140 1520 0 0 {name=VCLRPG value=1.8}
C {devices/gnd.sym} 140 1550 0 0 {name=l48 lab=0 global=false}
C {devices/lab_pin.sym} 280 1470 0 0 {name=l49 sig_type=std_logic lab=CLR_PC}
C {devices/vsource.sym} 400 1520 0 0 {name=VCLRPC value=1.8}
C {devices/gnd.sym} 400 1550 0 0 {name=l50 lab=0 global=false}
C {devices/lab_pin.sym} 540 1470 0 0 {name=l51 sig_type=std_logic lab=CLR_N}
C {devices/vsource.sym} 660 1520 0 0 {name=VCLRN value=1.8}
C {devices/gnd.sym} 660 1550 0 0 {name=l52 lab=0 global=false}
C {devices/vdd.sym} 800 1470 0 0 {name=l53 lab=VDPWR global=false}
C {devices/vsource.sym} 920 1520 0 0 {name=VDD value=1.8}
C {devices/gnd.sym} 920 1550 0 0 {name=l54 lab=0 global=false}
T {tb_ELAD1_ANALOG_SELECTOR - switch matrix in mirror-GROUPED mode, then idle.} -800 -220 0 0 0.4 0.4 {}
T {Mirror mode (EN_MG=1, CLR_MG=0, every other CLR=1): ua0->REF_G and ua4->OUT_G carry 10 uA
each (precision TGA paths), ua3 senses REF_G and ua2 senses OUT_G (Kelvin, no current).
REF_C is pulled up by 1 Mohm: its clamp (CLR_MC=1) must hold it at VGND.
Idle (all EN=0, all CLR=1): leakage into ua0 at 0.7 V, and REF_G clamped again.
Open nodes see 1e12 ohm to ground (option rshunt) so the DC solution is defined.} -800 -175 0 0 0.22 0.22 {}
C {devices/code_shown.sym} 1860 200 0 0 {name=s1 only_toplevel=false value=".control
option rshunt=1e12
op
let ron_ua0 = (v(UA0)-v(REF_G))/10e-6
let ron_ua4 = (v(UA4)-v(OUT_G))/10e-6
let sense_err_ua3 = abs(v(UA3)-v(REF_G))
let sense_err_ua2 = abs(v(UA2)-v(OUT_G))
let v_ref_c_clamped = v(REF_C)
print ron_ua0 ron_ua4 sense_err_ua3 sense_err_ua2 v_ref_c_clamped
alter VENMG dc = 0
alter VCLRMG dc = 1.8
alter ISINK0 dc = 0
alter ISINK4 dc = 0
op
let i_idle_ua0 = abs(i(VUA0))
let v_ref_g_idle = abs(v(REF_G))
print i_idle_ua0 v_ref_g_idle
write tb_ELAD1_ANALOG_SELECTOR.raw
.endc"}
C {sky130_fd_pr/corner.sym} 1860 0 0 0 {name=CORNER only_toplevel=true corner=tt}
