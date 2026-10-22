v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/isource.sym} 0 0 2 1 {name=I1 value="DC 1.25u"}
C {ELAD1_NUNIT.sym} 560 0 0 0 {name=XDUT}
N 0 30 0 50 {lab=0}
C {devices/gnd.sym} 0 50 0 0 {name=l1 lab=0 global=false}
N 640 -10 660 -10 {lab=0}
C {devices/lab_pin.sym} 660 -10 0 1 {name=l2 sig_type=std_logic lab=0}
N 640 10 660 10 {lab=0}
C {devices/lab_pin.sym} 660 10 0 1 {name=l3 sig_type=std_logic lab=0}
N 0 -30 0 -70 {lab=D}
N 480 -10 460 -10 {lab=D}
N 460 -10 460 -70 {lab=D}
N 480 10 460 10 {lab=D}
N 460 10 460 -70 {lab=D}
N 0 -70 460 -70 {lab=D}
C {devices/lab_pin.sym} 0 -70 0 0 {name=l4 sig_type=std_logic lab=D}
C {devices/code_shown.sym} -400 -280 0 0 {name=s1 only_toplevel=false value=".control
op
let vgs = v(D)
let vth = @m.xdut.xm.msky130_fd_pr__nfet_01v8[vth]
let gm_id = @m.xdut.xm.msky130_fd_pr__nfet_01v8[gm]/1.25e-6
print vgs vth gm_id
dc I1 0.1u 10u 0.1u
write tb_ELAD1_NUNIT.raw
.endc"}
C {sky130_fd_pr/corner.sym} -400 -480 0 0 {name=CORNER only_toplevel=true corner=tt}
T {tb_ELAD1_NUNIT - matching unit W/L 2/1 um, diode-connected as in the mirror REF branch.
I1 forces 1.25 uA per unit (= IREF 5 uA over 4 units). Sweep 0.1-10 uA for the plot.
Checks: VGS, threshold voltage and gm/ID at 1.25 uA (package tt 27C: VGS 0.632 V, VTH 0.603 V).} -400 -775 0 0 0.4 0.4 {}
