gds read /foss/designs/ELAD-1/cells/ELAD1_TSW/layout/ELAD1_TSW.gds
load ELAD1_TSW
select top cell
port makeall
flatten ELAD1_TSW_flat
load ELAD1_TSW_flat
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
ext2spice -o ELAD1_TSW_rc.spice
quit -noprompt
