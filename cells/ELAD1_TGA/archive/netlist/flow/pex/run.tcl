gds read /foss/designs/ELAD-1/cells/ELAD1_TGA/layout/ELAD1_TGA.gds
load ELAD1_TGA
select top cell
port makeall
flatten ELAD1_TGA_flat
load ELAD1_TGA_flat
select top cell
extract do local
extract all
ext2spice cthresh 0
ext2spice -o ELAD1_TGA_pex.spice
quit -noprompt
