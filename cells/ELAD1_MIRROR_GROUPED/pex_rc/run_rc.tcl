gds read ../layout/ELAD1_MIRROR_GROUPED.gds
load ELAD1_MIRROR_GROUPED
select top cell
extract do local
extract all
ext2sim labels on
ext2sim
extresist tolerance 10
extresist
ext2spice cthresh 0
ext2spice rthresh 0
ext2spice extresist on
ext2spice -o ELAD1_MIRROR_GROUPED_rc.spice
quit
