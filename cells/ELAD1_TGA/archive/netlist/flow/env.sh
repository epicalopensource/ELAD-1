#!/bin/bash
export CELL=ELAD1_TGA
export CELLDIR=$(cd ../.. && pwd)
export PDK_ROOT=${PDK_ROOT:-/foss/pdks}
export LIB=$PDK_ROOT/sky130A/libs.tech/ngspice/sky130.lib.spice
export MAGICRC=$PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc
export GDS=$CELLDIR/layout/$CELL.gds
export SCH=$CELLDIR/netlist/$CELL.spice
export PINS=$(grep -i -m1 '^\.subckt' "$SCH" 2>/dev/null | awk '{for(i=3;i<=NF;i++) if($i !~ /=/) printf "%s ",$i}')
echo "CELL=$CELL"; echo "PINS=[$PINS]"
ls -l "$GDS" "$SCH" "$LIB" "$MAGICRC"
