gds read ../layout/ELAD1_PAIR_GROUPED.gds
load ELAD1_PAIR_GROUPED
flatten ELAD1_PAIR_GROUPED_flat
load ELAD1_PAIR_GROUPED_flat
select top cell
port makeall
extract do local
extract all
ext2sim labels on
ext2sim
extresist threshold 0
extresist mindelay 0
extresist minres 0
extresist all
ext2spice cthresh 0
ext2spice rthresh 0
ext2spice extresist on
ext2spice -o ELAD1_PAIR_GROUPED_rc.spice
quit -noprompt
