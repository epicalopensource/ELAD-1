v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {tb_ELAD1_NUNIT - matching unit W/L 2/1 um, diode-connected as in the mirror REF branch.} -260 -175 0 0 0.4 0.4 {}
T {I1 forces 1.25 uA per unit (= IREF 5 uA over 4 units). Sweep 0.1-10 uA for the plot.
Checks: VGS, threshold voltage and gm/ID at 1.25 uA (package tt 27C: VGS 0.632 V, VTH 0.603 V).} -260 -130 0 0 0.22 0.22 {}
N -100 120 -80 120 {lab=G}
N -80 120 -60 120 {lab=G}
N -220 120 -220 140 {lab=G}
N -220 120 -100 120 {lab=G}
N 60 120 90 120 {lab=0}
N 0 40 0 60 {lab=D}
N -0 40 170 40 {lab=D}
N 170 100 170 120 {lab=0}
C {ELAD1_NUNIT.sym} 0 120 0 0 {name=XDUT}
C {devices/lab_pin.sym} -80 120 0 0 {name=l1 sig_type=std_logic lab=G}
C {vsource.sym} -220 170 0 0 {name=VGS value= 0.7}
C {devices/gnd.sym} -220 200 0 0 {name=l2 lab=0 global=false}
C {devices/gnd.sym} 90 120 0 0 {name=l3 lab=0 global=false}
C {devices/lab_pin.sym} 0 40 0 0 {name=l4 sig_type=std_logic lab=D}
C {devices/gnd.sym} 0 180 0 0 {name=l5 lab=0 global=false}
C {devices/code_shown.sym} 290 180 0 0 {name=s1 only_toplevel=false value=".option temp=27
.param W=2
.param LEN=1
.save all
.control
set vdsv = 0.9
dc VGS 0 1.2 1m
let id = -i(VDS)
let gm = deriv(id)
let gmid = gm/id
meas dc vgs find v(G) when id=1.25e-6
meas dc gm_id find gmid when id=1.25e-6
meas dc vth find v(G) when id=5.6e-7
.endc "
}
C {sky130_fd_pr/corner.sym} 290 -20 0 0 {name=CORNER only_toplevel=true corner=tt}
C {vsource.sym} 170 70 0 0 {name=VDS value= 0.9}
C {devices/gnd.sym} 170 120 0 0 {name=l6 lab=0 global=false}
