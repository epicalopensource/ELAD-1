gds read ../layout/ELAD1_MIRROR_GROUPED.gds
load ELAD1_MIRROR_GROUPED
flatten ELAD1_MIRROR_GROUPED_flat
load ELAD1_MIRROR_GROUPED_flat
select top cell
extract do local
extract all
ext2sim labels on
ext2sim
extresist tolerance 0.01
extresist
ext2spice cthresh 0
ext2spice rthresh 0
ext2spice extresist on
ext2spice -o ELAD1_MIRROR_GROUPED_rc2.spice
quit
