#!/usr/bin/env python3
import pathlib, shutil
src = pathlib.Path('ci/workflows')
dst = pathlib.Path('.github/workflows')
dst.mkdir(parents=True, exist_ok=True)
for f in src.glob('*.yml'):
    shutil.copy2(f, dst / f.name)
print(f"Synced {len(list(src.glob('*.yml')))} workflow(s).")
