v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/vsource.sym} 0 0 0 0 {name=VDD value=1.8}
C {devices/vsource.sym} 240 0 0 0 {name=VQ value="0.771 AC 1"}
C {ELAD1_VICTIM_GUARDED.sym} 810 0 0 0 {name=XDUT}
N 0 -30 0 -50 {lab=VDPWR}
C {devices/vdd.sym} 0 -50 0 0 {name=l1 lab=VDPWR global=false}
N 0 70 240 70 {lab=0}
N 0 30 0 70 {lab=0}
N 240 30 240 70 {lab=0}
C {devices/gnd.sym} 0 70 0 0 {name=l2 lab=0 global=false}
N 720 20 700 20 {lab=VDPWR}
C {devices/lab_pin.sym} 700 20 0 0 {name=l3 sig_type=std_logic lab=VDPWR}
N 900 -20 920 -20 {lab=0}
C {devices/lab_pin.sym} 920 -20 0 1 {name=l4 sig_type=std_logic lab=0}
N 900 0 920 0 {lab=0}
C {devices/lab_pin.sym} 920 0 0 1 {name=l5 sig_type=std_logic lab=0}
N 720 0 700 0 {lab=OUT}
C {devices/lab_pin.sym} 700 0 0 0 {name=l6 sig_type=std_logic lab=OUT}
N 240 -30 240 -70 {lab=VQUIET}
N 720 -20 700 -20 {lab=VQUIET}
N 700 -20 700 -70 {lab=VQUIET}
N 240 -70 700 -70 {lab=VQUIET}
C {devices/lab_pin.sym} 240 -70 0 0 {name=l7 sig_type=std_logic lab=VQUIET}
C {devices/code_shown.sym} -400 -380 0 0 {name=s1 only_toplevel=false value=".control
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
C {sky130_fd_pr/corner.sym} -400 -580 0 0 {name=CORNER only_toplevel=true corner=tt}
T {tb_ELAD1_VICTIM_GUARDED - resistor-loaded common-source victim at its quiet bias.
VQUIET = 0.771 V (package tt 27C value for VOUT = VDD/2); SUBQ tied to ground.
Checks the operating point, low-frequency gain and -3 dB bandwidth (unloaded output).} -400 -875 0 0 0.4 0.4 {}
