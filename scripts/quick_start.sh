#!/usr/bin/env bash
set -euo pipefail

case "$1" in
  --deploy)
    (cd infra && terraform init -input=false && terraform apply -auto-approve -input=false)
    ;;
  --destroy|--nuke)
    (cd infra && terraform destroy -auto-approve -input=false)
    ;;
  *)
    echo "Usage: $0 --deploy|--destroy"
    ;;
esac
