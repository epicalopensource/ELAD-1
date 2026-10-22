v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -120 120 -100 120 {}
N -100 120 -80 120 {}
N -240 120 -240 140 {}
N -240 120 -120 120 {}
N -240 350 -210 350 {}
N -150 350 -120 350 {}
N 0 350 0 370 {}
N -120 350 0 350 {}
C {ELAD1_AGGRESSOR.sym} 0 120 0 0 {name=XDUT}
C {devices/lab_pin.sym} -100 120 0 0 {name=l1 sig_type=std_logic lab=AGG_CLK}
C {devices/vsource.sym} -240 170 0 0 {name=VCK value="PULSE(0 1.8 0 100p 100p 99.9n 200n)"}
C {devices/gnd.sym} -240 200 0 0 {name=l2 lab=0 global=false}
C {devices/vdd.sym} 0 60 0 0 {name=l3 lab=VDPWR global=false}
C {devices/gnd.sym} 0 180 0 0 {name=l4 lab=0 global=false}
C {devices/vdd.sym} -240 350 0 0 {name=l5 lab=VDPWR global=false}
C {devices/res.sym} -180 350 1 0 {name=RPDN value=5}
C {devices/lab_pin.sym} -120 350 0 1 {name=l6 sig_type=std_logic lab=VSUP}
C {devices/vsource.sym} 0 400 0 0 {name=VSUP value=1.8}
C {devices/gnd.sym} 0 430 0 0 {name=l7 lab=0 global=false}
T {tb_ELAD1_AGGRESSOR - controlled switching aggressor (4 inverters + MOS-cap loads).} -280 -155 0 0 0.4 0.4 {}
T {AGG_CLK: 5 MHz square wave (clk 10 MHz / 2). Supply through RPDN 5 ohm (local rail model).
Checks: average and peak supply current, local rail disturbance, and that the bank toggles.} -280 -110 0 0 0.22 0.22 {}
C {devices/code_shown.sym} 200 200 0 0 {name=s1 only_toplevel=false value=".control
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
C {sky130_fd_pr/corner.sym} 200 0 0 0 {name=CORNER only_toplevel=true corner=tt}
