"""analog-flow cell libraries: the data model behind the KLayout 'Cell Library' menu.

Storage (all plain files in the project, so git and every teammate see the same libraries):

    <project>/libs/<library>.lib          one file per custom library (first line: description)
    <project>/cells/<cell>/LIBRARY        the library a cell belongs to (one line)
    <project>/cells/<cell>/layout/<cell>.gds   the cell's layout (as before: one folder per cell)

* A cell without a LIBRARY file belongs to the project's default library (KLAYOUT_LIB in
  flow.conf, else the project folder name), which always exists.
* Cells never move on disk: the flow still finds every cell in cells/<cell>/. A library is a
  grouping, like a Virtuoso library over the same cell folders.
* One small file per cell and per library means two people adding cells at the same time never
  edit the same file, so git merges never conflict.
* Library names are unique across all projects in the designs folder; a clash is registered as
  "<name>@<project>" with a warning.

Usable from KLayout (pya) and from plain python3 with the 'klayout' module (tests).
"""
import glob
import os
import re
import subprocess

try:
    import pya as kdb
except ImportError:  # standalone tests
    import klayout.db as kdb

DESIGNS = os.environ.get("AF_DESIGNS_DIR", "/foss/designs")
NAME_RE = re.compile(r"^[A-Za-z_][A-Za-z0-9_]*$")
_DUP_RE = re.compile(r"^(.*)\$\d+$")


class LibError(Exception):
    pass


# ------------------------------------------------------------------------------- projects
class Project:
    def __init__(self, root):
        self.root = os.path.abspath(root)
        self.folder = os.path.basename(self.root)

    @property
    def default_library(self):
        name = _conf_value(os.path.join(self.root, "flow.conf"), "KLAYOUT_LIB")
        return name or re.sub(r"[^A-Za-z0-9_]", "_", self.folder)

    @property
    def libs_dir(self):
        return os.path.join(self.root, "libs")

    @property
    def cells_dir(self):
        return os.path.join(self.root, "cells")

    def __repr__(self):
        return f"Project({self.folder})"


def _conf_value(path, key):
    rx = re.compile(r"^\s*%s\s*\?=\s*(.*\S)\s*$" % re.escape(key))
    value = None
    try:
        with open(path, encoding="utf-8", errors="replace") as f:
            for line in f:
                m = rx.match(line)
                if m:
                    value = m.group(1)
    except OSError:
        pass
    return value


def projects():
    out = []
    for conf in sorted(glob.glob(os.path.join(DESIGNS, "*", "flow.conf"))):
        root = os.path.dirname(conf)
        if os.path.isdir(os.path.join(root, "cells")) or os.path.isdir(os.path.join(root, "flow")):
            out.append(Project(root))
    return out


def project_of_path(path):
    """The project that contains a file (e.g. the layout open in KLayout), or None."""
    path = os.path.abspath(path or "")
    for p in projects():
        if path == p.root or path.startswith(p.root + os.sep):
            return p
    return None


# ------------------------------------------------------------------------------ libraries
def list_libraries(project):
    """{library name: description}, default library first."""
    libs = {project.default_library: "default library of " + project.folder}
    for f in sorted(glob.glob(os.path.join(project.libs_dir, "*.lib"))):
        name = os.path.splitext(os.path.basename(f))[0]
        try:
            with open(f, encoding="utf-8", errors="replace") as fh:
                desc = fh.readline().strip()
        except OSError:
            desc = ""
        libs.setdefault(name, desc)
    return libs


def create_library(project, name, description=""):
    if not NAME_RE.match(name or ""):
        raise LibError(f"library name {name!r}: use letters, digits and _ (start with a letter)")
    if name in list_libraries(project):
        raise LibError(f"library {name} already exists in {project.folder}")
    for other in projects():
        if other.root != project.root and name in list_libraries(other):
            raise LibError(f"library name {name} is already used by project {other.folder}")
    os.makedirs(project.libs_dir, exist_ok=True)
    with open(os.path.join(project.libs_dir, f"{name}.lib"), "w", encoding="utf-8") as f:
        f.write((description or name).strip() + "\n")


def delete_library(project, name):
    if name == project.default_library:
        raise LibError("the default library cannot be deleted")
    members = cells_by_library(project).get(name, [])
    if members:
        raise LibError(f"library {name} still holds {len(members)} cell(s): move them first")
    path = os.path.join(project.libs_dir, f"{name}.lib")
    if not os.path.isfile(path):
        raise LibError(f"no library {name}")
    os.remove(path)


# ----------------------------------------------------------------------------------- cells
def project_cells(project):
    """[(cell, gds path or None)] for real cells (folders not starting with '_')."""
    out = []
    for d in sorted(glob.glob(os.path.join(project.cells_dir, "*", ""))):
        cell = os.path.basename(os.path.dirname(d))
        if cell.startswith("_") or not NAME_RE.match(cell):
            continue
        gds = os.path.join(project.cells_dir, cell, "layout", f"{cell}.gds")
        out.append((cell, gds if os.path.isfile(gds) else None))
    return out


def cell_library(project, cell):
    try:
        with open(os.path.join(project.cells_dir, cell, "LIBRARY"), encoding="utf-8", errors="replace") as f:
            name = f.readline().strip()
    except OSError:
        return project.default_library
    return name if name in list_libraries(project) else project.default_library


def set_cell_library(project, cell, library):
    if library not in list_libraries(project):
        raise LibError(f"no library {library} in {project.folder}")
    if not os.path.isdir(os.path.join(project.cells_dir, cell)):
        raise LibError(f"no cell {cell} in {project.folder}")
    path = os.path.join(project.cells_dir, cell, "LIBRARY")
    if library == project.default_library:
        if os.path.exists(path):
            os.remove(path)          # default membership needs no file
    else:
        with open(path, "w", encoding="utf-8") as f:
            f.write(library + "\n")


def cells_by_library(project):
    out = {name: [] for name in list_libraries(project)}
    for cell, _gds in project_cells(project):
        out.setdefault(cell_library(project, cell), []).append(cell)
    return out


def create_cell(project, name, library, dbu=0.001):
    """New cell folder (same layout as 'make new-cell') + an empty layout whose top cell is
    <name>, assigned to <library>. Returns the GDS path."""
    if not NAME_RE.match(name or ""):
        raise LibError(f"cell name {name!r}: use letters, digits and _ (start with a letter)")
    if library not in list_libraries(project):
        raise LibError(f"no library {library} in {project.folder}")
    for p in projects():
        if os.path.isdir(os.path.join(p.cells_dir, name)):
            raise LibError(f"cell {name} already exists in project {p.folder}")
    new_cell = os.path.join(project.root, "flow", "new_cell.sh")
    if os.path.isfile(new_cell):
        r = subprocess.run(["bash", new_cell, name], capture_output=True, text=True)
        if r.returncode != 0:
            raise LibError(f"new_cell.sh failed: {r.stderr.strip() or r.stdout.strip()}")
    else:
        for sub in ("schematic", "layout", "sim"):
            os.makedirs(os.path.join(project.cells_dir, name, sub), exist_ok=True)
    gds = os.path.join(project.cells_dir, name, "layout", f"{name}.gds")
    if not os.path.exists(gds):
        layout = kdb.Layout()
        layout.dbu = dbu
        layout.create_cell(name)
        layout.write(gds)
    set_cell_library(project, name, library)
    return gds


# ------------------------------------------------------------------ KLayout library building
def build_layout(cells, log=print):
    """One layout holding the given cells' trees. Device sub-cells that share names across GDS
    files are kept apart; a copy of a project cell inside another one (e.g. inv inside buf) is
    re-pointed to the library's own cell."""
    lay = kdb.Layout()
    sources = []
    for cell, gds in cells:
        if not gds:
            continue
        src = kdb.Layout()
        try:
            src.read(gds)
        except Exception as e:  # e.g. a Git LFS pointer that was never pulled
            log(f"af-lib: skip {gds} ({e})")
            continue
        top = src.cell(cell)
        if top is None:
            log(f"af-lib: skip {gds} (no top cell named '{cell}')")
            continue
        if not sources:
            lay.dbu = src.dbu
        sources.append((cell, src, top))
    added = []
    for cell, _src, _top in sources:
        lay.create_cell(cell)
        added.append(cell)
    for cell, _src, top in sources:
        lay.cell(cell).copy_tree(top)
    own = {n: lay.cell(n).cell_index() for n in added}
    for c in list(lay.each_cell()):
        m = _DUP_RE.match(c.name)
        if not m or m.group(1) not in own or c.cell_index() == own[m.group(1)]:
            continue
        dup, real = c.cell_index(), own[m.group(1)]
        for parent_ci in list(c.each_parent_cell()):
            parent = lay.cell(parent_ci)
            for inst in list(parent.each_inst()):
                if inst.cell_index == dup:
                    inst.cell_index = real
        lay.prune_cell(dup, -1)
    return lay, added


def register_all(log=print):
    """Register every library of every project with KLayout. Re-registering a name replaces
    the old library, and layouts using it are updated. Returns {library name: (project, [cells])}."""
    done = {}
    for project in projects():
        groups = cells_by_library(project)
        paths = dict(project_cells(project))
        for lib_name, cells in groups.items():
            name = lib_name
            if name in done:
                name = f"{lib_name}@{project.folder}"
                log(f"af-lib: library name {lib_name} used twice; registered as {name}")
            lay, added = build_layout([(c, paths.get(c)) for c in sorted(cells)], log)
            lib = kdb.Library()
            lib.description = f"{project.folder}: {', '.join(added) if added else '(empty)'}"
            lib.layout().assign(lay)
            lib.register(name)
            done[name] = (project, added)
    return done
