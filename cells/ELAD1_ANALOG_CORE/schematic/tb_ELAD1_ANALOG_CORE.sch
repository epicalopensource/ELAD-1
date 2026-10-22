v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -370 870 -340 870 {}
N -380 730 -360 730 {}
N -360 730 -340 730 {}
N -500 730 -500 750 {}
N -500 730 -380 730 {}
N -380 590 -360 590 {}
N -360 590 -340 590 {}
N -380 450 -360 450 {}
N -360 450 -340 450 {}
N -370 310 -340 310 {}
N -380 170 -360 170 {}
N -360 170 -340 170 {}
N -500 170 -500 190 {}
N -500 170 -380 170 {}
N 280 1000 310 1000 {}
N -240 1000 -240 1020 {}
N 0 1000 0 1020 {}
N 40 1000 40 1020 {}
N 80 1000 80 1020 {}
N 120 1000 120 1020 {}
N -370 2040 -340 2040 {}
N -380 1900 -360 1900 {}
N -360 1900 -340 1900 {}
N -500 1900 -500 1920 {}
N -500 1900 -380 1900 {}
N -380 1760 -360 1760 {}
N -360 1760 -340 1760 {}
N -500 1760 -500 1780 {}
N -500 1760 -380 1760 {}
N -380 1620 -360 1620 {}
N -360 1620 -340 1620 {}
N -500 1620 -500 1640 {}
N -500 1620 -380 1620 {}
N -380 1480 -360 1480 {}
N -360 1480 -340 1480 {}
N -500 1480 -500 1500 {}
N -500 1480 -380 1480 {}
N -380 1340 -360 1340 {}
N -360 1340 -340 1340 {}
N -500 1340 -500 1360 {}
N -500 1340 -380 1340 {}
N 280 2170 310 2170 {}
N -160 2170 -160 2190 {}
N -40 2170 -40 2190 {}
N 0 2170 0 2190 {}
N 80 2170 80 2190 {}
N 120 2170 120 2190 {}
N -370 3210 -340 3210 {}
N -380 3070 -360 3070 {}
N -360 3070 -340 3070 {}
N -380 2930 -360 2930 {}
N -360 2930 -340 2930 {}
N -370 2790 -340 2790 {}
N -380 2650 -360 2650 {}
N -360 2650 -340 2650 {}
N -500 2650 -500 2670 {}
N -500 2650 -380 2650 {}
N -370 2510 -340 2510 {}
N 280 3340 310 3340 {}
N -80 3340 -80 3360 {}
N -40 3340 -40 3360 {}
N 0 3340 0 3360 {}
N 40 3340 40 3360 {}
N 80 3340 80 3360 {}
N -380 4380 -360 4380 {}
N -360 4380 -340 4380 {}
N -410 4380 -380 4380 {}
N -500 4380 -470 4380 {}
N -620 4380 -620 4400 {}
N -620 4380 -500 4380 {}
N -370 4240 -340 4240 {}
N -370 4100 -340 4100 {}
N -370 3960 -340 3960 {}
N -370 3820 -340 3820 {}
N -380 3680 -360 3680 {}
N -360 3680 -340 3680 {}
N -500 3680 -500 3700 {}
N -500 3680 -380 3680 {}
N 280 4510 310 4510 {}
N -40 4510 -40 4530 {}
N 0 4510 0 4530 {}
N 40 4510 40 4530 {}
N 80 4510 80 4530 {}
N 120 4510 120 4530 {}
N 160 4510 160 4530 {}
N -500 4680 -500 4700 {}
N -620 4680 -500 4680 {}
N -240 4680 -240 4700 {}
N -360 4680 -240 4680 {}
C {ELAD1_ANALOG_CORE.sym} 0 520 0 0 {name=XMIR}
C {devices/gnd.sym} -370 870 0 0 {name=l1 lab=0 global=false}
C {devices/lab_pin.sym} -360 730 0 0 {name=l2 sig_type=std_logic lab=M_UA4}
C {devices/vsource.sym} -500 780 0 0 {name=VM4 value=0.63}
C {devices/gnd.sym} -500 810 0 0 {name=l3 lab=0 global=false}
C {devices/lab_pin.sym} -360 590 0 0 {name=l4 sig_type=std_logic lab=M_UA3}
C {devices/lab_pin.sym} -360 450 0 0 {name=l5 sig_type=std_logic lab=M_UA2}
C {devices/gnd.sym} -370 310 0 0 {name=l6 lab=0 global=false}
C {devices/lab_pin.sym} -360 170 0 0 {name=l7 sig_type=std_logic lab=M_UA0}
C {devices/isource.sym} -500 220 2 0 {name=IM value="DC 5u"}
C {devices/gnd.sym} -500 250 0 0 {name=l8 lab=0 global=false}
C {devices/gnd.sym} 310 1000 0 0 {name=l9 lab=0 global=false}
C {devices/vdd.sym} 0 60 0 0 {name=l10 lab=VDPWR global=false}
C {devices/vdd.sym} -240 1020 0 0 {name=l11 lab=HI global=false}
C {devices/gnd.sym} -200 1000 0 0 {name=l12 lab=0 global=false}
C {devices/gnd.sym} -160 1000 0 0 {name=l13 lab=0 global=false}
C {devices/gnd.sym} -120 1000 0 0 {name=l14 lab=0 global=false}
C {devices/gnd.sym} -80 1000 0 0 {name=l15 lab=0 global=false}
C {devices/gnd.sym} -40 1000 0 0 {name=l16 lab=0 global=false}
C {devices/vdd.sym} 0 1020 0 0 {name=l17 lab=HI global=false}
C {devices/vdd.sym} 40 1020 0 0 {name=l18 lab=HI global=false}
C {devices/vdd.sym} 80 1020 0 0 {name=l19 lab=HI global=false}
C {devices/vdd.sym} 120 1020 0 0 {name=l20 lab=HI global=false}
C {devices/gnd.sym} 160 1000 0 0 {name=l21 lab=0 global=false}
C {devices/gnd.sym} 200 1000 0 0 {name=l22 lab=0 global=false}
C {ELAD1_ANALOG_CORE.sym} 0 1690 0 0 {name=XPAIR}
C {devices/gnd.sym} -370 2040 0 0 {name=l23 lab=0 global=false}
C {devices/lab_pin.sym} -360 1900 0 0 {name=l24 sig_type=std_logic lab=P_UA4}
C {devices/vsource.sym} -500 1950 0 0 {name=VP4 value=1.2}
C {devices/gnd.sym} -500 1980 0 0 {name=l25 lab=0 global=false}
C {devices/lab_pin.sym} -360 1760 0 0 {name=l26 sig_type=std_logic lab=P_UA3}
C {devices/vsource.sym} -500 1810 0 0 {name=VP3 value=1.2}
C {devices/gnd.sym} -500 1840 0 0 {name=l27 lab=0 global=false}
C {devices/lab_pin.sym} -360 1620 0 0 {name=l28 sig_type=std_logic lab=P_UA2}
C {devices/vsource.sym} -500 1670 0 0 {name=VP2 value=1.0}
C {devices/gnd.sym} -500 1700 0 0 {name=l29 lab=0 global=false}
C {devices/lab_pin.sym} -360 1480 0 0 {name=l30 sig_type=std_logic lab=P_UA1}
C {devices/vsource.sym} -500 1530 0 0 {name=VP1 value=1.0}
C {devices/gnd.sym} -500 1560 0 0 {name=l31 lab=0 global=false}
C {devices/lab_pin.sym} -360 1340 0 0 {name=l32 sig_type=std_logic lab=P_UA0}
C {devices/isource.sym} -500 1390 2 0 {name=IP value="DC 10u"}
C {devices/gnd.sym} -500 1420 0 0 {name=l33 lab=0 global=false}
C {devices/gnd.sym} 310 2170 0 0 {name=l34 lab=0 global=false}
C {devices/vdd.sym} 0 1230 0 0 {name=l35 lab=VDPWR global=false}
C {devices/gnd.sym} -240 2170 0 0 {name=l36 lab=0 global=false}
C {devices/gnd.sym} -200 2170 0 0 {name=l37 lab=0 global=false}
C {devices/vdd.sym} -160 2190 0 0 {name=l38 lab=HI global=false}
C {devices/gnd.sym} -120 2170 0 0 {name=l39 lab=0 global=false}
C {devices/gnd.sym} -80 2170 0 0 {name=l40 lab=0 global=false}
C {devices/vdd.sym} -40 2190 0 0 {name=l41 lab=HI global=false}
C {devices/vdd.sym} 0 2190 0 0 {name=l42 lab=HI global=false}
C {devices/gnd.sym} 40 2170 0 0 {name=l43 lab=0 global=false}
C {devices/vdd.sym} 80 2190 0 0 {name=l44 lab=HI global=false}
C {devices/vdd.sym} 120 2190 0 0 {name=l45 lab=HI global=false}
C {devices/gnd.sym} 160 2170 0 0 {name=l46 lab=0 global=false}
C {devices/gnd.sym} 200 2170 0 0 {name=l47 lab=0 global=false}
C {ELAD1_ANALOG_CORE.sym} 0 2860 0 0 {name=XNOI}
C {devices/gnd.sym} -370 3210 0 0 {name=l48 lab=0 global=false}
C {devices/lab_pin.sym} -360 3070 0 0 {name=l49 sig_type=std_logic lab=N_UA4}
C {devices/lab_pin.sym} -360 2930 0 0 {name=l50 sig_type=std_logic lab=N_UA3}
C {devices/gnd.sym} -370 2790 0 0 {name=l51 lab=0 global=false}
C {devices/lab_pin.sym} -360 2650 0 0 {name=l52 sig_type=std_logic lab=N_UA1}
C {devices/vsource.sym} -500 2700 0 0 {name=VN1 value=0.771}
C {devices/gnd.sym} -500 2730 0 0 {name=l53 lab=0 global=false}
C {devices/gnd.sym} -370 2510 0 0 {name=l54 lab=0 global=false}
C {devices/gnd.sym} 310 3340 0 0 {name=l55 lab=0 global=false}
C {devices/vdd.sym} 0 2400 0 0 {name=l56 lab=VDPWR global=false}
C {devices/gnd.sym} -240 3340 0 0 {name=l57 lab=0 global=false}
C {devices/gnd.sym} -200 3340 0 0 {name=l58 lab=0 global=false}
C {devices/gnd.sym} -160 3340 0 0 {name=l59 lab=0 global=false}
C {devices/gnd.sym} -120 3340 0 0 {name=l60 lab=0 global=false}
C {devices/vdd.sym} -80 3360 0 0 {name=l61 lab=HI global=false}
C {devices/vdd.sym} -40 3360 0 0 {name=l62 lab=HI global=false}
C {devices/vdd.sym} 0 3360 0 0 {name=l63 lab=HI global=false}
C {devices/vdd.sym} 40 3360 0 0 {name=l64 lab=HI global=false}
C {devices/vdd.sym} 80 3360 0 0 {name=l65 lab=HI global=false}
C {devices/gnd.sym} 120 3340 0 0 {name=l66 lab=0 global=false}
C {devices/gnd.sym} 160 3340 0 0 {name=l67 lab=0 global=false}
C {devices/gnd.sym} 200 3340 0 0 {name=l68 lab=0 global=false}
C {ELAD1_ANALOG_CORE.sym} 0 4030 0 0 {name=XHTR}
C {devices/lab_pin.sym} -360 4380 0 0 {name=l69 sig_type=std_logic lab=H_UA5}
C {devices/res.sym} -440 4380 3 0 {name=RP value=500}
C {devices/lab_pin.sym} -500 4380 0 0 {name=l70 sig_type=std_logic lab=H_EXT}
C {devices/vsource.sym} -620 4430 0 0 {name=VEXT value=1.8}
C {devices/gnd.sym} -620 4460 0 0 {name=l71 lab=0 global=false}
C {devices/gnd.sym} -370 4240 0 0 {name=l72 lab=0 global=false}
C {devices/gnd.sym} -370 4100 0 0 {name=l73 lab=0 global=false}
C {devices/gnd.sym} -370 3960 0 0 {name=l74 lab=0 global=false}
C {devices/gnd.sym} -370 3820 0 0 {name=l75 lab=0 global=false}
C {devices/lab_pin.sym} -360 3680 0 0 {name=l76 sig_type=std_logic lab=H_UA0}
C {devices/vsource.sym} -500 3730 0 0 {name=VH0 value=0.9}
C {devices/gnd.sym} -500 3760 0 0 {name=l77 lab=0 global=false}
C {devices/gnd.sym} 310 4510 0 0 {name=l78 lab=0 global=false}
C {devices/vdd.sym} 0 3570 0 0 {name=l79 lab=VDPWR global=false}
C {devices/gnd.sym} -240 4510 0 0 {name=l80 lab=0 global=false}
C {devices/gnd.sym} -200 4510 0 0 {name=l81 lab=0 global=false}
C {devices/gnd.sym} -160 4510 0 0 {name=l82 lab=0 global=false}
C {devices/gnd.sym} -120 4510 0 0 {name=l83 lab=0 global=false}
C {devices/gnd.sym} -80 4510 0 0 {name=l84 lab=0 global=false}
C {devices/vdd.sym} -40 4530 0 0 {name=l85 lab=HI global=false}
C {devices/vdd.sym} 0 4530 0 0 {name=l86 lab=HI global=false}
C {devices/vdd.sym} 40 4530 0 0 {name=l87 lab=HI global=false}
C {devices/vdd.sym} 80 4530 0 0 {name=l88 lab=HI global=false}
C {devices/vdd.sym} 120 4530 0 0 {name=l89 lab=HI global=false}
C {devices/vdd.sym} 160 4530 0 0 {name=l90 lab=HI global=false}
C {devices/gnd.sym} 200 4510 0 0 {name=l91 lab=0 global=false}
C {devices/vdd.sym} -620 4680 0 0 {name=l92 lab=HI global=false}
C {devices/vsource.sym} -500 4730 0 0 {name=VHI value=1.8}
C {devices/gnd.sym} -500 4760 0 0 {name=l93 lab=0 global=false}
C {devices/vdd.sym} -360 4680 0 0 {name=l94 lab=VDPWR global=false}
C {devices/vsource.sym} -240 4730 0 0 {name=VDD value=1.8}
C {devices/gnd.sym} -240 4760 0 0 {name=l95 lab=0 global=false}
T {tb_ELAD1_ANALOG_CORE - all experiments through the selector, one core copy per mode:} -660 -220 0 0 0.4 0.4 {}
T {XMIR  mirror GROUPED: IREF 5 uA into ua0, ua4 servoed until V(ua2) = V(ua3) (Kelvin).
XPAIR pair GROUPED: ITAIL 10 uA into ua0, VIN+ = VIN- = 1.0 V, both drains 1.2 V.
XNOI  noise bank: VQUIET 0.771 V on ua1, victim outputs on ua3 / ua4 (open, ~0.9 V).
XHTR  heater on: 1.8 V through 500 ohm into ua5; selector idle, ua0 at 0.9 V (leakage).
Control pins tie to HI (1.8 V) or ground; AGG_CLK is held low (aggressor static).} -660 -175 0 0 0.22 0.22 {}
C {devices/code_shown.sym} 510 200 0 0 {name=s1 only_toplevel=false value=".control
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
C {sky130_fd_pr/corner.sym} 510 0 0 0 {name=CORNER only_toplevel=true corner=tt}
