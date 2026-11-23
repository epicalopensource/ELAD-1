gds read ../layout/ELAD1_MIRROR_CC.gds
load ELAD1_MIRROR_CC
flatten ELAD1_MIRROR_CC_flat
load ELAD1_MIRROR_CC_flat
select top cell
extract do local
extract all
ext2sim labels on
ext2sim
extresist tolerance 1
extresist
ext2spice cthresh 0
ext2spice rthresh 0
ext2spice extresist on
ext2spice -o ELAD1_MIRROR_CC_rc.spice
quit -noprompt
