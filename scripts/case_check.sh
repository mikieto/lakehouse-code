#!/usr/bin/env bash
#
# Reject newly-staged files or directories whose *path components*
# contain a hyphen (kebab-case).  Allowed exceptions:
#   1. .gitignore, .github/ISSUE_TEMPLATE etc. (UI-generated)
#   2. Any file under docs/fig/  (images will be replaced later)
#
set -euo pipefail

# list staged files
paths=$(git diff --cached --name-only --diff-filter=ACM)

bad_list=

for p in $paths; do
  # skip known exceptions
  [[ "$p" =~ ^docs/fig/ ]]        && continue
  [[ "$p" =~ ^\.github/ISSUE_TEMPLATE/ ]] && continue
  [[ "$p" == ".pre-commit-config.yaml" ]] && continue

  IFS='/' read -ra parts <<< "$p"
  for part in "${parts[@]}"; do
    if [[ "$part" =~ [A-Za-z0-9]*-[A-Za-z0-9]* ]]; then
      bad_list+="$p"$'\n'
      break
    fi
  done
done

if [[ -n "$bad_list" ]]; then
  echo "✗ Snake-case required. Hyphens detected in:"
  echo "$bad_list"
  echo "Rename the files or directories using snake_case."
  exit 1
fi
