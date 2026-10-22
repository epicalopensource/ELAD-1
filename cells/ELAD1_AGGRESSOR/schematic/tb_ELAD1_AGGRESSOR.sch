v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/vsource.sym} 0 200 0 0 {name=VSUP value=1.8}
C {devices/res.sym} 0 0 2 1 {name=RPDN value=5}
C {devices/vsource.sym} 240 200 0 0 {name=VCK value="PULSE(0 1.8 0 100p 100p 99.9n 200n)"}
C {ELAD1_AGGRESSOR.sym} 810 100 0 0 {name=XDUT}
N 0 270 240 270 {lab=0}
N 0 230 0 270 {lab=0}
N 240 230 240 270 {lab=0}
C {devices/gnd.sym} 0 270 0 0 {name=l1 lab=0 global=false}
N 0 -30 0 -50 {lab=VDPWR}
C {devices/vdd.sym} 0 -50 0 0 {name=l2 lab=VDPWR global=false}
N 720 110 700 110 {lab=VDPWR}
C {devices/lab_pin.sym} 700 110 0 0 {name=l3 sig_type=std_logic lab=VDPWR}
N 900 90 920 90 {lab=0}
C {devices/lab_pin.sym} 920 90 0 1 {name=l4 sig_type=std_logic lab=0}
N 0 170 0 130 {lab=VSUP}
N 0 30 0 130 {lab=VSUP}
C {devices/lab_pin.sym} 0 130 0 0 {name=l5 sig_type=std_logic lab=VSUP}
N 240 170 240 130 {lab=AGG_CLK}
N 720 90 680 90 {lab=AGG_CLK}
N 680 90 680 130 {lab=AGG_CLK}
N 240 130 680 130 {lab=AGG_CLK}
C {devices/lab_pin.sym} 240 130 0 0 {name=l6 sig_type=std_logic lab=AGG_CLK}
C {devices/code_shown.sym} -400 -360 0 0 {name=s1 only_toplevel=false value=".control
tran 50p 1.2u
let idd = -i(VSUP)
meas tran iavg avg idd from=0.2u to=1.2u
meas tran ipk max idd from=0.2u to=1.2u
meas tran vloc_min min v(VDPWR) from=0.2u to=1.2u
meas tran vloc_max max v(VDPWR) from=0.2u to=1.2u
let vloc_pp = vloc_max-vloc_min
meas tran o0_min min v(xdut.o0) from=0.2u to=1.2u
meas tran o0_max max v(xdut.o0) from=0.2u to=1.2u
print vloc_pp
write tb_ELAD1_AGGRESSOR.raw
.endc"}
C {sky130_fd_pr/corner.sym} -400 -560 0 0 {name=CORNER only_toplevel=true corner=tt}
T {tb_ELAD1_AGGRESSOR - controlled switching aggressor (4 inverters + MOS-cap loads).
AGG_CLK: 5 MHz square wave (clk 10 MHz / 2). Supply through RPDN 5 ohm (local rail model).
Checks: average and peak supply current, local rail disturbance, and that the bank toggles.} -400 -855 0 0 0.4 0.4 {}
