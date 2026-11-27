gds read /foss/designs/ELAD-1/cells/ELAD1_TGA/layout/ELAD1_TGA.gds
load ELAD1_TGA
select top cell
port makeall
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
ext2spice -o ELAD1_TGA_rc.spice
quit -noprompt
