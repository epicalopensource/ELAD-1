v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -140 140 -120 140 {}
N -120 140 -100 140 {}
N -260 140 -260 160 {}
N -260 140 -140 140 {}
N -320 100 -210 100 {}
N -210 100 -100 100 {}
N -440 100 -440 120 {}
N -440 100 -320 100 {}
N 100 120 120 120 {}
N 120 120 140 120 {}
N 260 120 260 140 {}
N 140 120 260 120 {}
N -440 350 -410 350 {}
N -350 350 -320 350 {}
N -200 350 -200 370 {}
N -320 350 -200 350 {}
C {ELAD1_AGGRESSOR.sym} 0 120 0 0 {name=XDUT}
C {devices/lab_pin.sym} -120 140 0 0 {name=l1 sig_type=std_logic lab=EN}
C {devices/vsource.sym} -260 190 0 0 {name=VEN value="PULSE(0 1.8 5u 1n 1n 1 2)"}
C {devices/gnd.sym} -260 220 0 0 {name=l2 lab=0 global=false}
C {devices/lab_pin.sym} -210 100 0 0 {name=l3 sig_type=std_logic lab=AGG_CLK}
C {devices/vsource.sym} -440 150 0 0 {name=VCK value="PULSE(0 1.8 10u 2n 2n 24.998u 50u)"}
C {devices/gnd.sym} -440 180 0 0 {name=l4 lab=0 global=false}
C {devices/lab_pin.sym} 120 120 0 1 {name=l5 sig_type=std_logic lab=SUBI}
C {devices/res.sym} 260 170 0 0 {name=RSUB value=800}
C {devices/gnd.sym} 260 200 0 0 {name=l6 lab=0 global=false}
C {devices/vdd.sym} 0 60 0 0 {name=l7 lab=VDPWR global=false}
C {devices/gnd.sym} 0 180 0 0 {name=l8 lab=0 global=false}
C {devices/vdd.sym} -440 350 0 0 {name=l9 lab=VDPWR global=false}
C {devices/res.sym} -380 350 1 0 {name=RPDN value=5}
C {devices/lab_pin.sym} -320 350 0 1 {name=l10 sig_type=std_logic lab=VSUP}
C {devices/vsource.sym} -200 400 0 0 {name=VSUP value=1.8}
C {devices/gnd.sym} -200 430 0 0 {name=l11 lab=0 global=false}
T {tb_ELAD1_AGGRESSOR - on-chip substrate aggressor: ~90 uA steered into the shared tap SUBI.} -480 -197.5 0 0 0.4 0.4 {}
T {AGG_CLK: 20 kHz square wave (TT clock 40 kHz / 2), EN switched on at 5 us.
SUBI sees 800 ohm to ground (stand-in for the substrate spreading resistance of the tap island).
Supply through RPDN 5 ohm. Checks: off current, current in both states (equal: steered, not switched),
tap step, supply ripple, and that X never rises (the two switches overlap, never both open).} -480 -152.5 0 0 0.22 0.22 {}
C {devices/code_shown.sym} 460 200 0 0 {name=s1 only_toplevel=false value=".control
tran 20n 110u
let idd = -i(VSUP)
meas tran i_off avg idd from=1u to=4.5u
meas tran i_inj avg idd from=80u to=84.9u
meas tran i_dum avg idd from=105u to=109.9u
meas tran v_tap_hi avg v(SUBI) from=80u to=84.9u
meas tran v_tap_lo avg v(SUBI) from=105u to=109.9u
let i_step_pct = 100*(i_inj-i_dum)/i_dum
let v_tap_step = v_tap_hi-v_tap_lo
print i_step_pct v_tap_step
write tb_ELAD1_AGGRESSOR.raw
.endc"}
C {sky130_fd_pr/corner.sym} 460 0 0 0 {name=CORNER only_toplevel=true corner=tt}
