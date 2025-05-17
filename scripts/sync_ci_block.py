#!/usr/bin/env python3
"""Sync reusable workflows from ci/workflows → .github/workflows."""

import pathlib
import shutil
import sys

SRC = pathlib.Path("ci/workflows")
DST = pathlib.Path(".github/workflows")

if not SRC.exists():
    print("❌ Source dir ci/workflows not found", file=sys.stderr)
    sys.exit(1)

DST.mkdir(parents=True, exist_ok=True)

count = 0
for wf in SRC.glob("*.yml"):
    shutil.copy2(wf, DST / wf.name)
    count += 1

print(f"🔄  Synced {count} workflow(s) from {SRC} → {DST}")
