gds read /foss/designs/ELAD-1/cells/ELAD1_CLAMP/layout/ELAD1_CLAMP.gds
load ELAD1_CLAMP
select top cell
port makeall
flatten ELAD1_CLAMP_flat
load ELAD1_CLAMP_flat
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
ext2spice -o ELAD1_CLAMP_rc.spice
quit -noprompt
