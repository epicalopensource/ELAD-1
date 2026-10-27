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
N 20 180 40 180 {}
N 40 180 60 180 {}
N 60 180 90 180 {}
N 150 180 180 180 {}
N 300 180 300 200 {}
N 180 180 300 180 {}
N 300 180 330 180 {}
N 390 180 420 180 {}
N 540 160 540 180 {}
N 420 180 540 180 {}
N 540 180 570 180 {}
N 630 180 660 180 {}
N -20 180 -20 200 {}
N -120 490 -100 490 {}
N -100 490 -80 490 {}
N -110 450 -80 450 {}
N 20 530 40 530 {}
N 40 530 60 530 {}
N 180 530 180 550 {}
N 180 610 180 630 {}
N 60 530 180 530 {}
N 180 530 210 530 {}
N 270 530 300 530 {}
N 420 530 420 550 {}
N 420 610 420 630 {}
N 540 530 540 550 {}
N 300 530 420 530 {}
N 420 530 540 530 {}
N -20 530 -20 550 {}
N -100 820 -80 820 {}
N -80 820 -60 820 {}
N -220 820 -220 840 {}
N -220 820 -100 820 {}
N -250 820 -220 820 {}
N -340 820 -310 820 {}
N -460 820 -460 840 {}
N -460 820 -340 820 {}
N -490 820 -460 820 {}
N -580 820 -550 820 {}
N -700 820 -700 840 {}
N -700 820 -580 820 {}
N 60 820 90 820 {}
N 0 740 0 760 {}
N 0 880 0 900 {}
N -100 1170 -80 1170 {}
N -80 1170 -60 1170 {}
N -220 1170 -220 1190 {}
N -220 1170 -100 1170 {}
N -250 1170 -220 1170 {}
N -340 1170 -310 1170 {}
N -460 1170 -460 1190 {}
N -580 1170 -580 1190 {}
N -700 1170 -700 1190 {}
N -700 1170 -580 1170 {}
N -580 1170 -460 1170 {}
N -460 1170 -340 1170 {}
N 60 1170 90 1170 {}
N 0 1090 0 1110 {}
N 0 1230 0 1250 {}
N -90 1520 -60 1520 {}
N 60 1520 80 1520 {}
N 80 1520 100 1520 {}
N 220 1520 220 1540 {}
N 100 1520 220 1520 {}
N 220 1520 250 1520 {}
N 310 1520 340 1520 {}
N 460 1520 460 1540 {}
N 580 1520 580 1540 {}
N 340 1520 460 1520 {}
N 460 1520 580 1520 {}
N 0 1440 0 1460 {}
N 0 1580 0 1600 {}
N -90 1870 -60 1870 {}
N 60 1870 80 1870 {}
N 80 1870 100 1870 {}
N 220 1870 220 1890 {}
N 100 1870 220 1870 {}
N 220 1870 250 1870 {}
N 310 1870 340 1870 {}
N 460 1870 460 1890 {}
N 580 1870 580 1890 {}
N 340 1870 460 1870 {}
N 460 1870 580 1870 {}
N 0 1790 0 1810 {}
N 0 1930 0 1950 {}
N -140 2240 -120 2240 {}
N -120 2240 -100 2240 {}
N -260 2240 -260 2260 {}
N -260 2240 -140 2240 {}
N -320 2200 -210 2200 {}
N -210 2200 -100 2200 {}
N -440 2200 -440 2220 {}
N -440 2200 -320 2200 {}
N 100 2220 130 2220 {}
N 0 2280 0 2300 {}
N -580 2450 -580 2470 {}
N -700 2450 -580 2450 {}
N -320 2450 -320 2470 {}
N -440 2450 -320 2450 {}
N -180 2450 -150 2450 {}
N -90 2450 -60 2450 {}
N 60 2450 60 2470 {}
N -60 2450 60 2450 {}
C {ELAD1_VICTIM_BASELINE.sym} 0 120 0 0 {name=XA}
C {devices/lab_pin.sym} -100 140 0 0 {name=l1 sig_type=std_logic lab=OA}
C {devices/lab_pin.sym} -130 100 0 0 {name=l2 sig_type=std_logic lab=VQ}
C {devices/vsource.sym} -300 150 0 0 {name=VQ value=0.7712}
C {devices/gnd.sym} -300 180 0 0 {name=l3 lab=0 global=false}
C {devices/lab_pin.sym} 40 180 0 1 {name=l4 sig_type=std_logic lab=SVA}
C {devices/res.sym} 120 180 3 0 {name=RL2 value=500}
C {devices/lab_pin.sym} 180 180 0 1 {name=l5 sig_type=std_logic lab=SB}
C {devices/res.sym} 300 230 0 0 {name=RBK value=300}
C {devices/gnd.sym} 300 260 0 0 {name=l6 lab=0 global=false}
C {devices/res.sym} 360 180 1 0 {name=RL1 value=500}
C {devices/lab_pin.sym} 420 180 0 1 {name=l7 sig_type=std_logic lab=SA}
C {devices/capa.sym} 540 130 0 0 {name=CNW value=200f}
C {devices/vdd.sym} 540 100 0 0 {name=l8 lab=VDPWR global=false}
C {devices/res.sym} 600 180 1 0 {name=RAT value=100}
C {devices/lab_pin.sym} 660 180 0 1 {name=l9 sig_type=std_logic lab=SUBI}
C {devices/vdd.sym} 0 60 0 0 {name=l10 lab=VDPWR global=false}
C {devices/lab_pin.sym} -20 200 1 1 {name=l11 sig_type=std_logic lab=QG}
C {ELAD1_VICTIM_GUARDED.sym} 0 470 0 0 {name=XB}
C {devices/lab_pin.sym} -100 490 0 0 {name=l12 sig_type=std_logic lab=OB}
C {devices/lab_pin.sym} -110 450 0 0 {name=l13 sig_type=std_logic lab=VQ}
C {devices/lab_pin.sym} 40 530 0 1 {name=l14 sig_type=std_logic lab=SVB}
C {devices/res.sym} 180 580 0 0 {name=RL3 value=500}
C {devices/lab_pin.sym} 180 630 0 1 {name=l15 sig_type=std_logic lab=SB}
C {devices/res.sym} 240 530 3 0 {name=RRG value=50}
C {devices/lab_pin.sym} 300 530 0 1 {name=l16 sig_type=std_logic lab=QG}
C {devices/res.sym} 420 580 2 0 {name=RTA value=1000}
C {devices/lab_pin.sym} 420 630 0 1 {name=l17 sig_type=std_logic lab=SVA}
C {devices/res.sym} 540 580 0 0 {name=RQ value=1}
C {devices/gnd.sym} 540 610 0 0 {name=l18 lab=0 global=false}
C {devices/vdd.sym} 0 410 0 0 {name=l19 lab=VDPWR global=false}
C {devices/lab_pin.sym} -20 550 1 1 {name=l20 sig_type=std_logic lab=QG}
C {ELAD1_TGB.sym} 0 820 0 0 {name=XF}
C {devices/lab_pin.sym} -80 820 0 0 {name=l21 sig_type=std_logic lab=UA0}
C {devices/capa.sym} -220 870 0 0 {name=CI0 value=2.5p}
C {devices/gnd.sym} -220 900 0 0 {name=l22 lab=0 global=false}
C {devices/res.sym} -280 820 1 0 {name=RP0 value=500}
C {devices/lab_pin.sym} -340 820 0 0 {name=l23 sig_type=std_logic lab=P0}
C {devices/capa.sym} -460 870 0 0 {name=CE0 value=2.5p}
C {devices/gnd.sym} -460 900 0 0 {name=l24 lab=0 global=false}
C {devices/res.sym} -520 820 3 0 {name=RSER value=1000}
C {devices/lab_pin.sym} -580 820 0 0 {name=l25 sig_type=std_logic lab=VS}
C {devices/vsource.sym} -700 870 0 0 {name=VINJ value=0}
C {devices/gnd.sym} -700 900 0 0 {name=l26 lab=0 global=false}
C {devices/lab_pin.sym} 90 820 0 1 {name=l27 sig_type=std_logic lab=SUBI}
C {devices/lab_pin.sym} 0 740 0 0 {name=l28 sig_type=std_logic lab=ENB}
C {devices/vdd.sym} 40 760 0 0 {name=l29 lab=VDPWR global=false}
C {devices/lab_pin.sym} 0 900 1 1 {name=l30 sig_type=std_logic lab=EN}
C {devices/gnd.sym} 40 880 0 0 {name=l31 lab=0 global=false}
C {ELAD1_TGB.sym} 0 1170 0 0 {name=XS}
C {devices/lab_pin.sym} -80 1170 0 0 {name=l32 sig_type=std_logic lab=UA2}
C {devices/capa.sym} -220 1220 0 0 {name=CI2 value=2.5p}
C {devices/gnd.sym} -220 1250 0 0 {name=l33 lab=0 global=false}
C {devices/res.sym} -280 1170 1 0 {name=RP2 value=500}
C {devices/lab_pin.sym} -340 1170 0 0 {name=l34 sig_type=std_logic lab=P2}
C {devices/capa.sym} -460 1220 0 0 {name=CE2 value=2.5p}
C {devices/gnd.sym} -460 1250 0 0 {name=l35 lab=0 global=false}
C {devices/res.sym} -580 1220 0 0 {name=RM2 value=1e9}
C {devices/gnd.sym} -580 1250 0 0 {name=l36 lab=0 global=false}
C {devices/capa.sym} -700 1220 0 0 {name=CM2 value=10p}
C {devices/gnd.sym} -700 1250 0 0 {name=l37 lab=0 global=false}
C {devices/lab_pin.sym} 90 1170 0 1 {name=l38 sig_type=std_logic lab=SUBI}
C {devices/lab_pin.sym} 0 1090 0 0 {name=l39 sig_type=std_logic lab=ENB}
C {devices/vdd.sym} 40 1110 0 0 {name=l40 lab=VDPWR global=false}
C {devices/lab_pin.sym} 0 1250 1 1 {name=l41 sig_type=std_logic lab=EN}
C {devices/gnd.sym} 40 1230 0 0 {name=l42 lab=0 global=false}
C {ELAD1_TSW.sym} 0 1520 0 0 {name=XSA}
C {devices/lab_pin.sym} -90 1520 0 0 {name=l43 sig_type=std_logic lab=OA}
C {devices/lab_pin.sym} 80 1520 0 1 {name=l44 sig_type=std_logic lab=PA_I}
C {devices/capa.sym} 220 1570 0 0 {name=CA1 value=2.5p}
C {devices/gnd.sym} 220 1600 0 0 {name=l45 lab=0 global=false}
C {devices/res.sym} 280 1520 3 0 {name=RA value=500}
C {devices/lab_pin.sym} 340 1520 0 1 {name=l46 sig_type=std_logic lab=PA}
C {devices/capa.sym} 460 1570 0 0 {name=CA2 value=10p}
C {devices/gnd.sym} 460 1600 0 0 {name=l47 lab=0 global=false}
C {devices/res.sym} 580 1570 0 0 {name=RMA value=1e9}
C {devices/gnd.sym} 580 1600 0 0 {name=l48 lab=0 global=false}
C {devices/lab_pin.sym} 0 1440 0 0 {name=l49 sig_type=std_logic lab=ENB}
C {devices/vdd.sym} 40 1460 0 0 {name=l50 lab=VDPWR global=false}
C {devices/lab_pin.sym} 0 1600 1 1 {name=l51 sig_type=std_logic lab=EN}
C {devices/gnd.sym} 40 1580 0 0 {name=l52 lab=0 global=false}
C {ELAD1_TSW.sym} 0 1870 0 0 {name=XSB}
C {devices/lab_pin.sym} -90 1870 0 0 {name=l53 sig_type=std_logic lab=OB}
C {devices/lab_pin.sym} 80 1870 0 1 {name=l54 sig_type=std_logic lab=PB_I}
C {devices/capa.sym} 220 1920 0 0 {name=CB1 value=2.5p}
C {devices/gnd.sym} 220 1950 0 0 {name=l55 lab=0 global=false}
C {devices/res.sym} 280 1870 3 0 {name=RB value=500}
C {devices/lab_pin.sym} 340 1870 0 1 {name=l56 sig_type=std_logic lab=PB}
C {devices/capa.sym} 460 1920 0 0 {name=CB2 value=10p}
C {devices/gnd.sym} 460 1950 0 0 {name=l57 lab=0 global=false}
C {devices/res.sym} 580 1920 0 0 {name=RMB value=1e9}
C {devices/gnd.sym} 580 1950 0 0 {name=l58 lab=0 global=false}
C {devices/lab_pin.sym} 0 1790 0 0 {name=l59 sig_type=std_logic lab=ENB}
C {devices/vdd.sym} 40 1810 0 0 {name=l60 lab=VDPWR global=false}
C {devices/lab_pin.sym} 0 1950 1 1 {name=l61 sig_type=std_logic lab=EN}
C {devices/gnd.sym} 40 1930 0 0 {name=l62 lab=0 global=false}
C {ELAD1_AGGRESSOR.sym} 0 2220 0 0 {name=XAG}
C {devices/lab_pin.sym} -120 2240 0 0 {name=l63 sig_type=std_logic lab=EN}
C {devices/vsource.sym} -260 2290 0 0 {name=VEN value=1.8}
C {devices/gnd.sym} -260 2320 0 0 {name=l64 lab=0 global=false}
C {devices/lab_pin.sym} -210 2200 0 0 {name=l65 sig_type=std_logic lab=CK}
C {devices/vsource.sym} -440 2250 0 0 {name=VCK value=0}
C {devices/gnd.sym} -440 2280 0 0 {name=l66 lab=0 global=false}
C {devices/lab_pin.sym} 130 2220 0 1 {name=l67 sig_type=std_logic lab=SUBI}
C {devices/vdd.sym} 0 2160 0 0 {name=l68 lab=VDPWR global=false}
C {devices/lab_pin.sym} 0 2300 1 1 {name=l69 sig_type=std_logic lab=GA}
C {devices/lab_pin.sym} -700 2450 0 0 {name=l70 sig_type=std_logic lab=ENB}
C {devices/vsource.sym} -580 2500 0 0 {name=VENB value=0}
C {devices/gnd.sym} -580 2530 0 0 {name=l71 lab=0 global=false}
C {devices/lab_pin.sym} -440 2450 0 0 {name=l72 sig_type=std_logic lab=GA}
C {devices/res.sym} -320 2500 0 0 {name=RGA value=5}
C {devices/gnd.sym} -320 2530 0 0 {name=l73 lab=0 global=false}
C {devices/vdd.sym} -180 2450 0 0 {name=l74 lab=VDPWR global=false}
C {devices/res.sym} -120 2450 1 0 {name=RPDN value=5}
C {devices/lab_pin.sym} -60 2450 0 1 {name=l75 sig_type=std_logic lab=VSUP}
C {devices/vsource.sym} 60 2500 0 0 {name=VSUP value=1.8}
C {devices/gnd.sym} 60 2530 0 0 {name=l76 lab=0 global=false}
T {tb_substrate_injection - guard-ring experiment with the pin-driven injector (DC).} -740 -242.5 0 0 0.4 0.4 {}
T {SYNTHETIC substrate network (resistor values are assumptions, not a calibrated substrate model):
SUBI tap -RAT- SA -RL1- SB -RBK- ground; victim bodies SVA, SVB -500 ohm- SB; SVA -1k (sparse taps)-
and SVB -50 ohm (guard ring)- quiet ground QG -1 ohm- ground. Edit RRG to try a weaker/stronger ring.
Bench: ua0 forces the tap through 1 kohm (board) + TT path + XF; ua2 senses it through XS into 1 Gohm.
The aggressor is present but idle (AGG_CLK = 0). Sweep ua0 0..+0.6 V (pins stay >= 0 V);
transfer = pad change / tap change between ua0 = +0.1 and +0.5 V.} -740 -197.5 0 0 0.22 0.22 {}
C {devices/code_shown.sym} 860 200 0 0 {name=s1 only_toplevel=false value=".option gmin=1e-15 reltol=1e-6 abstol=1e-15 vntol=1e-8
.control
dc VINJ 0 0.6 0.05
meas dc ph find v(P2) at=0.5
meas dc pl find v(P2) at=0.1
meas dc th find v(SUBI) at=0.5
meas dc ah find v(PA) at=0.5
meas dc al find v(PA) at=0.1
meas dc bh find v(PB) at=0.5
meas dc bl find v(PB) at=0.1
meas dc z find v(SUBI) at=0
let t_a = (ah-al)/(ph-pl)
let t_b = (bh-bl)/(ph-pl)
let ratio = t_a/t_b
let sense_err = abs(ph-th)
let tap0 = abs(z)
echo ROW inject tap_hi=$&ph t_a=$&t_a t_b=$&t_b ratio=$&ratio sense_err=$&sense_err tap0=$&tap0
.endc"}
C {sky130_fd_pr/corner.sym} 860 0 0 0 {name=CORNER only_toplevel=true corner=tt}
