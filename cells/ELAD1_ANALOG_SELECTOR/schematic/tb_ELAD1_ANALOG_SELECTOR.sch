v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/vsource.sym} 0 0 0 0 {name=VDD value=1.8}
C {devices/vsource.sym} 240 0 0 0 {name=VUA0 value=0.7}
C {devices/vsource.sym} 480 0 0 0 {name=VUA4 value=0.7}
C {devices/isource.sym} 720 0 0 0 {name=ISINK0 value=10u}
C {devices/isource.sym} 960 0 0 0 {name=ISINK4 value=10u}
C {devices/res.sym} 1200 0 0 0 {name=RPU value=1meg}
C {devices/vsource.sym} 1440 0 0 0 {name=VENMG value=1.8}
C {devices/vsource.sym} 1680 0 0 0 {name=VCLRMG value=0}
C {devices/vsource.sym} 1920 0 0 0 {name=VCLRMC value=1.8}
C {devices/vsource.sym} 2160 0 0 0 {name=VCLRPG value=1.8}
C {devices/vsource.sym} 2400 0 0 0 {name=VCLRPC value=1.8}
C {devices/vsource.sym} 2640 0 0 0 {name=VCLRN value=1.8}
C {ELAD1_ANALOG_SELECTOR.sym} 3220 0 0 0 {name=XDUT}
N 0 -70 1200 -70 {lab=VDPWR}
N 0 -30 0 -70 {lab=VDPWR}
N 1200 -30 1200 -70 {lab=VDPWR}
C {devices/vdd.sym} 0 -70 0 0 {name=l1 lab=VDPWR global=false}
N 0 70 240 70 {lab=0}
N 240 70 480 70 {lab=0}
N 480 70 720 70 {lab=0}
N 720 70 960 70 {lab=0}
N 960 70 1440 70 {lab=0}
N 1440 70 1680 70 {lab=0}
N 1680 70 1920 70 {lab=0}
N 1920 70 2160 70 {lab=0}
N 2160 70 2400 70 {lab=0}
N 2400 70 2640 70 {lab=0}
N 0 30 0 70 {lab=0}
N 240 30 240 70 {lab=0}
N 480 30 480 70 {lab=0}
N 720 30 720 70 {lab=0}
N 960 30 960 70 {lab=0}
N 1440 30 1440 70 {lab=0}
N 1680 30 1680 70 {lab=0}
N 1920 30 1920 70 {lab=0}
N 2160 30 2160 70 {lab=0}
N 2400 30 2400 70 {lab=0}
N 2640 30 2640 70 {lab=0}
C {devices/gnd.sym} 0 70 0 0 {name=l2 lab=0 global=false}
N 3320 -50 3340 -50 {lab=0}
C {devices/lab_pin.sym} 3340 -50 0 1 {name=l3 sig_type=std_logic lab=0}
N 3320 -30 3340 -30 {lab=0}
C {devices/lab_pin.sym} 3340 -30 0 1 {name=l4 sig_type=std_logic lab=0}
N 3320 -10 3340 -10 {lab=0}
C {devices/lab_pin.sym} 3340 -10 0 1 {name=l5 sig_type=std_logic lab=0}
N 3320 10 3340 10 {lab=0}
C {devices/lab_pin.sym} 3340 10 0 1 {name=l6 sig_type=std_logic lab=0}
N 3320 130 3340 130 {lab=VDPWR}
C {devices/lab_pin.sym} 3340 130 0 1 {name=l7 sig_type=std_logic lab=VDPWR}
N 3320 150 3320 170 {lab=0}
C {devices/gnd.sym} 3320 170 0 0 {name=l8 lab=0 global=false}
N 3120 -150 3100 -150 {lab=UA1}
C {devices/lab_pin.sym} 3100 -150 0 0 {name=l9 sig_type=std_logic lab=UA1}
N 3120 -130 3100 -130 {lab=UA2}
C {devices/lab_pin.sym} 3100 -130 0 0 {name=l10 sig_type=std_logic lab=UA2}
N 3120 -110 3100 -110 {lab=UA3}
C {devices/lab_pin.sym} 3100 -110 0 0 {name=l11 sig_type=std_logic lab=UA3}
N 3120 -10 3100 -10 {lab=OUT_C}
C {devices/lab_pin.sym} 3100 -10 0 0 {name=l12 sig_type=std_logic lab=OUT_C}
N 3120 10 3100 10 {lab=VBIAS_G}
C {devices/lab_pin.sym} 3100 10 0 0 {name=l13 sig_type=std_logic lab=VBIAS_G}
N 3120 30 3100 30 {lab=VINP_G}
C {devices/lab_pin.sym} 3100 30 0 0 {name=l14 sig_type=std_logic lab=VINP_G}
N 3120 50 3100 50 {lab=VINM_G}
C {devices/lab_pin.sym} 3100 50 0 0 {name=l15 sig_type=std_logic lab=VINM_G}
N 3120 70 3100 70 {lab=D1_G}
C {devices/lab_pin.sym} 3100 70 0 0 {name=l16 sig_type=std_logic lab=D1_G}
N 3120 90 3100 90 {lab=D2_G}
C {devices/lab_pin.sym} 3100 90 0 0 {name=l17 sig_type=std_logic lab=D2_G}
N 3120 110 3100 110 {lab=VBIAS_C}
C {devices/lab_pin.sym} 3100 110 0 0 {name=l18 sig_type=std_logic lab=VBIAS_C}
N 3120 130 3100 130 {lab=VINP_C}
C {devices/lab_pin.sym} 3100 130 0 0 {name=l19 sig_type=std_logic lab=VINP_C}
N 3120 150 3100 150 {lab=VINM_C}
C {devices/lab_pin.sym} 3100 150 0 0 {name=l20 sig_type=std_logic lab=VINM_C}
N 3120 170 3120 190 {lab=D1_C}
C {devices/lab_pin.sym} 3120 190 3 0 {name=l21 sig_type=std_logic lab=D1_C}
N 3320 -170 3320 -190 {lab=D2_C}
C {devices/lab_pin.sym} 3320 -190 1 0 {name=l22 sig_type=std_logic lab=D2_C}
N 3320 -150 3340 -150 {lab=VQUIET_A}
C {devices/lab_pin.sym} 3340 -150 0 1 {name=l23 sig_type=std_logic lab=VQUIET_A}
N 3320 -130 3340 -130 {lab=VQUIET_B}
C {devices/lab_pin.sym} 3340 -130 0 1 {name=l24 sig_type=std_logic lab=VQUIET_B}
N 3320 -110 3340 -110 {lab=OUT_A}
C {devices/lab_pin.sym} 3340 -110 0 1 {name=l25 sig_type=std_logic lab=OUT_A}
N 3320 -90 3340 -90 {lab=OUT_B}
C {devices/lab_pin.sym} 3340 -90 0 1 {name=l26 sig_type=std_logic lab=OUT_B}
N 2640 -30 2640 -50 {lab=CLR_N}
C {devices/lab_pin.sym} 2640 -50 1 0 {name=l27 sig_type=std_logic lab=CLR_N}
N 3320 110 3340 110 {lab=CLR_N}
C {devices/lab_pin.sym} 3340 110 0 1 {name=l28 sig_type=std_logic lab=CLR_N}
N 2400 -30 2400 -50 {lab=CLR_PC}
C {devices/lab_pin.sym} 2400 -50 1 0 {name=l29 sig_type=std_logic lab=CLR_PC}
N 3320 90 3340 90 {lab=CLR_PC}
C {devices/lab_pin.sym} 3340 90 0 1 {name=l30 sig_type=std_logic lab=CLR_PC}
N 2160 -30 2160 -50 {lab=CLR_PG}
C {devices/lab_pin.sym} 2160 -50 1 0 {name=l31 sig_type=std_logic lab=CLR_PG}
N 3320 70 3340 70 {lab=CLR_PG}
C {devices/lab_pin.sym} 3340 70 0 1 {name=l32 sig_type=std_logic lab=CLR_PG}
N 1920 -30 1920 -50 {lab=CLR_MC}
C {devices/lab_pin.sym} 1920 -50 1 0 {name=l33 sig_type=std_logic lab=CLR_MC}
N 3320 50 3340 50 {lab=CLR_MC}
C {devices/lab_pin.sym} 3340 50 0 1 {name=l34 sig_type=std_logic lab=CLR_MC}
N 1680 -30 1680 -50 {lab=CLR_MG}
C {devices/lab_pin.sym} 1680 -50 1 0 {name=l35 sig_type=std_logic lab=CLR_MG}
N 3320 30 3340 30 {lab=CLR_MG}
C {devices/lab_pin.sym} 3340 30 0 1 {name=l36 sig_type=std_logic lab=CLR_MG}
N 1440 -30 1440 -50 {lab=EN_MG}
C {devices/lab_pin.sym} 1440 -50 1 0 {name=l37 sig_type=std_logic lab=EN_MG}
N 3320 -70 3340 -70 {lab=EN_MG}
C {devices/lab_pin.sym} 3340 -70 0 1 {name=l38 sig_type=std_logic lab=EN_MG}
N 1200 30 1200 80 {lab=REF_C}
N 3120 -30 3080 -30 {lab=REF_C}
N 3080 -30 3080 80 {lab=REF_C}
N 1200 80 3080 80 {lab=REF_C}
C {devices/lab_pin.sym} 1200 80 0 0 {name=l39 sig_type=std_logic lab=REF_C}
N 960 -30 960 -80 {lab=OUT_G}
N 3120 -50 3100 -50 {lab=OUT_G}
N 3100 -50 3100 -80 {lab=OUT_G}
N 960 -80 3100 -80 {lab=OUT_G}
C {devices/lab_pin.sym} 960 -80 0 0 {name=l40 sig_type=std_logic lab=OUT_G}
N 720 -30 720 -90 {lab=REF_G}
N 3120 -70 3080 -70 {lab=REF_G}
N 3080 -70 3080 -90 {lab=REF_G}
N 720 -90 3080 -90 {lab=REF_G}
C {devices/lab_pin.sym} 720 -90 0 0 {name=l41 sig_type=std_logic lab=REF_G}
N 480 -30 480 -100 {lab=UA4}
N 3120 -90 3100 -90 {lab=UA4}
N 3100 -90 3100 -100 {lab=UA4}
N 480 -100 3100 -100 {lab=UA4}
C {devices/lab_pin.sym} 480 -100 0 0 {name=l42 sig_type=std_logic lab=UA4}
N 240 -30 240 -50 {lab=UA0}
C {devices/lab_pin.sym} 240 -50 1 0 {name=l43 sig_type=std_logic lab=UA0}
N 3120 -170 3120 -190 {lab=UA0}
C {devices/lab_pin.sym} 3120 -190 1 0 {name=l44 sig_type=std_logic lab=UA0}
C {devices/code_shown.sym} -400 -480 0 0 {name=s1 only_toplevel=false value=".control
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
C {sky130_fd_pr/corner.sym} -400 -680 0 0 {name=CORNER only_toplevel=true corner=tt}
T {tb_ELAD1_ANALOG_SELECTOR - switch matrix in mirror-GROUPED mode, then idle.
Mirror mode (EN_MG=1, CLR_MG=0, every other CLR=1): ua0->REF_G and ua4->OUT_G carry 10 uA
each (precision TGA paths), ua3 senses REF_G and ua2 senses OUT_G (Kelvin, no current).
REF_C is pulled up by 1 Mohm: its clamp (CLR_MC=1) must hold it at VGND.
Idle (all EN=0, all CLR=1): leakage into ua0 at 0.7 V, and REF_G clamped again.
Open nodes see 1e12 ohm to ground (option rshunt) so the DC solution is defined.} -400 -1050 0 0 0.4 0.4 {}
