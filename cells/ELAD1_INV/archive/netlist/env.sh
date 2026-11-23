#!/bin/bash
export CELL=ELAD1_CONTROL
export CELLDIR=/foss/designs/ELAD-1/cells/$CELL
export PDK_ROOT=${PDK_ROOT:-/foss/pdks}
export LIB=$PDK_ROOT/sky130A/libs.tech/ngspice/sky130.lib.spice
export MAGICRC=$PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc
export SCH=$CELLDIR/netlist/$CELL.spice
export GDS=$(find $CELLDIR -iname "$CELL*.gds" -not -path "*/backups/*" 2>/dev/null | head -1)
export CLOAD=${CLOAD:-10}      # load on every output, fF
export VDD=${VDD:-1.8}
export PINS=$(tr -d '\r' < "$SCH" | awk 'tolower($1)==".subckt" && !f {f=1; s=$0; next} f && /^\+/ {s=s " " substr($0,2); next} f {exit} END{n=split(s,a," "); for(i=3;i<=n;i++) if(a[i] !~ /=/) printf "%s ", a[i]}' 2>/dev/null)
echo "CELL=$CELL"; echo "PINS=[$PINS]"; echo "GDS=[$GDS]"; echo "CLOAD=${CLOAD} fF"
ls -l ${GDS:-/dev/null} "$SCH" "$LIB" "$MAGICRC"
echo "models used by the netlist, found in the ngspice library?"
for m in $(grep -o -E 'sky130_fd_pr__[a-z0-9_]+' "$SCH" | sort -u); do
  if grep -rqsw "$m" $PDK_ROOT/sky130A/libs.tech/ngspice; then echo "  ok       $m"; else echo "  MISSING  $m"; fi
done
