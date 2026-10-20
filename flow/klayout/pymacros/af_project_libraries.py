# $autorun
# $description: analog-flow: 'Cell Library' menu (custom libraries, new cell, place cell) + library registration
"""Runs when KLayout starts (any KLayout whose KLAYOUT_PATH includes <project>/flow/klayout,
which flow/designinit.sh sets up). Code lives in ../python/af_libs_core.py (data) and
af_libs_gui.py (menu + dialogs). Never runs in the flow's batch jobs (klayout -b skips autorun).
"""
import glob
import os
import sys


def _add_python_path():
    candidates = [os.path.join(p, "python") for p in os.environ.get("KLAYOUT_PATH", "").split(os.pathsep) if p]
    candidates += sorted(glob.glob("/foss/designs/*/flow/klayout/python"))
    for q in candidates:
        if os.path.isfile(os.path.join(q, "af_libs_gui.py")):
            if q not in sys.path:
                sys.path.insert(0, q)
            return q
    return None


if _add_python_path():
    try:
        import af_libs_gui
        af_libs_gui.install()
    except Exception as e:  # a broken library file must never stop KLayout from starting
        print(f"af-lib: Cell Library menu not installed: {type(e).__name__}: {e}")
else:
    print("af-lib: af_libs_gui.py not found next to this macro; Cell Library menu not installed")
