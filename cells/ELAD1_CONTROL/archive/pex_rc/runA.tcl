gds read /foss/designs/ELAD-1/cells/ELAD1_CONTROL/layout/ELAD1_CONTROL.gds
load ELAD1_CONTROL
select top cell
port makeall
flatten ELAD1_CONTROL_flat
load ELAD1_CONTROL_flat
select top cell
extract do local
extract all
ext2sim labels on
ext2sim
extresist tolerance 0
extresist threshold 0
extresist mindelay 0
extresist minres 0
extresist all
ext2spice cthresh 0
ext2spice rthresh 0
ext2spice extresist on
ext2spice -o ELAD1_CONTROL_rc.spice
quit -noprompt
