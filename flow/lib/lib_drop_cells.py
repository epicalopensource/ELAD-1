#!/usr/bin/env python3
"""Copy a Liberty file without the cells whose name contains a substring.
   lib_drop_cells.py <in.lib> <out.lib> <substring>   (e.g. lpflow: power-management cells
   that yosys 0.33 'abc' would otherwise use as plain logic; it has no -dont_use option)."""
import re, sys
src, dst, sub = sys.argv[1:4]
s = open(src).read()
pat = re.compile(r'\n\s*cell\s*\(\s*"?([^")\s]+)"?\s*\)\s*\{')
out, pos, n = [], 0, 0
while True:
    m = pat.search(s, pos)
    if not m:
        out.append(s[pos:]); break
    out.append(s[pos:m.start()])
    depth, j = 0, m.end() - 1
    while True:
        if s[j] == '{': depth += 1
        elif s[j] == '}':
            depth -= 1
            if depth == 0: break
        j += 1
    if sub in m.group(1): n += 1
    else: out.append(s[m.start():j + 1])
    pos = j + 1
open(dst, 'w').write(''.join(out))
print(f'lib_drop_cells: removed {n} cells containing "{sub}" -> {dst}')
