#!/usr/bin/env bash
#
# Reject newly-staged files or directories whose *path components*
# contain a hyphen (kebab-case).  
# Allowed exceptions are read from `.case_check_ignore`
#   – one path per line, relative to repo root
# Built-in exceptions stay as before.
#
set -euo pipefail

# -------------------------------------------------------------------------
# Collect staged paths (Added / Copied / Modified)
# -------------------------------------------------------------------------
paths=$(git diff --cached --name-only --diff-filter=ACM)

# If an ignore list exists, remove those paths first
if [[ -f .case_check_ignore ]]; then
  # grep -v -F -f = “invert match, fixed string, file with patterns”
  paths=$(echo "$paths" | grep -v -F -f .case_check_ignore || true)
fi

bad_list=""

# -------------------------------------------------------------------------
# Scan each remaining path component for hyphens
# -------------------------------------------------------------------------
for p in $paths; do
  # Built-in exceptions
  [[ "$p" =~ ^docs/fig/ ]]                      && continue
  [[ "$p" =~ ^\.github/ISSUE_TEMPLATE/ ]]       && continue
  [[ "$p" == ".pre-commit-config.yaml" ]]       && continue

  IFS='/' read -ra parts <<< "$p"
  for part in "${parts[@]}"; do
    if [[ "$part" =~ [A-Za-z0-9]+-[A-Za-z0-9]+ ]]; then
      bad_list+="$p"$'\n'
      break
    fi
  done
done

# -------------------------------------------------------------------------
# Fail if any offenders remain
# -------------------------------------------------------------------------
if [[ -n "$bad_list" ]]; then
  echo "✗ Snake-case required. Hyphens detected in:"
  echo "$bad_list"
  echo "Rename the files or add paths to .case_check_ignore"
  exit 1
fi
