#!/usr/bin/env python3
import re, pathlib, sys

SRC = pathlib.Path("docs/project_plan.md")
if not SRC.exists():
    sys.exit("docs/project-plan.md not found")

block = re.search(r"<!-- BEGIN EXIT_CRITERIA -->.*?<!-- END EXIT_CRITERIA -->",
                  SRC.read_text(), re.S).group(0)

dst = pathlib.Path("README.md")
txt = dst.read_text()
new = re.sub(r"<!-- BEGIN EXIT_CRITERIA -->.*?<!-- END EXIT_CRITERIA -->",
             block, txt, flags=re.S)
dst.write_text(new)
print("[ok] EXIT_CRITERIA block synced to README.md")
