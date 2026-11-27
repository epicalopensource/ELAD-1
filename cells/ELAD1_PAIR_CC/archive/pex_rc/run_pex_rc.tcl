gds read ../layout/ELAD1_PAIR_CC.gds
load ELAD1_PAIR_CC
flatten ELAD1_PAIR_CC_flat
load ELAD1_PAIR_CC_flat
select top cell
port makeall
extract do local
extract all
ext2sim labels on
ext2sim
extresist threshold 0
extresist mindelay 0
extresist minres 0
extresist silent off
extresist debug on
extresist all
ext2spice cthresh 0
ext2spice rthresh 0
ext2spice extresist on
ext2spice -o ELAD1_PAIR_CC_rc.spice
quit -noprompt
