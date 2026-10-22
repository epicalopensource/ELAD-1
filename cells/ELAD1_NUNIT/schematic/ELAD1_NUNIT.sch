v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -120 -80 20 -80 {}
N 20 -80 20 -30 {}
N -120 0 -20 0 {}
N -120 80 20 80 {}
N 20 30 20 80 {}
N 20 0 60 0 {}
N 60 0 60 40 {}
N 60 40 160 40 {}
C {devices/iopin.sym} -120 -80 0 1 {name=p1 lab=D}
C {devices/iopin.sym} -120 0 0 1 {name=p2 lab=G}
C {devices/iopin.sym} -120 80 0 1 {name=p3 lab=S}
C {devices/iopin.sym} 160 40 0 0 {name=p4 lab=B}
C {sky130_fd_pr/nfet_01v8.sym} 0 0 0 0 {name=M model=nfet_01v8 W=2 L=1 nf=1 mult=1 sa=0 sb=0 sd=0}
T {ELAD1_NUNIT: NMOS matching unit} -120 -170 0 0 0.3 0.3 {}
