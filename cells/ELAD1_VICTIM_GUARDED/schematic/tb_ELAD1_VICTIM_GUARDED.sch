v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -120 140 -100 140 {}
N -100 140 -80 140 {}
N -180 100 -130 100 {}
N -130 100 -80 100 {}
N -300 100 -300 120 {}
N -300 100 -180 100 {}
N 20 180 50 180 {}
N -180 350 -180 370 {}
N -300 350 -180 350 {}
C {ELAD1_VICTIM_GUARDED.sym} 0 120 0 0 {name=XDUT}
C {devices/lab_pin.sym} -100 140 0 0 {name=l1 sig_type=std_logic lab=OUT}
C {devices/lab_pin.sym} -130 100 0 0 {name=l2 sig_type=std_logic lab=VQUIET}
C {devices/vsource.sym} -300 150 0 0 {name=VQ value="0.771 AC 1"}
C {devices/gnd.sym} -300 180 0 0 {name=l3 lab=0 global=false}
C {devices/gnd.sym} 50 180 0 0 {name=l4 lab=0 global=false}
C {devices/vdd.sym} 0 60 0 0 {name=l5 lab=VDPWR global=false}
C {devices/gnd.sym} -20 180 0 0 {name=l6 lab=0 global=false}
C {devices/vdd.sym} -300 350 0 0 {name=l7 lab=VDPWR global=false}
C {devices/vsource.sym} -180 400 0 0 {name=VDD value=1.8}
C {devices/gnd.sym} -180 430 0 0 {name=l8 lab=0 global=false}
T {tb_ELAD1_VICTIM_GUARDED - resistor-loaded common-source victim at its quiet bias.} -340 -155 0 0 0.4 0.4 {}
T {VQUIET = 0.771 V (package tt 27C value for VOUT = VDD/2); SUBQ tied to ground.
Checks the operating point, low-frequency gain and -3 dB bandwidth (unloaded output).} -340 -110 0 0 0.22 0.22 {}
C {devices/code_shown.sym} 250 200 0 0 {name=s1 only_toplevel=false value=".control
op
let vout = v(OUT)
let id = -i(VDD)
print vout id
ac dec 50 1 10g
let gdb = vdb(OUT)
meas ac gain_db find gdb at=10
let gm3 = gain_db-3
meas ac f3db when gdb=gm3 fall=1
write tb_ELAD1_VICTIM_GUARDED.raw
dc VQ 0.3 1.2 0.001
meas dc vq_mid find v(VQUIET) when v(OUT)=0.9
.endc"}
C {sky130_fd_pr/corner.sym} 250 0 0 0 {name=CORNER only_toplevel=true corner=tt}
