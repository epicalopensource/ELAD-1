v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/vsource.sym} 0 0 0 0 {name=VDD value=1.8}
C {devices/vsource.sym} 240 0 0 0 {name=VHI value=1.8}
C {devices/isource.sym} 480 0 2 1 {name=IM value="DC 5u"}
C {devices/vsource.sym} 720 0 0 0 {name=VM4 value=0.63}
C {ELAD1_ANALOG_CORE.sym} 3370 0 0 0 {name=XMIR}
C {devices/isource.sym} 960 0 2 1 {name=IP value="DC 10u"}
C {devices/vsource.sym} 1200 0 0 0 {name=VP1 value=1.0}
C {devices/vsource.sym} 1440 0 0 0 {name=VP2 value=1.0}
C {devices/vsource.sym} 1680 0 0 0 {name=VP3 value=1.2}
C {devices/vsource.sym} 1920 0 0 0 {name=VP4 value=1.2}
C {ELAD1_ANALOG_CORE.sym} 3800 0 0 0 {name=XPAIR}
C {devices/vsource.sym} 2160 0 0 0 {name=VN1 value=0.771}
C {ELAD1_ANALOG_CORE.sym} 4220 0 0 0 {name=XNOI}
C {devices/vsource.sym} 2400 0 0 0 {name=VH0 value=0.9}
C {devices/vsource.sym} 2640 0 0 0 {name=VEXT value=1.8}
C {devices/res.sym} 3000 100 0 0 {name=RP value=500}
C {ELAD1_ANALOG_CORE.sym} 4640 0 0 0 {name=XHTR}
N 0 -30 0 -50 {lab=VDPWR}
C {devices/vdd.sym} 0 -50 0 0 {name=l1 lab=VDPWR global=false}
N 0 70 240 70 {lab=0}
N 240 70 480 70 {lab=0}
N 480 70 720 70 {lab=0}
N 720 70 960 70 {lab=0}
N 960 70 1200 70 {lab=0}
N 1200 70 1440 70 {lab=0}
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
N 1200 30 1200 70 {lab=0}
N 1440 30 1440 70 {lab=0}
N 1680 30 1680 70 {lab=0}
N 1920 30 1920 70 {lab=0}
N 2160 30 2160 70 {lab=0}
N 2400 30 2400 70 {lab=0}
N 2640 30 2640 70 {lab=0}
C {devices/gnd.sym} 0 70 0 0 {name=l2 lab=0 global=false}
N 3280 -70 3260 -70 {lab=0}
C {devices/lab_pin.sym} 3260 -70 0 0 {name=l3 sig_type=std_logic lab=0}
N 4550 -70 4530 -70 {lab=0}
C {devices/lab_pin.sym} 4530 -70 0 0 {name=l4 sig_type=std_logic lab=0}
N 3280 10 3260 10 {lab=0}
C {devices/lab_pin.sym} 3260 10 0 0 {name=l5 sig_type=std_logic lab=0}
N 3710 10 3690 10 {lab=0}
C {devices/lab_pin.sym} 3690 10 0 0 {name=l6 sig_type=std_logic lab=0}
N 4130 10 4110 10 {lab=0}
C {devices/lab_pin.sym} 4110 10 0 0 {name=l7 sig_type=std_logic lab=0}
N 3280 50 3260 50 {lab=0}
C {devices/lab_pin.sym} 3260 50 0 0 {name=l8 sig_type=std_logic lab=0}
N 3710 50 3690 50 {lab=0}
C {devices/lab_pin.sym} 3690 50 0 0 {name=l9 sig_type=std_logic lab=0}
N 4130 50 4110 50 {lab=0}
C {devices/lab_pin.sym} 4110 50 0 0 {name=l10 sig_type=std_logic lab=0}
N 4550 50 4530 50 {lab=0}
C {devices/lab_pin.sym} 4530 50 0 0 {name=l11 sig_type=std_logic lab=0}
N 3280 70 3260 70 {lab=0}
C {devices/lab_pin.sym} 3260 70 0 0 {name=l12 sig_type=std_logic lab=0}
N 4130 70 4110 70 {lab=0}
C {devices/lab_pin.sym} 4110 70 0 0 {name=l13 sig_type=std_logic lab=0}
N 4550 70 4530 70 {lab=0}
C {devices/lab_pin.sym} 4530 70 0 0 {name=l14 sig_type=std_logic lab=0}
N 3280 90 3260 90 {lab=0}
C {devices/lab_pin.sym} 3260 90 0 0 {name=l15 sig_type=std_logic lab=0}
N 3710 90 3690 90 {lab=0}
C {devices/lab_pin.sym} 3690 90 0 0 {name=l16 sig_type=std_logic lab=0}
N 4130 90 4110 90 {lab=0}
C {devices/lab_pin.sym} 4110 90 0 0 {name=l17 sig_type=std_logic lab=0}
N 4550 90 4530 90 {lab=0}
C {devices/lab_pin.sym} 4530 90 0 0 {name=l18 sig_type=std_logic lab=0}
N 3460 -90 3480 -90 {lab=0}
C {devices/lab_pin.sym} 3480 -90 0 1 {name=l19 sig_type=std_logic lab=0}
N 3890 -90 3910 -90 {lab=0}
C {devices/lab_pin.sym} 3910 -90 0 1 {name=l20 sig_type=std_logic lab=0}
N 4730 -90 4750 -90 {lab=0}
C {devices/lab_pin.sym} 4750 -90 0 1 {name=l21 sig_type=std_logic lab=0}
N 3460 -70 3480 -70 {lab=0}
C {devices/lab_pin.sym} 3480 -70 0 1 {name=l22 sig_type=std_logic lab=0}
N 3460 30 3480 30 {lab=0}
C {devices/lab_pin.sym} 3480 30 0 1 {name=l23 sig_type=std_logic lab=0}
N 3890 30 3910 30 {lab=0}
C {devices/lab_pin.sym} 3910 30 0 1 {name=l24 sig_type=std_logic lab=0}
N 4310 30 4330 30 {lab=0}
C {devices/lab_pin.sym} 4330 30 0 1 {name=l25 sig_type=std_logic lab=0}
N 3460 50 3480 50 {lab=0}
C {devices/lab_pin.sym} 3480 50 0 1 {name=l26 sig_type=std_logic lab=0}
N 3890 50 3910 50 {lab=0}
C {devices/lab_pin.sym} 3910 50 0 1 {name=l27 sig_type=std_logic lab=0}
N 4310 50 4330 50 {lab=0}
C {devices/lab_pin.sym} 4330 50 0 1 {name=l28 sig_type=std_logic lab=0}
N 4730 50 4750 50 {lab=0}
C {devices/lab_pin.sym} 4750 50 0 1 {name=l29 sig_type=std_logic lab=0}
N 3460 70 3480 70 {lab=VDPWR}
C {devices/lab_pin.sym} 3480 70 0 1 {name=l30 sig_type=std_logic lab=VDPWR}
N 3890 70 3910 70 {lab=VDPWR}
C {devices/lab_pin.sym} 3910 70 0 1 {name=l31 sig_type=std_logic lab=VDPWR}
N 4310 70 4330 70 {lab=VDPWR}
C {devices/lab_pin.sym} 4330 70 0 1 {name=l32 sig_type=std_logic lab=VDPWR}
N 4730 70 4750 70 {lab=VDPWR}
C {devices/lab_pin.sym} 4750 70 0 1 {name=l33 sig_type=std_logic lab=VDPWR}
N 3460 90 3480 90 {lab=0}
C {devices/lab_pin.sym} 3480 90 0 1 {name=l34 sig_type=std_logic lab=0}
N 3890 90 3910 90 {lab=0}
C {devices/lab_pin.sym} 3910 90 0 1 {name=l35 sig_type=std_logic lab=0}
N 4310 90 4330 90 {lab=0}
C {devices/lab_pin.sym} 4330 90 0 1 {name=l36 sig_type=std_logic lab=0}
N 4730 90 4750 90 {lab=0}
C {devices/lab_pin.sym} 4750 90 0 1 {name=l37 sig_type=std_logic lab=0}
N 3710 30 3690 30 {lab=0}
C {devices/lab_pin.sym} 3690 30 0 0 {name=l38 sig_type=std_logic lab=0}
N 4130 30 4110 30 {lab=0}
C {devices/lab_pin.sym} 4110 30 0 0 {name=l39 sig_type=std_logic lab=0}
N 4550 30 4530 30 {lab=0}
C {devices/lab_pin.sym} 4530 30 0 0 {name=l40 sig_type=std_logic lab=0}
N 3890 -30 3910 -30 {lab=0}
C {devices/lab_pin.sym} 3910 -30 0 1 {name=l41 sig_type=std_logic lab=0}
N 4130 -90 4110 -90 {lab=0}
C {devices/lab_pin.sym} 4110 -90 0 0 {name=l42 sig_type=std_logic lab=0}
N 4130 -50 4110 -50 {lab=0}
C {devices/lab_pin.sym} 4110 -50 0 0 {name=l43 sig_type=std_logic lab=0}
N 4550 -50 4530 -50 {lab=0}
C {devices/lab_pin.sym} 4530 -50 0 0 {name=l44 sig_type=std_logic lab=0}
N 4310 10 4330 10 {lab=0}
C {devices/lab_pin.sym} 4330 10 0 1 {name=l45 sig_type=std_logic lab=0}
N 4550 -30 4530 -30 {lab=0}
C {devices/lab_pin.sym} 4530 -30 0 0 {name=l46 sig_type=std_logic lab=0}
N 4550 -10 4530 -10 {lab=0}
C {devices/lab_pin.sym} 4530 -10 0 0 {name=l47 sig_type=std_logic lab=0}
N 3280 -50 3260 -50 {lab=M_UA2}
C {devices/lab_pin.sym} 3260 -50 0 0 {name=l48 sig_type=std_logic lab=M_UA2}
N 3280 -30 3260 -30 {lab=M_UA3}
C {devices/lab_pin.sym} 3260 -30 0 0 {name=l49 sig_type=std_logic lab=M_UA3}
N 4130 -30 4110 -30 {lab=N_UA3}
C {devices/lab_pin.sym} 4110 -30 0 0 {name=l50 sig_type=std_logic lab=N_UA3}
N 4130 -10 4110 -10 {lab=N_UA4}
C {devices/lab_pin.sym} 4110 -10 0 0 {name=l51 sig_type=std_logic lab=N_UA4}
N 3000 70 3000 -30 {lab=H_EXT}
N 2640 -30 3000 -30 {lab=H_EXT}
C {devices/lab_pin.sym} 2640 -30 0 0 {name=l52 sig_type=std_logic lab=H_EXT}
N 4550 10 4510 10 {lab=H_UA5}
N 4510 10 4510 130 {lab=H_UA5}
N 3000 130 4510 130 {lab=H_UA5}
C {devices/lab_pin.sym} 3000 130 0 0 {name=l53 sig_type=std_logic lab=H_UA5}
N 1920 -30 1920 -110 {lab=P_UA4}
N 3710 -10 3690 -10 {lab=P_UA4}
N 3690 -10 3690 -110 {lab=P_UA4}
N 1920 -110 3690 -110 {lab=P_UA4}
C {devices/lab_pin.sym} 1920 -110 0 0 {name=l54 sig_type=std_logic lab=P_UA4}
N 2160 -30 2160 -120 {lab=N_UA1}
N 4130 -70 4090 -70 {lab=N_UA1}
N 4090 -70 4090 -120 {lab=N_UA1}
N 2160 -120 4090 -120 {lab=N_UA1}
C {devices/lab_pin.sym} 2160 -120 0 0 {name=l55 sig_type=std_logic lab=N_UA1}
N 1680 -30 1680 -130 {lab=P_UA3}
N 3710 -30 3670 -30 {lab=P_UA3}
N 3670 -30 3670 -130 {lab=P_UA3}
N 1680 -130 3670 -130 {lab=P_UA3}
C {devices/lab_pin.sym} 1680 -130 0 0 {name=l56 sig_type=std_logic lab=P_UA3}
N 2400 -30 2400 -50 {lab=H_UA0}
C {devices/lab_pin.sym} 2400 -50 1 0 {name=l57 sig_type=std_logic lab=H_UA0}
N 4550 -90 4530 -90 {lab=H_UA0}
C {devices/lab_pin.sym} 4530 -90 0 0 {name=l58 sig_type=std_logic lab=H_UA0}
N 1440 -30 1440 -50 {lab=P_UA2}
C {devices/lab_pin.sym} 1440 -50 1 0 {name=l59 sig_type=std_logic lab=P_UA2}
N 3710 -50 3650 -50 {lab=P_UA2}
C {devices/lab_pin.sym} 3650 -50 0 0 {name=l60 sig_type=std_logic lab=P_UA2}
N 1200 -30 1200 -50 {lab=P_UA1}
C {devices/lab_pin.sym} 1200 -50 1 0 {name=l61 sig_type=std_logic lab=P_UA1}
N 3710 -70 3650 -70 {lab=P_UA1}
C {devices/lab_pin.sym} 3650 -70 0 0 {name=l62 sig_type=std_logic lab=P_UA1}
N 720 -30 720 -70 {lab=M_UA4}
N 3280 -10 3240 -10 {lab=M_UA4}
N 3240 -10 3240 -70 {lab=M_UA4}
N 720 -70 3240 -70 {lab=M_UA4}
C {devices/lab_pin.sym} 720 -70 0 0 {name=l63 sig_type=std_logic lab=M_UA4}
N 960 -30 960 -50 {lab=P_UA0}
C {devices/lab_pin.sym} 960 -50 1 0 {name=l64 sig_type=std_logic lab=P_UA0}
N 3710 -90 3650 -90 {lab=P_UA0}
C {devices/lab_pin.sym} 3650 -90 0 0 {name=l65 sig_type=std_logic lab=P_UA0}
N 480 -30 480 -90 {lab=M_UA0}
N 3280 -90 3260 -90 {lab=M_UA0}
N 480 -90 3260 -90 {lab=M_UA0}
C {devices/lab_pin.sym} 480 -90 0 0 {name=l66 sig_type=std_logic lab=M_UA0}
N 240 -30 240 -50 {lab=HI}
C {devices/lab_pin.sym} 240 -50 1 0 {name=l67 sig_type=std_logic lab=HI}
N 3280 30 3260 30 {lab=HI}
C {devices/lab_pin.sym} 3260 30 0 0 {name=l68 sig_type=std_logic lab=HI}
N 3460 -50 3480 -50 {lab=HI}
C {devices/lab_pin.sym} 3480 -50 0 1 {name=l69 sig_type=std_logic lab=HI}
N 3460 -30 3480 -30 {lab=HI}
C {devices/lab_pin.sym} 3480 -30 0 1 {name=l70 sig_type=std_logic lab=HI}
N 3460 -10 3480 -10 {lab=HI}
C {devices/lab_pin.sym} 3480 -10 0 1 {name=l71 sig_type=std_logic lab=HI}
N 3460 10 3480 10 {lab=HI}
C {devices/lab_pin.sym} 3480 10 0 1 {name=l72 sig_type=std_logic lab=HI}
N 3710 70 3690 70 {lab=HI}
C {devices/lab_pin.sym} 3690 70 0 0 {name=l73 sig_type=std_logic lab=HI}
N 3890 -70 3910 -70 {lab=HI}
C {devices/lab_pin.sym} 3910 -70 0 1 {name=l74 sig_type=std_logic lab=HI}
N 3890 -50 3910 -50 {lab=HI}
C {devices/lab_pin.sym} 3910 -50 0 1 {name=l75 sig_type=std_logic lab=HI}
N 3890 -10 3910 -10 {lab=HI}
C {devices/lab_pin.sym} 3910 -10 0 1 {name=l76 sig_type=std_logic lab=HI}
N 3890 10 3910 10 {lab=HI}
C {devices/lab_pin.sym} 3910 10 0 1 {name=l77 sig_type=std_logic lab=HI}
N 4310 -90 4330 -90 {lab=HI}
C {devices/lab_pin.sym} 4330 -90 0 1 {name=l78 sig_type=std_logic lab=HI}
N 4310 -70 4330 -70 {lab=HI}
C {devices/lab_pin.sym} 4330 -70 0 1 {name=l79 sig_type=std_logic lab=HI}
N 4310 -50 4330 -50 {lab=HI}
C {devices/lab_pin.sym} 4330 -50 0 1 {name=l80 sig_type=std_logic lab=HI}
N 4310 -30 4330 -30 {lab=HI}
C {devices/lab_pin.sym} 4330 -30 0 1 {name=l81 sig_type=std_logic lab=HI}
N 4310 -10 4330 -10 {lab=HI}
C {devices/lab_pin.sym} 4330 -10 0 1 {name=l82 sig_type=std_logic lab=HI}
N 4730 -70 4750 -70 {lab=HI}
C {devices/lab_pin.sym} 4750 -70 0 1 {name=l83 sig_type=std_logic lab=HI}
N 4730 -50 4750 -50 {lab=HI}
C {devices/lab_pin.sym} 4750 -50 0 1 {name=l84 sig_type=std_logic lab=HI}
N 4730 -30 4750 -30 {lab=HI}
C {devices/lab_pin.sym} 4750 -30 0 1 {name=l85 sig_type=std_logic lab=HI}
N 4730 -10 4750 -10 {lab=HI}
C {devices/lab_pin.sym} 4750 -10 0 1 {name=l86 sig_type=std_logic lab=HI}
N 4730 10 4750 10 {lab=HI}
C {devices/lab_pin.sym} 4750 10 0 1 {name=l87 sig_type=std_logic lab=HI}
N 4730 30 4750 30 {lab=HI}
C {devices/lab_pin.sym} 4750 30 0 1 {name=l88 sig_type=std_logic lab=HI}
C {devices/code_shown.sym} -400 -600 0 0 {name=s1 only_toplevel=false value=".control
option rshunt=1e12
let vf = 0.63
let k = 0
while k < 5
alter VM4 dc = $&vf
op
let vf = vf + v(M_UA3) - v(M_UA2)
let k = k + 1
end
alter VM4 dc = $&vf
op
let iout = -i(VM4)
let mirror_err_pct = 100*(iout-5e-6)/5e-6
let mirror_vref = v(M_UA3)
let pair_isum = -(i(VP3)+i(VP4))
let pair_imbalance_pct = 100*(i(VP3)-i(VP4))/(i(VP3)+i(VP4))
let noise_vout_base = v(N_UA3)
let noise_vout_guard = v(N_UA4)
let heater_i = -i(VEXT)
let idle_leak_ua0 = abs(i(VH0))
print mirror_err_pct mirror_vref pair_isum pair_imbalance_pct
print noise_vout_base noise_vout_guard heater_i idle_leak_ua0
write tb_ELAD1_ANALOG_CORE.raw
.endc"}
C {sky130_fd_pr/corner.sym} -400 -800 0 0 {name=CORNER only_toplevel=true corner=tt}
T {tb_ELAD1_ANALOG_CORE - all experiments through the selector, one core copy per mode:
XMIR  mirror GROUPED: IREF 5 uA into ua0, ua4 servoed until V(ua2) = V(ua3) (Kelvin).
XPAIR pair GROUPED: ITAIL 10 uA into ua0, VIN+ = VIN- = 1.0 V, both drains 1.2 V.
XNOI  noise bank: VQUIET 0.771 V on ua1, victim outputs on ua3 / ua4 (open, ~0.9 V).
XHTR  heater on: 1.8 V through 500 ohm into ua5; selector idle, ua0 at 0.9 V (leakage).
Control pins tie to HI (1.8 V) or ground; AGG_CLK is held low (aggressor static).} -400 -1170 0 0 0.4 0.4 {}
