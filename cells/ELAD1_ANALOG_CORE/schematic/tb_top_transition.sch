v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/vsource.sym} 0 200 0 0 {name=VSUP value=1.8}
C {devices/res.sym} 110 0 2 1 {name=RPDN value=5}
C {devices/vsource.sym} 240 200 0 0 {name=VGNDS value=0}
C {devices/capa.sym} 2400 200 0 0 {name=CPE0 value=2.5p}
C {devices/res.sym} 9720 300 0 0 {name=RPA0 value=500}
C {devices/capa.sym} 2640 200 0 0 {name=CPI0 value=2.5p}
C {devices/capa.sym} 2880 200 0 0 {name=CPE1 value=2.5p}
C {devices/res.sym} 9880 300 0 0 {name=RPA1 value=500}
C {devices/capa.sym} 3120 200 0 0 {name=CPI1 value=2.5p}
C {devices/capa.sym} 3360 200 0 0 {name=CPE2 value=2.5p}
C {devices/res.sym} 10040 300 0 0 {name=RPA2 value=500}
C {devices/capa.sym} 3600 200 0 0 {name=CPI2 value=2.5p}
C {devices/capa.sym} 3840 200 0 0 {name=CPE3 value=2.5p}
C {devices/res.sym} 10200 300 0 0 {name=RPA3 value=500}
C {devices/capa.sym} 4080 200 0 0 {name=CPI3 value=2.5p}
C {devices/capa.sym} 1920 200 0 0 {name=CPE4 value=2.5p}
C {devices/res.sym} 10360 300 0 0 {name=RPA4 value=500}
C {devices/capa.sym} 4320 200 0 0 {name=CPI4 value=2.5p}
C {devices/capa.sym} 4560 200 0 0 {name=CPE5 value=2.5p}
C {devices/res.sym} 10520 300 0 0 {name=RPA5 value=500}
C {devices/capa.sym} 4800 200 0 0 {name=CPI5 value=2.5p}
C {ELAD1_ANALOG_CORE.sym} 10890 100 0 0 {name=XCORE}
C {devices/vsource.sym} 5040 200 0 0 {name=VEMG value="PWL(0 1.8 2.5u 1.8 2.501u 0)"}
C {devices/vsource.sym} 5280 200 0 0 {name=VEMC value="PWL(0 0 3.2u 0 3.201u 1.8)"}
C {devices/vsource.sym} 5520 200 0 0 {name=VCMG value="PWL(0 0 2.9u 0 2.901u 1.8)"}
C {devices/vsource.sym} 5760 200 0 0 {name=VCMC value="PWL(0 1.8 2.9u 1.8 2.901u 0)"}
C {devices/vsource.sym} 6000 200 0 0 {name=VEPG value=0}
C {devices/vsource.sym} 6240 200 0 0 {name=VEPC value=0}
C {devices/vsource.sym} 6480 200 0 0 {name=VEN value=0}
C {devices/vsource.sym} 6720 200 0 0 {name=VCPG value=1.8}
C {devices/vsource.sym} 6960 200 0 0 {name=VCPC value=1.8}
C {devices/vsource.sym} 7200 200 0 0 {name=VCN value=1.8}
C {devices/vsource.sym} 7440 200 0 0 {name=VHEN value=0}
C {devices/vsource.sym} 7680 200 0 0 {name=VAGG value=0}
C {devices/isource.sym} 7920 200 2 1 {name=IREF value="DC 10u"}
C {devices/bsource.sym} 8160 200 0 0 {name=BCMP VAR=I FUNC="'max(0, v(P0)-1.8)*0.1'" m=1}
C {devices/vsource.sym} 8400 200 0 0 {name=VP1 value=0}
C {devices/vsource.sym} 8640 200 0 0 {name=VP5 value=0}
C {devices/vccs.sym} 8880 200 2 1 {name=GINT value=1e-3}
C {devices/capa.sym} 9120 200 0 0 {name=CINT value=1n}
C {devices/res.sym} 9360 200 0 0 {name=RINT value=1e12}
C {devices/vcvs.sym} 2160 200 0 0 {name=E4 value=1}
C {devices/vsource.sym} 2030 0 0 0 {name=VM4 value=0}
N 0 270 240 270 {lab=0}
N 240 270 1920 270 {lab=0}
N 1920 270 2160 270 {lab=0}
N 2160 270 2400 270 {lab=0}
N 2400 270 2640 270 {lab=0}
N 2640 270 2880 270 {lab=0}
N 2880 270 3120 270 {lab=0}
N 3120 270 3360 270 {lab=0}
N 3360 270 3600 270 {lab=0}
N 3600 270 3840 270 {lab=0}
N 3840 270 4080 270 {lab=0}
N 4080 270 4320 270 {lab=0}
N 4320 270 4560 270 {lab=0}
N 4560 270 4800 270 {lab=0}
N 4800 270 5040 270 {lab=0}
N 5040 270 5280 270 {lab=0}
N 5280 270 5520 270 {lab=0}
N 5520 270 5760 270 {lab=0}
N 5760 270 6000 270 {lab=0}
N 6000 270 6240 270 {lab=0}
N 6240 270 6480 270 {lab=0}
N 6480 270 6720 270 {lab=0}
N 6720 270 6960 270 {lab=0}
N 6960 270 7200 270 {lab=0}
N 7200 270 7440 270 {lab=0}
N 7440 270 7680 270 {lab=0}
N 7680 270 7920 270 {lab=0}
N 7920 270 8160 270 {lab=0}
N 8160 270 8400 270 {lab=0}
N 8400 270 8640 270 {lab=0}
N 8640 270 8880 270 {lab=0}
N 8880 270 9120 270 {lab=0}
N 9120 270 9360 270 {lab=0}
N 0 230 0 270 {lab=0}
N 240 230 240 270 {lab=0}
N 2400 230 2400 270 {lab=0}
N 2640 230 2640 270 {lab=0}
N 2880 230 2880 270 {lab=0}
N 3120 230 3120 270 {lab=0}
N 3360 230 3360 270 {lab=0}
N 3600 230 3600 270 {lab=0}
N 3840 230 3840 270 {lab=0}
N 4080 230 4080 270 {lab=0}
N 1920 230 1920 270 {lab=0}
N 4320 230 4320 270 {lab=0}
N 4560 230 4560 270 {lab=0}
N 4800 230 4800 270 {lab=0}
N 5040 230 5040 270 {lab=0}
N 5280 230 5280 270 {lab=0}
N 5520 230 5520 270 {lab=0}
N 5760 230 5760 270 {lab=0}
N 6000 230 6000 270 {lab=0}
N 6240 230 6240 270 {lab=0}
N 6480 230 6480 270 {lab=0}
N 6720 230 6720 270 {lab=0}
N 6960 230 6960 270 {lab=0}
N 7200 230 7200 270 {lab=0}
N 7440 230 7440 270 {lab=0}
N 7680 230 7680 270 {lab=0}
N 7920 230 7920 270 {lab=0}
N 8160 230 8160 270 {lab=0}
N 8400 230 8400 270 {lab=0}
N 8640 230 8640 270 {lab=0}
N 8880 230 8880 270 {lab=0}
N 9120 230 9120 270 {lab=0}
N 9360 230 9360 270 {lab=0}
N 2160 230 2160 270 {lab=0}
C {devices/gnd.sym} 0 270 0 0 {name=l1 lab=0 global=false}
N 110 -30 110 -50 {lab=VDPWR}
C {devices/vdd.sym} 110 -50 0 0 {name=l2 lab=VDPWR global=false}
N 240 170 240 150 {lab=VGND}
C {devices/lab_pin.sym} 240 150 1 0 {name=l3 sig_type=std_logic lab=VGND}
N 10980 170 11000 170 {lab=VDPWR}
C {devices/lab_pin.sym} 11000 170 0 1 {name=l4 sig_type=std_logic lab=VDPWR}
N 10980 190 11000 190 {lab=VGND}
C {devices/lab_pin.sym} 11000 190 0 1 {name=l5 sig_type=std_logic lab=VGND}
N 2120 220 2100 220 {lab=0}
C {devices/lab_pin.sym} 2100 220 0 0 {name=l6 sig_type=std_logic lab=0}
N 0 170 0 130 {lab=vsup}
N 110 30 110 130 {lab=vsup}
N 0 130 110 130 {lab=vsup}
C {devices/lab_pin.sym} 0 130 0 0 {name=l7 sig_type=std_logic lab=vsup}
N 2160 170 2160 130 {lab=P4x}
N 2030 -30 2030 -50 {lab=P4x}
N 2030 -50 2010 -50 {lab=P4x}
N 2010 -50 2010 130 {lab=P4x}
N 2010 130 2160 130 {lab=P4x}
C {devices/lab_pin.sym} 2010 130 0 0 {name=l8 sig_type=std_logic lab=P4x}
N 4560 170 4560 130 {lab=P5}
N 10520 270 10520 130 {lab=P5}
N 8640 170 8640 130 {lab=P5}
N 4560 130 8640 130 {lab=P5}
N 8640 130 10520 130 {lab=P5}
C {devices/lab_pin.sym} 4560 130 0 0 {name=l9 sig_type=std_logic lab=P5}
N 2880 170 2880 120 {lab=P1}
N 9880 270 9880 120 {lab=P1}
N 8400 170 8400 120 {lab=P1}
N 2880 120 8400 120 {lab=P1}
N 8400 120 9880 120 {lab=P1}
C {devices/lab_pin.sym} 2880 120 0 0 {name=l10 sig_type=std_logic lab=P1}
N 1920 170 1920 110 {lab=P4}
N 10360 270 10360 110 {lab=P4}
N 2030 30 2030 110 {lab=P4}
N 1920 110 2030 110 {lab=P4}
N 2030 110 10360 110 {lab=P4}
C {devices/lab_pin.sym} 1920 110 0 0 {name=l11 sig_type=std_logic lab=P4}
N 8880 170 8880 150 {lab=nint}
N 8880 150 8820 150 {lab=nint}
N 8820 150 8820 280 {lab=nint}
N 9120 170 9120 150 {lab=nint}
N 9120 150 9090 150 {lab=nint}
N 9090 150 9090 280 {lab=nint}
N 9360 170 9360 150 {lab=nint}
N 9360 150 9340 150 {lab=nint}
N 9340 150 9340 280 {lab=nint}
N 8820 280 9090 280 {lab=nint}
N 9090 280 9340 280 {lab=nint}
C {devices/lab_pin.sym} 8820 280 0 0 {name=l12 sig_type=std_logic lab=nint}
N 2120 180 2100 180 {lab=nint}
C {devices/lab_pin.sym} 2100 180 0 0 {name=l13 sig_type=std_logic lab=nint}
N 2400 170 2400 150 {lab=P0}
N 2400 150 2370 150 {lab=P0}
N 2370 150 2370 290 {lab=P0}
N 9720 270 9720 250 {lab=P0}
N 9720 250 9700 250 {lab=P0}
N 9700 250 9700 290 {lab=P0}
N 7920 170 7920 150 {lab=P0}
N 7920 150 7900 150 {lab=P0}
N 7900 150 7900 290 {lab=P0}
N 8160 170 8160 150 {lab=P0}
N 8160 150 8120 150 {lab=P0}
N 8120 150 8120 290 {lab=P0}
N 2370 290 7900 290 {lab=P0}
N 7900 290 8120 290 {lab=P0}
N 8120 290 9700 290 {lab=P0}
C {devices/lab_pin.sym} 2370 290 0 0 {name=l14 sig_type=std_logic lab=P0}
N 10980 150 11000 150 {lab=AGG_CLK}
N 11000 150 11000 -10 {lab=AGG_CLK}
N 7680 170 7680 -10 {lab=AGG_CLK}
N 7680 -10 11000 -10 {lab=AGG_CLK}
C {devices/lab_pin.sym} 7680 -10 0 0 {name=l15 sig_type=std_logic lab=AGG_CLK}
N 10980 130 11020 130 {lab=HEN}
C {devices/lab_pin.sym} 11020 130 0 1 {name=l16 sig_type=std_logic lab=HEN}
N 7440 170 7440 150 {lab=HEN}
C {devices/lab_pin.sym} 7440 150 1 0 {name=l17 sig_type=std_logic lab=HEN}
N 10980 110 11020 110 {lab=CLR_N}
C {devices/lab_pin.sym} 11020 110 0 1 {name=l18 sig_type=std_logic lab=CLR_N}
N 7200 170 7200 150 {lab=CLR_N}
C {devices/lab_pin.sym} 7200 150 1 0 {name=l19 sig_type=std_logic lab=CLR_N}
N 10980 90 11020 90 {lab=CLR_PC}
C {devices/lab_pin.sym} 11020 90 0 1 {name=l20 sig_type=std_logic lab=CLR_PC}
N 6960 170 6960 150 {lab=CLR_PC}
C {devices/lab_pin.sym} 6960 150 1 0 {name=l21 sig_type=std_logic lab=CLR_PC}
N 10980 70 11020 70 {lab=CLR_PG}
C {devices/lab_pin.sym} 11020 70 0 1 {name=l22 sig_type=std_logic lab=CLR_PG}
N 6720 170 6720 150 {lab=CLR_PG}
C {devices/lab_pin.sym} 6720 150 1 0 {name=l23 sig_type=std_logic lab=CLR_PG}
N 10800 190 10780 190 {lab=EN_PC}
C {devices/lab_pin.sym} 10780 190 0 0 {name=l24 sig_type=std_logic lab=EN_PC}
N 6240 170 6240 150 {lab=EN_PC}
C {devices/lab_pin.sym} 6240 150 1 0 {name=l25 sig_type=std_logic lab=EN_PC}
N 10980 10 11020 10 {lab=EN_N}
C {devices/lab_pin.sym} 11020 10 0 1 {name=l26 sig_type=std_logic lab=EN_N}
N 6480 170 6480 150 {lab=EN_N}
C {devices/lab_pin.sym} 6480 150 1 0 {name=l27 sig_type=std_logic lab=EN_N}
N 10800 170 10780 170 {lab=EN_PG}
C {devices/lab_pin.sym} 10780 170 0 0 {name=l28 sig_type=std_logic lab=EN_PG}
N 6000 170 6000 150 {lab=EN_PG}
C {devices/lab_pin.sym} 6000 150 1 0 {name=l29 sig_type=std_logic lab=EN_PG}
N 10980 50 11020 50 {lab=CLR_MC}
C {devices/lab_pin.sym} 11020 50 0 1 {name=l30 sig_type=std_logic lab=CLR_MC}
N 5760 170 5760 150 {lab=CLR_MC}
C {devices/lab_pin.sym} 5760 150 1 0 {name=l31 sig_type=std_logic lab=CLR_MC}
N 10800 150 10780 150 {lab=EN_MC}
C {devices/lab_pin.sym} 10780 150 0 0 {name=l32 sig_type=std_logic lab=EN_MC}
N 5280 170 5280 150 {lab=EN_MC}
C {devices/lab_pin.sym} 5280 150 1 0 {name=l33 sig_type=std_logic lab=EN_MC}
N 10980 30 11020 30 {lab=CLR_MG}
C {devices/lab_pin.sym} 11020 30 0 1 {name=l34 sig_type=std_logic lab=CLR_MG}
N 5520 170 5520 150 {lab=CLR_MG}
C {devices/lab_pin.sym} 5520 150 1 0 {name=l35 sig_type=std_logic lab=CLR_MG}
N 10800 130 10780 130 {lab=EN_MG}
C {devices/lab_pin.sym} 10780 130 0 0 {name=l36 sig_type=std_logic lab=EN_MG}
N 5040 170 5040 150 {lab=EN_MG}
C {devices/lab_pin.sym} 5040 150 1 0 {name=l37 sig_type=std_logic lab=EN_MG}
N 10520 330 10520 370 {lab=UA5}
N 4800 170 4800 150 {lab=UA5}
N 4800 150 4770 150 {lab=UA5}
N 4770 150 4770 370 {lab=UA5}
N 10800 110 10760 110 {lab=UA5}
N 10760 110 10760 370 {lab=UA5}
N 4770 370 10520 370 {lab=UA5}
N 10520 370 10760 370 {lab=UA5}
C {devices/lab_pin.sym} 4770 370 0 0 {name=l38 sig_type=std_logic lab=UA5}
N 3840 170 3840 150 {lab=P3}
C {devices/lab_pin.sym} 3840 150 1 0 {name=l39 sig_type=std_logic lab=P3}
N 10200 270 10200 250 {lab=P3}
C {devices/lab_pin.sym} 10200 250 1 0 {name=l40 sig_type=std_logic lab=P3}
N 8840 220 8800 220 {lab=P3}
C {devices/lab_pin.sym} 8800 220 0 0 {name=l41 sig_type=std_logic lab=P3}
N 10360 330 10360 350 {lab=UA4}
C {devices/lab_pin.sym} 10360 350 3 0 {name=l42 sig_type=std_logic lab=UA4}
N 4320 170 4320 150 {lab=UA4}
C {devices/lab_pin.sym} 4320 150 1 0 {name=l43 sig_type=std_logic lab=UA4}
N 10800 90 10780 90 {lab=UA4}
C {devices/lab_pin.sym} 10780 90 0 0 {name=l44 sig_type=std_logic lab=UA4}
N 3360 170 3360 150 {lab=P2}
C {devices/lab_pin.sym} 3360 150 1 0 {name=l45 sig_type=std_logic lab=P2}
N 10040 270 10040 250 {lab=P2}
C {devices/lab_pin.sym} 10040 250 1 0 {name=l46 sig_type=std_logic lab=P2}
N 8840 180 8800 180 {lab=P2}
C {devices/lab_pin.sym} 8800 180 0 0 {name=l47 sig_type=std_logic lab=P2}
N 10200 330 10200 350 {lab=UA3}
C {devices/lab_pin.sym} 10200 350 3 0 {name=l48 sig_type=std_logic lab=UA3}
N 4080 170 4080 150 {lab=UA3}
C {devices/lab_pin.sym} 4080 150 1 0 {name=l49 sig_type=std_logic lab=UA3}
N 10800 70 10780 70 {lab=UA3}
C {devices/lab_pin.sym} 10780 70 0 0 {name=l50 sig_type=std_logic lab=UA3}
N 10040 330 10040 350 {lab=UA2}
C {devices/lab_pin.sym} 10040 350 3 0 {name=l51 sig_type=std_logic lab=UA2}
N 3600 170 3600 150 {lab=UA2}
C {devices/lab_pin.sym} 3600 150 1 0 {name=l52 sig_type=std_logic lab=UA2}
N 10800 50 10780 50 {lab=UA2}
C {devices/lab_pin.sym} 10780 50 0 0 {name=l53 sig_type=std_logic lab=UA2}
N 9880 330 9880 350 {lab=UA1}
C {devices/lab_pin.sym} 9880 350 3 0 {name=l54 sig_type=std_logic lab=UA1}
N 3120 170 3120 150 {lab=UA1}
C {devices/lab_pin.sym} 3120 150 1 0 {name=l55 sig_type=std_logic lab=UA1}
N 10800 30 10780 30 {lab=UA1}
C {devices/lab_pin.sym} 10780 30 0 0 {name=l56 sig_type=std_logic lab=UA1}
N 9720 330 9720 350 {lab=UA0}
C {devices/lab_pin.sym} 9720 350 3 0 {name=l57 sig_type=std_logic lab=UA0}
N 2640 170 2640 150 {lab=UA0}
C {devices/lab_pin.sym} 2640 150 1 0 {name=l58 sig_type=std_logic lab=UA0}
N 10800 10 10780 10 {lab=UA0}
C {devices/lab_pin.sym} 10780 10 0 0 {name=l59 sig_type=std_logic lab=UA0}
C {devices/code_shown.sym} -400 -420 0 0 {name=s1 only_toplevel=false value=".option reltol=1e-4 abstol=1e-13 vntol=1e-7 gmin=1e-15 method=gear
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
C {sky130_fd_pr/corner.sym} -400 -620 0 0 {name=CORNER only_toplevel=true corner=tt}
T {tb_top_transition - live reconfiguration MIRROR grouped -> MIRROR centroid while 10 uA flows.
Controller timing (from the RTL, clk = 10 MHz, APPLY at 2.0 us):
2.5 us  EN_MG -> 0                   (STOP state end: paths open)
2.9 us  CLR_MG -> 1, CLR_MC -> 0     (QUIET end: clamps follow the new configuration)
3.2 us  EN_MC -> 1                   (CONNECT)
ua0: 10 uA source with 1.8 V compliance (GCMP bleeds current above 1.8 V).
ua4: servo, an integrator (GINT into CINT, about 160 kHz unity-gain bandwidth) forcing
V(OUT internal, sensed on ua2) = V(REF, sensed on ua3).
Measured: vp0max = highest ua0 voltage during the change, iout_g / iout_c = output current
before / after, tsettle = time after CONNECT until the current is within 1e-4 of its final
value, ipk = peak servo current. wrdata writes transition.dat (P0, P3, i(VM4), REF_G, REF_C).} -400 -1115 0 0 0.4 0.4 {}
