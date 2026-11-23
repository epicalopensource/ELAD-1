#!/bin/bash
export CELL=ELAD1_CLAMP
export CELLDIR=/foss/designs/ELAD-1/cells/ELAD1_CLAMP
export PDK_ROOT=${PDK_ROOT:-/foss/pdks}
export LIB=$PDK_ROOT/sky130A/libs.tech/ngspice/sky130.lib.spice
export MAGICRC=$PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc
export SCH=$CELLDIR/netlist/$CELL.spice
export GDS=$(find $CELLDIR -iname "$CELL*.gds" -not -path "*/backups/*" 2>/dev/null | head -1)
export PINS=$(tr -d '\r' < "$SCH" | awk 'tolower($1)==".subckt" && !f {f=1; s=$0; next} f && /^\+/ {s=s " " substr($0,2); next} f {exit} END{n=split(s,a," "); for(i=3;i<=n;i++) if(a[i] !~ /=/) printf "%s ", a[i]}' 2>/dev/null)
echo "CELL=$CELL"; echo "PINS=[$PINS]"; echo "GDS=[$GDS]"
ls -l "$GDS" "$SCH" "$LIB" "$MAGICRC"
