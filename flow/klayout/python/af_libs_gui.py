"""KLayout GUI for analog-flow cell libraries: the 'Cell Library' menu and its dialogs.

Menu bar > Cell Library
    Library Manager...        Ctrl+Shift+L   browse libraries and cells; every action below
    New Cell...               Ctrl+Shift+N   create cells/<name>/ in a chosen library, open its layout
    Place Cell...             Ctrl+Shift+P   instantiate a library cell into the current layout
    New Library...                           create a custom library
    Refresh Libraries         Ctrl+Shift+R   re-read all cell layouts into the KLayout libraries

The libraries are ordinary KLayout libraries, so they also appear in KLayout's own Libraries
panel next to Basic and the sky130 PCells, where cells can be dragged into a layout.
Data model and storage: af_libs_core.py.
"""
import os

import pya

import af_libs_core as L

GRID_UM = 0.005
_STATE = {"installed": False, "keep": []}


# -------------------------------------------------------------------------------- helpers
def _mw():
    return pya.Application.instance().main_window()


def _say(text, ms=4000):
    print(text)
    mw = _mw()
    if mw is not None:
        mw.message(text, ms)


def _warn(parent, title, text):
    pya.QMessageBox.warning(parent, title, text)


def _info(parent, title, text):
    pya.QMessageBox.information(parent, title, text)


def refresh(quiet=False):
    """Re-register all libraries. Layouts already using them are updated by KLayout."""
    msgs = []
    done = L.register_all(log=msgs.append)
    text = "Cell libraries: " + ", ".join(f"{n} ({len(c)})" for n, (_p, c) in sorted(done.items()))
    if not quiet:
        _say(text)
    for m in msgs:
        print(m)
    return done


def current_project():
    """Project of the layout in the active view; else the only project; else None."""
    mw = _mw()
    view = mw.current_view() if mw else None
    if view is not None:
        cv = view.active_cellview()
        if cv.is_valid() and cv.filename():
            p = L.project_of_path(cv.filename())
            if p:
                return p
    ps = L.projects()
    return ps[0] if len(ps) == 1 else None


def open_layout(path):
    if not os.access(path, os.W_OK):
        rel = os.path.relpath(path, L.DESIGNS)
        _warn(_mw(), "Layout is read-only",
              f"{rel} is read-only: it is a locked-file in Git LFS.\n\nTo edit it, lock it first "
              f"(Ubuntu window, in the project folder):\n  git lfs lock "
              f"{os.path.relpath(path, L.project_of_path(path).root) if L.project_of_path(path) else path}"
              "\n\nOpening it read-only.")
    _mw().load_layout(path, 1)    # 1 = new tab


def place_cell(lib_name, cell_name, parent=None):
    """Instantiate <lib_name>.<cell_name> in the current cell, at the centre of the view."""
    mw = _mw()
    view = mw.current_view() if mw else None
    if view is None or not view.active_cellview().is_valid():
        _warn(parent, "Place Cell", "Open a layout first (File > Open, or Cell Library > New Cell).")
        return False
    cv = view.active_cellview()
    layout, target = cv.layout(), cv.cell
    if target is None:
        _warn(parent, "Place Cell", "Select a cell to place into (Cells panel).")
        return False
    if not pya.Application.instance().is_editable():
        _warn(parent, "Place Cell", "KLayout runs in viewer mode. Start it in editor mode to place "
              "cells:  klayout -e")
        return False
    if target.name == cell_name:
        _warn(parent, "Place Cell", f"Cannot place {cell_name} inside itself.")
        return False
    if pya.Library.library_by_name(lib_name) is None:
        refresh(quiet=True)
    view.transaction(f"Place {lib_name}.{cell_name}")
    try:
        proxy = layout.create_cell(cell_name, lib_name)
        if proxy is None:
            _warn(parent, "Place Cell", f"{cell_name} not found in library {lib_name} (Refresh?).")
            return False
        c = view.box().center()
        x = round(c.x / GRID_UM) * GRID_UM
        y = round(c.y / GRID_UM) * GRID_UM
        target.insert(pya.DCellInstArray(proxy.cell_index(), pya.DTrans(pya.DVector(x, y))))
    finally:
        view.commit()
    _say(f"Placed {lib_name}.{cell_name} in {target.name} at ({x:.3f}, {y:.3f}) um")
    return True


# -------------------------------------------------------------------------------- widgets
class _ProjectBox(pya.QComboBox):
    def __init__(self, parent, project=None):
        super().__init__(parent)
        self.projects = L.projects()
        for p in self.projects:
            self.addItem(p.folder)
        if project is not None:
            for i, p in enumerate(self.projects):
                if p.root == project.root:
                    self.setCurrentIndex(i)

    def project(self):
        i = self.currentIndex
        return self.projects[i] if 0 <= i < len(self.projects) else None


def _buttons(parent, layout, *specs):
    row = pya.QHBoxLayout()
    out = []
    for text, handler in specs:
        b = pya.QPushButton(text, parent)
        b.clicked += handler
        row.addWidget(b)
        out.append(b)
    layout.addLayout(row)
    return out


class NewLibraryDialog(pya.QDialog):
    def __init__(self, parent, project):
        super().__init__(parent)
        self.windowTitle = "New Library"
        self.created = None
        lay = pya.QVBoxLayout(self)
        lay.addWidget(pya.QLabel("Project:", self))
        self.proj = _ProjectBox(self, project)
        lay.addWidget(self.proj)
        lay.addWidget(pya.QLabel("Library name (letters, digits, _):", self))
        self.name = pya.QLineEdit(self)
        lay.addWidget(self.name)
        lay.addWidget(pya.QLabel("Description:", self))
        self.desc = pya.QLineEdit(self)
        lay.addWidget(self.desc)
        _buttons(self, lay, ("Create", lambda *a: self._create()), ("Cancel", lambda *a: self.reject()))

    def _create(self):
        p = self.proj.project()
        try:
            L.create_library(p, self.name.text.strip(), self.desc.text.strip())
        except L.LibError as e:
            _warn(self, "New Library", str(e))
            return
        self.created = self.name.text.strip()
        refresh()
        self.accept()


class NewCellDialog(pya.QDialog):
    def __init__(self, parent, project, library=None):
        super().__init__(parent)
        self.windowTitle = "New Cell"
        self.created = None
        lay = pya.QVBoxLayout(self)
        lay.addWidget(pya.QLabel("Project:", self))
        self.proj = _ProjectBox(self, project)
        self.proj.currentIndexChanged += lambda *a: self._fill_libs()
        lay.addWidget(self.proj)
        lay.addWidget(pya.QLabel("Cell name (letters, digits, _):", self))
        self.name = pya.QLineEdit(self)
        lay.addWidget(self.name)
        lay.addWidget(pya.QLabel("Library:", self))
        row = pya.QHBoxLayout()
        self.lib = pya.QComboBox(self)
        row.addWidget(self.lib)
        nb = pya.QPushButton("New Library...", self)
        nb.clicked += lambda *a: self._new_lib()
        row.addWidget(nb)
        lay.addLayout(row)
        self.open_it = pya.QCheckBox("Open the new layout for editing", self)
        self.open_it.checked = True
        lay.addWidget(self.open_it)
        _buttons(self, lay, ("Create", lambda *a: self._create()), ("Cancel", lambda *a: self.reject()))
        self._fill_libs(library)

    def _fill_libs(self, select=None):
        self.lib.clear()
        p = self.proj.project()
        names = list(L.list_libraries(p)) if p else []
        for n in names:
            self.lib.addItem(n)
        if select in names:
            self.lib.setCurrentIndex(names.index(select))

    def _new_lib(self):
        d = NewLibraryDialog(self, self.proj.project())
        if d.exec_() and d.created:
            self._fill_libs(d.created)

    def _create(self):
        p, name, lib = self.proj.project(), self.name.text.strip(), self.lib.currentText
        try:
            gds = L.create_cell(p, name, lib)
        except L.LibError as e:
            _warn(self, "New Cell", str(e))
            return
        self.created = (lib, name, gds)
        refresh()
        if self.open_it.checked:
            open_layout(gds)
        _say(f"Created cell {name} in library {lib}: {os.path.relpath(gds, p.root)}")
        self.accept()


class PlaceCellDialog(pya.QDialog):
    def __init__(self, parent):
        super().__init__(parent)
        self.windowTitle = "Place Cell"
        lay = pya.QVBoxLayout(self)
        lay.addWidget(pya.QLabel("Library:", self))
        self.lib = pya.QComboBox(self)
        lay.addWidget(self.lib)
        lay.addWidget(pya.QLabel("Cell (placed at the centre of the view, in the current cell):", self))
        self.cells = pya.QListWidget(self)
        lay.addWidget(self.cells)
        self.lib.currentIndexChanged += lambda *a: self._fill_cells()
        self.cells.itemDoubleClicked += lambda *a: self._place()
        _buttons(self, lay, ("Place", lambda *a: self._place()), ("Close", lambda *a: self.reject()))
        self.registered = refresh(quiet=True)
        for n in sorted(self.registered):
            self.lib.addItem(n)
        p = current_project()
        if p and p.default_library in self.registered:
            self.lib.setCurrentIndex(sorted(self.registered).index(p.default_library))
        self._fill_cells()

    def _fill_cells(self):
        self.cells.clear()
        _p, cells = self.registered.get(self.lib.currentText, (None, []))
        for c in cells:
            self.cells.addItem(c)

    def _place(self):
        item = self.cells.currentItem
        if item is None:
            _warn(self, "Place Cell", "Choose a cell.")
            return
        place_cell(self.lib.currentText, item.text, self)


class LibraryManager(pya.QDialog):
    def __init__(self, parent):
        super().__init__(parent)
        self.windowTitle = "Cell Library Manager"
        self._cell_names = []
        self.resize(640, 460)
        lay = pya.QVBoxLayout(self)
        top = pya.QHBoxLayout()
        top.addWidget(pya.QLabel("Project:", self))
        self.proj = _ProjectBox(self, current_project())
        self.proj.currentIndexChanged += lambda *a: self.reload()
        top.addWidget(self.proj)
        lay.addLayout(top)
        lists = pya.QHBoxLayout()
        left, right = pya.QVBoxLayout(), pya.QVBoxLayout()
        left.addWidget(pya.QLabel("Libraries", self))
        self.libs = pya.QListWidget(self)
        left.addWidget(self.libs)
        right.addWidget(pya.QLabel("Cells in library", self))
        self.cells = pya.QListWidget(self)
        right.addWidget(self.cells)
        lists.addLayout(left)
        lists.addLayout(right)
        lay.addLayout(lists)
        self.detail = pya.QLabel("", self)
        lay.addWidget(self.detail)
        self.libs.currentRowChanged += lambda *a: self._fill_cells()
        self.cells.currentRowChanged += lambda *a: self._show_detail()
        self.cells.itemDoubleClicked += lambda *a: self._open()
        _buttons(self, lay, ("New Library...", lambda *a: self._new_lib()),
                 ("Delete Library", lambda *a: self._del_lib()),
                 ("New Cell...", lambda *a: self._new_cell()))
        _buttons(self, lay, ("Open Layout", lambda *a: self._open()),
                 ("Place in Current Layout", lambda *a: self._place()),
                 ("Move to Library...", lambda *a: self._move()))
        _buttons(self, lay, ("Refresh", lambda *a: self.reload(True)), ("Close", lambda *a: self.accept()))
        self.reload(True)

    # data
    def _project(self):
        return self.proj.project()

    def _lib_names(self):
        p = self._project()
        return list(L.list_libraries(p)) if p else []

    def _cur_lib(self):
        names = self._lib_names()
        r = self.libs.currentRow
        return names[r] if 0 <= r < len(names) else None

    def _cur_cell(self):
        r = self.cells.currentRow
        return self._cell_names[r] if 0 <= r < len(self._cell_names) else None

    def reload(self, re_register=False, select_lib=None, select_cell=None):
        if re_register:
            refresh(quiet=True)
        keep = select_lib or self._cur_lib()
        self.libs.clear()
        p = self._project()
        if p is None:
            return
        libs = L.list_libraries(p)
        groups = L.cells_by_library(p)
        for n, desc in libs.items():
            self.libs.addItem(f"{n}   ({len(groups.get(n, []))})   {desc}")
        names = list(libs)
        self.libs.setCurrentRow(names.index(keep) if keep in names else 0)
        self._fill_cells(select_cell)

    def _fill_cells(self, select=None):
        self.cells.clear()
        self._cell_names = []
        p, lib = self._project(), self._cur_lib()
        if p is None or lib is None:
            return
        paths = dict(L.project_cells(p))
        cells = L.cells_by_library(p).get(lib, [])
        self._cell_names = list(cells)
        for c in cells:
            self.cells.addItem(c if paths.get(c) else f"{c}   (no layout yet)")
        if select in cells:
            self.cells.setCurrentRow(cells.index(select))
        self._show_detail()

    def _show_detail(self):
        p, c = self._project(), self._cur_cell()
        if p is None or c is None:
            self.detail.text = ""
            return
        gds = dict(L.project_cells(p)).get(c)
        state = "no layout" if not gds else ("read-only (lock it to edit)" if not os.access(gds, os.W_OK) else "editable")
        self.detail.text = f"cells/{c}/  -  layout: {state}"

    # actions
    def _new_lib(self):
        d = NewLibraryDialog(self, self._project())
        if d.exec_() and d.created:
            self.reload(False, d.created)

    def _del_lib(self):
        lib = self._cur_lib()
        if lib is None:
            return
        try:
            L.delete_library(self._project(), lib)
        except L.LibError as e:
            _warn(self, "Delete Library", str(e))
            return
        self.reload(True)

    def _new_cell(self):
        d = NewCellDialog(self, self._project(), self._cur_lib())
        if d.exec_() and d.created:
            lib, name, _gds = d.created
            self.reload(False, lib, name)

    def _open(self):
        p, c = self._project(), self._cur_cell()
        if c is None:
            return
        gds = dict(L.project_cells(p)).get(c)
        if not gds:
            _warn(self, "Open Layout", f"{c} has no layout yet: cells/{c}/layout/{c}.gds")
            return
        open_layout(gds)

    def _place(self):
        lib, c = self._cur_lib(), self._cur_cell()
        if c is not None:
            if pya.Library.library_by_name(lib) is None:
                refresh(quiet=True)
            place_cell(lib, c, self)

    def _move(self):
        p, c = self._project(), self._cur_cell()
        if c is None:
            return
        names = self._lib_names()
        d = pya.QDialog(self)
        d.windowTitle = f"Move {c} to library"
        lay = pya.QVBoxLayout(d)
        lay.addWidget(pya.QLabel(
            "Layouts that already place this cell remember the library it came from.\n"
            "After moving, reopen them and re-place the cell from its new library.", d))
        box = pya.QComboBox(d)
        for n in names:
            box.addItem(n)
        lay.addWidget(box)
        _buttons(d, lay, ("Move", lambda *a: d.accept()), ("Cancel", lambda *a: d.reject()))
        if d.exec_():
            try:
                L.set_cell_library(p, c, box.currentText)
            except L.LibError as e:
                _warn(self, "Move", str(e))
                return
            self.reload(True, box.currentText, c)


# ----------------------------------------------------------------------------------- menu
def _action(title, handler, shortcut=None):
    a = pya.Action()
    a.title = title
    if shortcut:
        a.shortcut = shortcut
    a.on_triggered += handler
    _STATE["keep"].append(a)
    return a


def _run_dialog(factory):
    def run():
        try:
            d = factory()
            _STATE["keep"].append(d)
            d.exec_()
        except Exception as e:  # never let a GUI error kill KLayout
            _warn(_mw(), "Cell Library", f"{type(e).__name__}: {e}")
    return run


def install():
    if _STATE["installed"]:
        return
    mw = _mw()
    if mw is None:          # batch mode (klayout -b): libraries only, no menu
        refresh(quiet=True)
        return
    menu = mw.menu()
    if not menu.is_valid("af_lib_menu"):
        menu.insert_menu("help_menu", "af_lib_menu", "Cell Library")
    items = [
        ("af_lib_manager", _action("Library Manager...", _run_dialog(lambda: LibraryManager(mw)), "Ctrl+Shift+L")),
        ("af_lib_new_cell", _action("New Cell...", _run_dialog(lambda: NewCellDialog(mw, current_project())), "Ctrl+Shift+N")),
        ("af_lib_place", _action("Place Cell...", _run_dialog(lambda: PlaceCellDialog(mw)), "Ctrl+Shift+P")),
        ("af_lib_new_lib", _action("New Library...", _run_dialog(lambda: NewLibraryDialog(mw, current_project())))),
        ("af_lib_refresh", _action("Refresh Libraries", lambda: refresh(), "Ctrl+Shift+R")),
    ]
    for key, act in items:
        if not menu.is_valid(f"af_lib_menu.{key}"):
            menu.insert_item("af_lib_menu.end", key, act)
    refresh(quiet=True)
    _STATE["installed"] = True
