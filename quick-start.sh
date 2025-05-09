#!/usr/bin/env bash
set -euo pipefail

if [[ "${1:-}" == "--smoke" ]]; then
  echo "🟢 Smoke mode: doing lightweight checks..."
  # terraform -version
  exit 0
fi

echo "❌ Full quick-start not implemented yet."
exit 1
