"""Readable ("hand-drawn style") placement and routing for sch_from_spice.py.

Drawing conventions applied, as a designer would draw an analog cell:
  * supplies: high supply at the top, low supply at the bottom; current flows downward.
    Devices are placed on rows by their electrical height between the supplies
    (PMOS loads above differential pairs above tail sources), and series devices are
    stacked in one column so drain-source connections are straight vertical wires.
  * symmetry: a differential pair (same type, same source net, different gates) is drawn
    side by side with its gates facing outward; current-mirror devices (shared gate) face
    each other so their gates join on one bar.
  * supplies are drawn as VDD / GND symbols (a rail when several devices of a row share one),
    bulk terminals get a net label, inputs enter from the left, outputs leave to the right.
  * wires are drawn where they read well; a net whose wiring would be unclear (too many
    crossings, or no clean path) is connected by net labels instead, exactly as people do
    for long connections.

Correctness: every wire candidate is checked against everything already drawn before it is
kept. Different nets may only cross mid-segment at right angles (xschem does not connect
those); any other contact (an end on a wire, a wire through a pin, overlapping collinear
wires, a wire through a device body) rejects the candidate. Nets that cannot be drawn
cleanly fall back to labels, so the result always netlists back to the original circuit.
"""
from __future__ import annotations

import re
from dataclasses import dataclass, field

G = 10            # grid
P = 240           # column pitch
RH = 200          # row pitch
STUB = 20
MAX_CROSS = 3     # a net whose wiring crosses more wires than this is labelled instead

HIGH_RE = re.compile(r"^(v?dd\w*|avdd\w*|dvdd\w*|vcc\w*|vpwr|vdpwr|vapwr|vpb)$", re.I)
LOW_RE = re.compile(r"^(v?ss\w*|avss\w*|dvss\w*|gnd\w*|0|vgnd|vnb|vee)$", re.I)


def esc(v: str) -> str:
    return v.replace("\\", "\\\\").replace("{", "\\{").replace("}", "\\}")


# ---------------------------------------------------------------------------------- parts
@dataclass
class Pin:
    name: str
    sx: float          # symbol coordinates
    sy: float
    net: str
    role: str = "sig"  # top / bot (channel), gate, bulk, sig


@dataclass
class Part:
    el: object
    sym: object
    attrs: dict
    pins: list
    column: bool                  # two channel pins, one above the other
    pmos: bool = False
    nmos: bool = False
    flipx: bool = False
    flipy: bool = False
    row: int = 0
    axis: float = 0.0             # x of the channel pins
    cx: float = 0.0
    cy: float = 0.0
    yval: float = 0.5
    side: bool = False            # passive between two signal nets (e.g. compensation)
    body: tuple = (0, 0, 0, 0)    # body box in symbol coordinates (no pins)

    def xf(self, x, y):
        if self.flipx:
            x = -x
        if self.flipy:
            y = -y
        return self.cx + x, self.cy + y

    def at(self, pin):
        return self.xf(pin.sx, pin.sy)

    def natural(self, pin):
        """Direction a wire leaves this pin."""
        sx, sy = pin.sx, pin.sy
        if abs(sx) >= abs(sy):
            d = (-1 if sx <= 0 else 1, 0)
        else:
            d = (0, -1 if sy < 0 else 1)
        return (-d[0] if self.flipx else d[0], -d[1] if self.flipy else d[1])

    def box(self):
        x1, y1, x2, y2 = self.body
        a, b = self.xf(x1, y1), self.xf(x2, y2)
        return (min(a[0], b[0]), min(a[1], b[1]), max(a[0], b[0]), max(a[1], b[1]))

    def rotflip(self):
        # xschem: rot 2 = 180 deg; flip 1 = mirror in x. Vertical mirror = rot 2 + flip 1.
        if self.flipx and self.flipy:
            return 2, 0
        if self.flipy:
            return 2, 1
        return 0, 1 if self.flipx else 0


def _body_box(sym_path_text):
    return None


def build_parts(placed):
    parts = []
    for el, sym, attrs in placed:
        pins = [Pin(n, x, y, net) for (n, x, y), net in zip(sym.pins, el.nets)]
        tops = [p for p in pins if abs(p.sy) > abs(p.sx) and p.sy < 0]
        bots = [p for p in pins if abs(p.sy) > abs(p.sx) and p.sy > 0]
        column = len(tops) == 1 and len(bots) == 1 and abs(tops[0].sx - bots[0].sx) < 1 \
            and len(pins) <= 4
        if column:
            tops[0].role, bots[0].role = "top", "bot"
            for p in pins:
                if p.role == "sig":
                    p.role = "bulk" if p.name.upper() == "B" else "gate"
        ref = sym.ref.lower()
        part = Part(el, sym, attrs, pins, column, pmos="pfet" in ref, nmos="nfet" in ref)
        part.passive = not ("fet" in ref)
        bx1, by1, bx2, by2 = sym.bbox
        part.body = (bx1 + 3, by1 + 3, bx2 - 3, by2 - 3)
        parts.append(part)
    return parts


# --------------------------------------------------------------------------- classification
def supplies(parts, ports):
    high, low = set(), set()
    nets = {p.net for part in parts for p in part.pins} | set(ports)
    for n in nets:
        if HIGH_RE.match(n):
            high.add(n)
        elif LOW_RE.match(n):
            low.add(n)
    for part in parts:
        for p in part.pins:
            if p.role == "bulk" and p.net not in high | low:
                (high if part.pmos else low if part.nmos else set()).add(p.net)
    return high, low - high


def stack_dist(parts, high, low):
    """Hops along channels from the high supply (dv) and from the low supply (ds), per net."""
    adj = {}
    for part in parts:
        if part.column and not part.side:
            a = [p.net for p in part.pins if p.role == "top"][0]
            b = [p.net for p in part.pins if p.role == "bot"][0]
            adj.setdefault(a, set()).add(b)
            adj.setdefault(b, set()).add(a)

    def bfs(src):
        dist = {n: 0 for n in src}
        todo = list(src)
        while todo:
            n = todo.pop(0)
            for m in adj.get(n, ()):
                if m not in dist and m not in high | low:
                    dist[m] = dist[n] + 1
                    todo.append(m)
        return dist

    return bfs(high), bfs(low)


def levels(parts, high, low):
    """Electrical height of every net: 0 = high supply, 1 = low supply (for orientation)."""
    dv, ds = stack_dist(parts, high, low)
    r = {}
    for n in set(dv) | set(ds):
        if n in high:
            r[n] = 0.0
        elif n in low:
            r[n] = 1.0
        elif n in dv and n in ds:
            r[n] = dv[n] / (dv[n] + ds[n])
        elif n in dv:
            r[n] = dv[n] / (dv[n] + 1.0)
        else:
            r[n] = 1.0 - ds[n] / (ds[n] + 1.0)
    return r


# -------------------------------------------------------------------------------- placement
def place(parts, high, low):
    sup = high | low
    for part in parts:
        if part.column and part.passive:
            chan = {p.net for p in part.pins if p.role in ("top", "bot")}
            part.side = not (chan & sup) and not part.el.name[0].lower() in "vi"
    r = levels(parts, high, low)
    dv, ds = stack_dist(parts, high, low)
    cols = [p for p in parts if p.column and not p.side]
    side = [p for p in parts if p.column and p.side]
    blocks = [p for p in parts if not p.column]
    for part in cols + side:
        t = [p for p in part.pins if p.role == "top"][0]
        b = [p for p in part.pins if p.role == "bot"][0]
        rt, rb = r.get(t.net, 0.5), r.get(b.net, 0.5)
        part.flipy = rt > rb + 1e-9           # keep the higher net on the upper pin
        part.yval = (rt + rb) / 2
    # stack rows: the LONGEST chain of devices from the top supply down to the part (or from
    # the part down to the bottom supply). Longest, not shortest: a precharge switch straight
    # from VDD to an inner node must not pull that node's devices up to the first row.
    def ends(part):
        up = [p.net for p in part.pins if p.role == ("bot" if part.flipy else "top")][0]
        dn = [p.net for p in part.pins if p.role == ("top" if part.flipy else "bot")][0]
        return up, dn
    down, upw = {}, {}
    for part in cols:
        u, d = ends(part)
        if r.get(u, 0.5) < r.get(d, 0.5) - 1e-9:          # strictly downhill: a DAG
            down.setdefault(u, set()).add(d)
            upw.setdefault(d, set()).add(u)

    def longest(start_set, edges):
        memo = {}
        def f(n, depth=0):
            if n in start_set:
                return 0
            if n in memo:
                return memo[n]
            memo[n] = None                                  # cycle guard
            best = None
            for m in edges.get(n, ()):
                v = f(m, depth + 1)
                if v is not None and (best is None or v + 1 > best):
                    best = v + 1
            memo[n] = best
            return best
        return f
    lv, ls = longest(high, upw), longest(low, down)
    depth = 1
    for part in cols:
        u, d = ends(part)
        a, b = lv(u), ls(d)
        if a is not None and b is not None:
            depth = max(depth, a + b + 1)
        elif a is not None:                    # cells tied to one supply only
            depth = max(depth, a + 1)
        elif b is not None:
            depth = max(depth, b + 1)
    for part in cols:
        u, d = ends(part)
        a, b = lv(u), ls(d)
        if a is not None and b is not None:
            part.row = a
        elif a is not None:
            part.row = min(a, depth - 1)
        elif b is not None:
            part.row = max(depth - 1 - b, 0)
        else:
            part.row = depth // 2
    nrows = max([p.row for p in cols] + [0]) + 1
    rows = [[] for _ in range(nrows)]
    for part in sorted(cols, key=lambda p: parts.index(p)):
        rows[part.row].append(part)

    # neighbours: parts sharing a non-supply net (channel-channel shares count more)
    sup = high | low

    def links(a, b):
        w = 0
        for pa in a.pins:
            for pb in b.pins:
                if pa.net == pb.net and pa.net not in sup and pa.role != "bulk" and pb.role != "bulk":
                    w += 3 if pa.role in ("top", "bot") and pb.role in ("top", "bot") else 1
        return w

    W = {(id(a), id(b)): links(a, b) for a in cols for b in cols if a is not b}
    pos = {}
    for row in rows:
        for i, part in enumerate(row):
            pos[id(part)] = float(i)
    for _ in range(8):                               # barycentre ordering (Sugiyama)
        for row in rows:
            def bary(part):
                s = n = 0.0
                for q in cols:
                    w = W.get((id(part), id(q)), 0)
                    if w and q.row != part.row:
                        s += w * pos[id(q)]
                        n += w
                return s / n if n else pos[id(part)]
            row.sort(key=bary)
            for i, part in enumerate(row):
                pos[id(part)] = float(i)

    # orientation: mirrors face each other, differential pairs face outward
    for row in rows:
        for a, b in zip(row, row[1:]):
            if not (a.pmos or a.nmos) or not (b.pmos or b.nmos):
                continue
            ga = [p.net for p in a.pins if p.role == "gate"]
            gb = [p.net for p in b.pins if p.role == "gate"]
            if ga and ga == gb:
                a.flipx, b.flipx = True, False           # gates face each other
            else:
                ca = {p.net for p in a.pins if p.role in ("top", "bot")}
                cb = {p.net for p in b.pins if p.role in ("top", "bot")}
                if ca & cb - sup and a.pmos == b.pmos:
                    a.flipx, b.flipx = False, True       # diff pair: gates outward

    # x positions: stacked parts share a column axis; keep order and minimum pitch
    axis = {id(p): pos[id(p)] * P for p in cols}
    for _ in range(12):
        for row in rows:
            want = []
            for part in row:
                nb = [axis[id(q)] for q in cols if q.row != part.row
                      and W.get((id(part), id(q)), 0) >= 3]
                want.append(sum(nb) / len(nb) if nb else axis[id(part)])
            x = None
            for part, w in zip(row, want):
                x = w if x is None else max(w, x + P)
                axis[id(part)] = x
            if row:                                       # re-centre on the wishes
                shift = sum(w - axis[id(p)] for p, w in zip(row, want)) / len(row)
                for part in row:
                    axis[id(part)] += shift
    minx = min(axis.values(), default=0)
    for part in cols:
        part.axis = round((axis[id(part)] - minx) / G) * G
        chan = [p for p in part.pins if p.role == "top"][0].sx
        part.cx = part.axis + (chan if part.flipx else -chan)
        part.cy = part.row * RH
    right = max([p.cx for p in cols], default=0) + P + P // 2
    for part in side:                      # passives between signal nets: a column at the right
        t = [p for p in part.pins if p.role == ("bot" if part.flipy else "top")][0]
        part.row = min(dv.get(t.net, nrows // 2), nrows - 1) if nrows else 0
        part.cx = round(right / G) * G
        part.cy = part.row * RH + RH // 2
        right += P * 2 // 3
    mid = (nrows - 1) * RH / 2
    right += P // 2
    for part in blocks:
        bx1, by1, bx2, by2 = part.sym.bbox
        part.cx = round((right - bx1) / G) * G
        part.cy = round((mid - (by2 - by1) / 2 - by1) / G) * G
        right = part.cx + bx2 + P
        part.row = -1
    return rows


# ---------------------------------------------------------------------------------- checker
class Board:
    def __init__(self):
        self.segs = []      # (net, x1, y1, x2, y2)
        self.pts = []       # (net, x, y) pins and wire ends
        self.boxes = []     # interiors of part bodies

    @staticmethod
    def _on(px, py, s):
        _, x1, y1, x2, y2 = s
        return min(x1, x2) <= px <= max(x1, x2) and min(y1, y2) <= py <= max(y1, y2) and \
            (x1 == x2 == px or y1 == y2 == py)

    def check(self, net, segs, pts):
        """Return number of crossings, or None if the candidate touches another net."""
        cross = 0
        new_pts = list(pts) + [(net, s[1], s[2]) for s in segs] + [(net, s[3], s[4]) for s in segs]
        for s in segs:
            _, x1, y1, x2, y2 = s
            for bx1, by1, bx2, by2 in self.boxes:
                if max(x1, x2) > bx1 and min(x1, x2) < bx2 and max(y1, y2) > by1 and min(y1, y2) < by2:
                    return None
            for o in self.segs:
                if o[0] == net:
                    continue
                _, a1, b1, a2, b2 = o
                vs, vo = x1 == x2, a1 == a2
                if vs == vo:                                   # parallel: overlap forbidden
                    if vs and x1 == a1 and max(min(y1, y2), min(b1, b2)) <= min(max(y1, y2), max(b1, b2)):
                        return None
                    if not vs and y1 == b1 and max(min(x1, x2), min(a1, a2)) <= min(max(x1, x2), max(a1, a2)):
                        return None
                    continue
                h, v = (s, o) if not vs else (o, s)
                hx1, hx2, hy = min(h[1], h[3]), max(h[1], h[3]), h[2]
                vx, vy1, vy2 = v[1], min(v[2], v[4]), max(v[2], v[4])
                if hx1 <= vx <= hx2 and vy1 <= hy <= vy2:
                    if hx1 < vx < hx2 and vy1 < hy < vy2:
                        cross += 1                             # clean crossing
                    else:
                        return None                            # touching: would connect
        for n, px, py in self.pts:
            if n == net:
                continue
            for s in segs:
                if self._on(px, py, s):
                    return None
            for _, qx, qy in new_pts:
                if (qx, qy) == (px, py):
                    return None
        for _, px, py in new_pts:
            for o in self.segs:
                if o[0] != net and self._on(px, py, o):
                    return None
        return cross

    def add(self, net, segs, pts):
        self.segs += [(net,) + tuple(s[1:]) for s in segs]
        self.pts += list(pts) + [(net, s[1], s[2]) for s in segs] + [(net, s[3], s[4]) for s in segs]


# ---------------------------------------------------------------------------------- drawing
def _lab(x, y, net, d, n):
    rot, flip = {(-1, 0): (0, 0), (1, 0): (0, 1), (0, -1): (1, 0), (0, 1): (3, 0)}[d]
    return (f"C {{devices/lab_pin.sym}} {x:g} {y:g} {rot} {flip} "
            f"{{name=l{n} sig_type=std_logic lab={esc(net)}}}")


def _path_segs(net, pts):
    out = []
    for (x1, y1), (x2, y2) in zip(pts, pts[1:]):
        if (x1, y1) != (x2, y2):
            out.append((net, x1, y1, x2, y2))
    return out


def layout(placed, sub, attr_text):
    parts = build_parts(placed)
    ports = list(sub.ports)
    high, low = supplies(parts, ports)
    place(parts, high, low)
    board = Board()
    lines, labels = [], [0]

    def newlab():
        labels[0] += 1
        return labels[0]

    for part in parts:
        rot, flip = part.rotflip()
        lines.append(f"C {{{part.sym.ref}}} {part.cx:g} {part.cy:g} {rot} {flip} {{{attr_text(part.attrs)}}}")
        board.boxes.append(part.box())
        for p in part.pins:
            x, y = part.at(p)
            board.pts.append((p.net, x, y))

    # Supply symbols (vdd.sym, gnd.sym) are global labels in xschem; inside a cell that would
    # make VDPWR/VGND chip-wide nets and disconnect the cell from what its pins are wired to
    # (a testbench driving the VGND pin from node 0 would see a floating ground). Every supply
    # symbol is therefore drawn with global=false: same look, local net, connected via the pin.
    pin_dir = {}            # (part id, pin name) -> handled
    def stub_label(part, p, kind="lab"):
        """A short wire from the pin to a label (or supply symbol). Only a stub that touches no
        other net is drawn; if every direction is blocked, the label sits on the pin itself,
        which connects in xschem without a wire."""
        x, y = part.at(p)
        nat = part.natural(p)
        dirs = [nat] + [d for d in ((-1, 0), (1, 0), (0, -1), (0, 1)) if d != nat]
        for (dx, dy), n in [(d, n) for d in dirs for n in (1, 2, 3)]:
            ex, ey = x + n * STUB * dx, y + n * STUB * dy
            segs, pts = [(p.net, x, y, ex, ey)], [(p.net, ex, ey)]
            if board.check(p.net, segs, pts) is not None:
                break
        else:
            board.add(p.net, [], [(p.net, x, y)])
            lines.append(_lab(x, y, p.net, nat, newlab()))
            return
        board.add(p.net, segs, pts)
        lines.append(f"N {x:g} {y:g} {ex:g} {ey:g} {{lab={esc(p.net)}}}")
        if kind == "vdd" and (dx, dy) == (0, -1):
            lines.append(f"C {{devices/vdd.sym}} {ex:g} {ey:g} 0 0 {{name=l{newlab()} lab={esc(p.net)} global=false}}")
        elif kind == "gnd" and (dx, dy) == (0, 1):
            lines.append(f"C {{devices/gnd.sym}} {ex:g} {ey:g} 0 0 {{name=l{newlab()} lab={esc(p.net)} global=false}}")
        else:
            lines.append(_lab(ex, ey, p.net, (dx, dy), newlab()))

    # ---- supplies: rails per row where possible, else one symbol per pin
    for part in parts:
        for p in part.pins:
            if p.role == "bulk":
                stub_label(part, p)
                pin_dir[(id(part), p.name)] = 1
    groups = {}
    for part in parts:
        for p in part.pins:
            if (id(part), p.name) in pin_dir or p.net not in high | low:
                continue
            x, y = part.at(p)
            d = part.natural(p)
            groups.setdefault((p.net, y, d), []).append((part, p, x))
    for (net, y, d), items in groups.items():
        kind = "vdd" if net in high else "gnd"
        ok_dir = (kind == "vdd" and d == (0, -1)) or (kind == "gnd" and d == (0, 1))
        if ok_dir and len(items) >= 2:
            ry = y + 2 * STUB * d[1]
            xs = sorted(x for _, _, x in items)
            segs = _path_segs(net, [(xs[0], ry)] + [(x, ry) for x in xs[1:]])
            for _, _, x in items:
                segs += _path_segs(net, [(x, y), (x, ry)])
            sx = xs[0]
            pts = [(net, sx, ry)]
            if board.check(net, segs, pts) is not None:
                board.add(net, segs, pts)
                for s in segs:
                    lines.append(f"N {s[1]:g} {s[2]:g} {s[3]:g} {s[4]:g} {{lab={esc(net)}}}")
                sym = "vdd" if kind == "vdd" else "gnd"
                lines.append(f"C {{devices/{sym}.sym}} {sx:g} {ry:g} 0 0 {{name=l{newlab()} lab={esc(net)} global=false}}")
                for part, p, _ in items:
                    pin_dir[(id(part), p.name)] = 1
                continue
        for part, p, _ in items:
            stub_label(part, p, kind if ok_dir else "lab")
            pin_dir[(id(part), p.name)] = 1

    # ---- signal nets: comb (one trunk + branches) or labels
    nets = {}
    for part in parts:
        for p in part.pins:
            if (id(part), p.name) not in pin_dir:
                nets.setdefault(p.net, []).append((part, p))
    port_dir = {p: sub.pininfo.get(p, "B") for p in ports}
    for p in ports:
        if p in high | low:
            port_dir[p] = "B"

    def span(item):
        """Routing order: stack (drain-source) connections first, then small local nets."""
        net, pins = item
        xs = [pt.at(pp)[0] for pt, pp in pins]
        ys = [pt.at(pp)[1] for pt, pp in pins]
        nchan = sum(1 for pt, pp in pins if pp.role in ("top", "bot") and not pt.side)
        return (0 if nchan >= 2 else 1, len(pins), max(xs) - min(xs) + max(ys) - min(ys))

    port_spots = {"L": [], "R": []}
    port_lines = {}                 # net -> port symbol line (written in .subckt order)
    for p in ports:
        if p in high | low:         # supplies are drawn as symbols; their port pin goes left
            port_spots["L"].append(p)
    for net, pins in sorted(nets.items(), key=span):
        port = port_dir.get(net) if net not in high | low else None
        done = False
        for subset in _subsets(pins, port):
            best = None
            for cand in _candidates(net, subset, port):
                c = board.check(net, cand[0], cand[1])
                if c is None or c > MAX_CROSS:
                    continue
                length = sum(abs(s[3] - s[1]) + abs(s[4] - s[2]) for s in cand[0])
                score = c * 400 + length + cand[3]
                if best is None or score < best[0]:
                    best = (score, cand)
            if not best:
                continue
            segs, pts, extra, _ = best[1]
            board.add(net, segs, pts)
            for s in segs:
                lines.append(f"N {s[1]:g} {s[2]:g} {s[3]:g} {s[4]:g} {{lab={esc(net)}}}")
            for kind, x, y in extra:
                if kind == "lab":
                    lines.append(_lab(x, y, net, (-1, 0), newlab()))
                else:                                   # port symbol at a trunk end
                    sym = {"I": "ipin", "O": "opin", "B": "iopin"}[port_dir[net]]
                    body_left = kind == "portL"
                    flip = (0 if body_left else 1) if sym == "ipin" else (1 if body_left else 0)
                    port_lines[net] = (f"C {{devices/{sym}.sym}} {x:g} {y:g} 0 {flip} "
                                       f"{{name=p{newlab()} lab={esc(net)}}}")
            for part, p in pins:                        # pins left out of the wiring: labels
                if not any(part is q and p is pp for q, pp in subset):
                    stub_label(part, p)
            if net in port_dir and net not in port_lines and net not in port_spots["L"] + port_spots["R"]:
                port_spots["R" if port_dir[net] == "O" else "L"].append(net)
            done = True
            break
        if done:
            continue
        for part, p in pins:                       # fall back to labels
            stub_label(part, p)
        if net in port_dir and net not in port_spots["L"] + port_spots["R"]:
            port_spots["R" if port_dir[net] == "O" else "L"].append(net)

    for net in ports:              # ports with nothing attached inside the cell still need a pin
        if net not in port_lines and net not in port_spots["L"] + port_spots["R"]:
            port_spots["R" if port_dir[net] == "O" else "L"].append(net)
    # ports that could not be wired: a column at the left (in) / right (out); they connect by name
    allx = [s[1] for s in board.segs] + [s[3] for s in board.segs] + [b[0] for b in board.boxes] + [0]
    allx2 = [s[1] for s in board.segs] + [s[3] for s in board.segs] + [b[2] for b in board.boxes] + [0]
    ally = [s[2] for s in board.segs] + [b[1] for b in board.boxes] + [0]
    top = round((min(ally)) / G) * G
    for side, nets_ in port_spots.items():
        x = (round(min(allx) / G) * G - 160) if side == "L" else (round(max(allx2) / G) * G + 160)
        for i, net in enumerate(nets_):
            d = port_dir[net]
            sym = {"I": "ipin", "O": "opin", "B": "iopin"}[d]
            flip = 1 if (sym == "iopin" and side == "L") else 0
            port_lines[net] = f"C {{devices/{sym}.sym}} {x:g} {top + 40 * i:g} 0 {flip} {{name=p{newlab()} lab={esc(net)}}}"
    # xschem orders the .subckt ports as the pins appear in the file: keep the netlist's order
    lines += [port_lines[p] for p in ports if p in port_lines]
    return lines


def _subsets(pins, port):
    """Which pins to wire together: all of them, else the local part (labels for the rest)."""
    main = [(q, p) for q, p in pins if q.column and not q.side]
    chan = [(q, p) for q, p in main if p.role in ("top", "bot")]
    gates = [(q, p) for q, p in main if p.role == "gate"]
    rows = sorted({q.row for q, _ in main})
    near = []
    for r in rows:                                  # pins of two neighbouring rows
        near.append([(q, p) for q, p in main if q.row in (r, r + 1)])
    out, seen = [], set()
    for sub in [pins, main, chan + gates] + sorted(near, key=len, reverse=True) + [chan, gates]:
        key = tuple(sorted((id(q), p.name) for q, p in sub))
        if key in seen or (len(sub) < 2 and not (port and sub)):
            continue
        seen.add(key)
        out.append(sub)
    return out


def _candidates(net, pins, port):
    """Comb routings: one horizontal trunk, a branch from every pin.
    Yields (segs, pts, extras, penalty)."""
    at = [(part, p, part.at(p), part.natural(p)) for part, p in pins]
    ys = sorted({y for _, _, (x, y), _ in at})
    rows = sorted({part.cy for part, *_ in at})
    cand_y = set()
    for _, _, (x, y), (dx, dy) in at:
        if dy == 0:
            cand_y.add(y)
    for cy in rows:
        for off in (-RH // 2, RH // 2):
            for k in (0, -1, 1, -2, 2, -3, 3):
                cand_y.add(cy + off + k * G)
    if port == "I":
        ends = [("L", 0), ("R", 40), (None, 300)]
    elif port == "O":
        ends = [("R", 0), (None, 300), ("L", 350)]      # an output never enters from the left
    elif port == "B":
        ends = [("L", 0), ("R", 20), (None, 300)]
    else:
        ends = [(None, 0)]
    for yt in sorted(cand_y, key=lambda v: sum(abs(v - y) for y in ys)):
        for stub_len in (STUB, 2 * STUB):
            segs, xe = [], []
            for part, p, (x, y), (dx, dy) in at:
                if dy != 0:
                    if (yt - y) * dy >= 0:
                        path = [(x, y), (x, yt)]
                    else:                                  # leave, step aside, come back
                        bx1, _, bx2, _ = part.box()
                        side = -1 if x <= part.cx else 1
                        xo = (bx1 - STUB) if side < 0 else (bx2 + STUB)
                        xo = round(xo / G) * G
                        path = [(x, y), (x, y + STUB * dy), (xo, y + STUB * dy), (xo, yt)]
                else:
                    xs = x + stub_len * dx
                    path = [(x, y), (xs, y), (xs, yt)]
                segs += _path_segs(net, path)
                xe.append(path[-1][0])
            for (end, penalty), reach in [(e, r) for e in ends for r in (60, 90, 120)
                                          if e[0] or r == 60]:
                xs = sorted(set(xe))
                extras, pts = [], []
                if end == "L":
                    px = xs[0] - reach
                    xs = [px] + xs
                    extras.append(("portL", px, yt))
                    pts.append((net, px, yt))
                elif end == "R":
                    px = xs[-1] + reach
                    xs = xs + [px]
                    extras.append(("portR", px, yt))
                    pts.append((net, px, yt))
                else:
                    extras.append(("lab", xs[0], yt))      # keep the designer's net name
                    pts.append((net, xs[0], yt))
                trunk = [(net, a, yt, b, yt) for a, b in zip(xs, xs[1:])]
                yield segs + trunk, pts, extras, penalty
