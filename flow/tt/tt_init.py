#!/usr/bin/env python3
"""Set up or rename the Tiny Tapeout top cell, keeping every place that names it consistent.

    tt_init.py init   [tt_um_new_name]     set top_module (optional), fix src/project.v,
                                           create cells/<top>/layout/<top>.gds shell if missing
    tt_init.py rename tt_um_new_name       rename everywhere: info.yaml, src/project.v,
                                           cells/<old>/ -> cells/<new>/ (git mv), GDS top cell,
                                           gds/ and lef/ files

The top module name appears in six places that Tiny Tapeout requires to agree:
info.yaml top_module, src/project.v module, gds/<top>.gds file name + top cell, lef/<top>.lef
file name + MACRO. This tool is the only thing that should change them.
"""
import os
import re
import subprocess
import sys

_here = os.environ.get("KPY_DIR") or os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, _here)
from tt_common import FLOW_ROOT, TTError, load_info, run_main  # noqa: E402

NAME_RE = re.compile(r"tt_um_[A-Za-z0-9_]+")


def _set_info_top(new):
    path = os.path.join(FLOW_ROOT, "info.yaml")
    s = open(path, encoding="utf-8", errors="replace").read()
    s2, n = re.subn(r'^(\s*top_module:\s*)"[^"]*"', rf'\g<1>"{new}"', s, count=1, flags=re.M)
    if n != 1:
        raise TTError('could not find the line  top_module: "..."  in info.yaml')
    if s2 != s:
        open(path, "w", encoding="utf-8").write(s2)


def _fix_verilog(top, uses_vapwr):
    path = os.path.join(FLOW_ROOT, "src", "project.v")
    s = open(path, encoding="utf-8", errors="replace").read()
    s2, n = re.subn(r"^(\s*module\s+)\w+", rf"\g<1>{top}", s, count=1, flags=re.M)
    if n != 1:
        raise TTError("could not find 'module ...' in src/project.v")
    lines = s2.split("\n")
    for i, line in enumerate(lines):
        if re.search(r"\bVAPWR\b", line) and re.search(r"\b(input|inout)\b", line):
            body = re.sub(r"^\s*(//\s*)?", "", line)
            lines[i] = ("    " if uses_vapwr else "//    ") + body
    s2 = "\n".join(lines)
    if s2 != s:
        open(path, "w", encoding="utf-8").write(s2)


def _git(*args):
    return subprocess.run(["git", "-C", FLOW_ROOT, *args], capture_output=True, text=True)


def _kpy(script, *args):
    return subprocess.call([os.path.join(_here, "kpy"), os.path.join(_here, script), *args])


def init(args):
    if args:
        if not NAME_RE.fullmatch(args[0]):
            raise TTError(f"{args[0]!r}: name must look like tt_um_<you>_<project>")
        _set_info_top(args[0])
    info = load_info()
    top = info.top_module
    if top == "tt_um_example" or not NAME_RE.fullmatch(top):
        raise TTError(f"top_module is {top!r}; choose a name: make tt-init TOP=tt_um_<you>_<project>")
    _fix_verilog(top, info.uses_vapwr)
    gds = os.path.join(FLOW_ROOT, "cells", top, "layout", f"{top}.gds")
    if os.path.exists(gds):
        print(f"tt-init: {os.path.relpath(gds, FLOW_ROOT)} exists, kept as is")
    else:
        rc = _kpy("tt_shell.py", "init", gds)
        if rc:
            return rc
    print(f"tt-init: top module {top}: info.yaml and src/project.v agree"
          f"{' (VAPWR enabled)' if info.uses_vapwr else ''}")
    return 0


def rename(args):
    if len(args) != 1 or not NAME_RE.fullmatch(args[0]):
        raise TTError("usage: make tt-rename NEW=tt_um_<you>_<project>")
    new = args[0]
    info = load_info()
    old = info.top_module
    if old == new:
        print(f"tt-rename: already {new}")
        return 0
    old_dir, new_dir = (os.path.join(FLOW_ROOT, "cells", n) for n in (old, new))
    if os.path.exists(new_dir):
        raise TTError(f"cells/{new} already exists")
    in_git = _git("rev-parse", "--is-inside-work-tree").returncode == 0
    if os.path.isdir(old_dir):
        if in_git and _git("mv", f"cells/{old}", f"cells/{new}").returncode == 0:
            pass
        else:
            os.rename(old_dir, new_dir)
        for root, _dirs, files in os.walk(new_dir):
            for f in files:
                stem, ext = os.path.splitext(f)
                if stem in (old, f"tb_{old}"):
                    src = os.path.join(root, f)
                    dst = os.path.join(root, stem.replace(old, new) + ext)
                    if not (in_git and _git("mv", os.path.relpath(src, FLOW_ROOT),
                                            os.path.relpath(dst, FLOW_ROOT)).returncode == 0):
                        os.rename(src, dst)
        gds = os.path.join(new_dir, "layout", f"{new}.gds")
        if os.path.isfile(gds):
            if os.access(gds, os.W_OK) is False:
                raise TTError(f"{gds} is read-only: lock it first (git lfs lock cells/{new}/layout/{new}.gds)")
            rc = _kpy("tt_shell.py", "rename", gds, old, new)
            if rc:
                return rc
    for sub, ext in (("gds", "gds"), ("lef", "lef")):
        p = os.path.join(FLOW_ROOT, sub, f"{old}.{ext}")
        if os.path.exists(p):
            if not (in_git and _git("rm", "-q", "-f", f"{sub}/{old}.{ext}").returncode == 0):
                os.remove(p)
    _set_info_top(new)
    _fix_verilog(new, info.uses_vapwr)
    print(f"tt-rename: {old} -> {new} (info.yaml, src/project.v, cells/{new}/, GDS top cell). "
          "Now run: make tt")
    return 0


def main(args):
    try:
        if args and args[0] == "init":
            return init(args[1:])
        if args and args[0] == "rename":
            return rename(args[1:])
        print(__doc__, file=sys.stderr)
        return 2
    except TTError as e:
        print(f"tt-init: ERROR: {e}", file=sys.stderr)
        return 1


run_main(__name__, main)
