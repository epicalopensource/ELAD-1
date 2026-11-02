v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {devices/iopin.sym} -600 0 0 1 {name=p1 lab=PAD0}
N -600 0 -540 0 {lab=PAD0}
C {devices/lab_pin.sym} -540 0 0 1 {name=lp1 sig_type=std_logic lab=PAD0}
C {devices/iopin.sym} -600 40 0 1 {name=p2 lab=PAD1}
N -600 40 -540 40 {lab=PAD1}
C {devices/lab_pin.sym} -540 40 0 1 {name=lp2 sig_type=std_logic lab=PAD1}
C {devices/iopin.sym} -600 80 0 1 {name=p3 lab=PAD2}
N -600 80 -540 80 {lab=PAD2}
C {devices/lab_pin.sym} -540 80 0 1 {name=lp3 sig_type=std_logic lab=PAD2}
C {devices/iopin.sym} -600 120 0 1 {name=p4 lab=PAD3}
N -600 120 -540 120 {lab=PAD3}
C {devices/lab_pin.sym} -540 120 0 1 {name=lp4 sig_type=std_logic lab=PAD3}
C {devices/iopin.sym} -600 160 0 1 {name=p5 lab=PAD4}
N -600 160 -540 160 {lab=PAD4}
C {devices/lab_pin.sym} -540 160 0 1 {name=lp5 sig_type=std_logic lab=PAD4}
C {devices/iopin.sym} -600 200 0 1 {name=p6 lab=PAD5}
N -600 200 -540 200 {lab=PAD5}
C {devices/lab_pin.sym} -540 200 0 1 {name=lp6 sig_type=std_logic lab=PAD5}
C {devices/iopin.sym} -600 240 0 1 {name=p7 lab=UA0}
N -600 240 -540 240 {lab=UA0}
C {devices/lab_pin.sym} -540 240 0 1 {name=lp7 sig_type=std_logic lab=UA0}
C {devices/iopin.sym} -600 280 0 1 {name=p8 lab=UA1}
N -600 280 -540 280 {lab=UA1}
C {devices/lab_pin.sym} -540 280 0 1 {name=lp8 sig_type=std_logic lab=UA1}
C {devices/iopin.sym} -600 320 0 1 {name=p9 lab=UA2}
N -600 320 -540 320 {lab=UA2}
C {devices/lab_pin.sym} -540 320 0 1 {name=lp9 sig_type=std_logic lab=UA2}
C {devices/iopin.sym} -600 360 0 1 {name=p10 lab=UA3}
N -600 360 -540 360 {lab=UA3}
C {devices/lab_pin.sym} -540 360 0 1 {name=lp10 sig_type=std_logic lab=UA3}
C {devices/iopin.sym} -600 400 0 1 {name=p11 lab=UA4}
N -600 400 -540 400 {lab=UA4}
C {devices/lab_pin.sym} -540 400 0 1 {name=lp11 sig_type=std_logic lab=UA4}
C {devices/iopin.sym} -600 440 0 1 {name=p12 lab=UA5}
N -600 440 -540 440 {lab=UA5}
C {devices/lab_pin.sym} -540 440 0 1 {name=lp12 sig_type=std_logic lab=UA5}
C {devices/iopin.sym} -600 480 0 1 {name=p13 lab=VDPWR}
N -600 480 -540 480 {lab=VDPWR}
C {devices/lab_pin.sym} -540 480 0 1 {name=lp13 sig_type=std_logic lab=VDPWR}
C {devices/iopin.sym} -600 520 0 1 {name=p14 lab=VGND}
N -600 520 -540 520 {lab=VGND}
C {devices/lab_pin.sym} -540 520 0 1 {name=lp14 sig_type=std_logic lab=VGND}
C {ELAD1_PINPROT.sym} 0 0 0 0 {name=xprot0}
N -80 0 -120 0 {lab=PAD0}
C {devices/lab_pin.sym} -120.0 0.0 0 0 {name=l1 sig_type=std_logic lab=PAD0}
N 80 0 120 0 {lab=UA0}
C {devices/lab_pin.sym} 120.0 0.0 0 1 {name=l2 sig_type=std_logic lab=UA0}
N 0 -60 0 -100 {lab=VDPWR}
C {devices/lab_pin.sym} 0.0 -100.0 3 0 {name=l3 sig_type=std_logic lab=VDPWR}
N 0 60 0 100 {lab=VGND}
C {devices/lab_pin.sym} 0.0 100.0 1 0 {name=l4 sig_type=std_logic lab=VGND}
C {ELAD1_PINPROT.sym} 0 220 0 0 {name=xprot1}
N -80 220 -120 220 {lab=PAD1}
C {devices/lab_pin.sym} -120.0 220.0 0 0 {name=l5 sig_type=std_logic lab=PAD1}
N 80 220 120 220 {lab=UA1}
C {devices/lab_pin.sym} 120.0 220.0 0 1 {name=l6 sig_type=std_logic lab=UA1}
N 0 160 0 120 {lab=VDPWR}
C {devices/lab_pin.sym} 0.0 120.0 3 0 {name=l7 sig_type=std_logic lab=VDPWR}
N 0 280 0 320 {lab=VGND}
C {devices/lab_pin.sym} 0.0 320.0 1 0 {name=l8 sig_type=std_logic lab=VGND}
C {ELAD1_PINPROT.sym} 0 440 0 0 {name=xprot2}
N -80 440 -120 440 {lab=PAD2}
C {devices/lab_pin.sym} -120.0 440.0 0 0 {name=l9 sig_type=std_logic lab=PAD2}
N 80 440 120 440 {lab=UA2}
C {devices/lab_pin.sym} 120.0 440.0 0 1 {name=l10 sig_type=std_logic lab=UA2}
N 0 380 0 340 {lab=VDPWR}
C {devices/lab_pin.sym} 0.0 340.0 3 0 {name=l11 sig_type=std_logic lab=VDPWR}
N 0 500 0 540 {lab=VGND}
C {devices/lab_pin.sym} 0.0 540.0 1 0 {name=l12 sig_type=std_logic lab=VGND}
C {ELAD1_PINPROT.sym} 0 660 0 0 {name=xprot3}
N -80 660 -120 660 {lab=PAD3}
C {devices/lab_pin.sym} -120.0 660.0 0 0 {name=l13 sig_type=std_logic lab=PAD3}
N 80 660 120 660 {lab=UA3}
C {devices/lab_pin.sym} 120.0 660.0 0 1 {name=l14 sig_type=std_logic lab=UA3}
N 0 600 0 560 {lab=VDPWR}
C {devices/lab_pin.sym} 0.0 560.0 3 0 {name=l15 sig_type=std_logic lab=VDPWR}
N 0 720 0 760 {lab=VGND}
C {devices/lab_pin.sym} 0.0 760.0 1 0 {name=l16 sig_type=std_logic lab=VGND}
C {ELAD1_PINPROT.sym} 0 880 0 0 {name=xprot4}
N -80 880 -120 880 {lab=PAD4}
C {devices/lab_pin.sym} -120.0 880.0 0 0 {name=l17 sig_type=std_logic lab=PAD4}
N 80 880 120 880 {lab=UA4}
C {devices/lab_pin.sym} 120.0 880.0 0 1 {name=l18 sig_type=std_logic lab=UA4}
N 0 820 0 780 {lab=VDPWR}
C {devices/lab_pin.sym} 0.0 780.0 3 0 {name=l19 sig_type=std_logic lab=VDPWR}
N 0 940 0 980 {lab=VGND}
C {devices/lab_pin.sym} 0.0 980.0 1 0 {name=l20 sig_type=std_logic lab=VGND}
C {ELAD1_PINPROT.sym} 0 1100 0 0 {name=xprot5}
N -80 1100 -120 1100 {lab=PAD5}
C {devices/lab_pin.sym} -120.0 1100.0 0 0 {name=l21 sig_type=std_logic lab=PAD5}
N 80 1100 120 1100 {lab=UA5}
C {devices/lab_pin.sym} 120.0 1100.0 0 1 {name=l22 sig_type=std_logic lab=UA5}
N 0 1040 0 1000 {lab=VDPWR}
C {devices/lab_pin.sym} 0.0 1000.0 3 0 {name=l23 sig_type=std_logic lab=VDPWR}
N 0 1160 0 1200 {lab=VGND}
C {devices/lab_pin.sym} 0.0 1200.0 1 0 {name=l24 sig_type=std_logic lab=VGND}
T {ELAD1_IO: local (secondary) ESD clamp on every analog pin} -300 -260 0 0 0.6 0.6 {}
T {PADk = ua[k] side (after the TT pad, analog switch and < 500 ohm path); UAk = core side.
Diodes to VDPWR / VGND per pin, no series resistor (would shift pin readings: heater 0.9 mA, VBIAS).} -300 -200 0 0 0.3 0.3 {}
