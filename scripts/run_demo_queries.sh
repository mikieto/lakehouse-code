#!/usr/bin/env bash
set -euo pipefail

WORKGROUP=$(terraform -chdir=infra output -raw athena_workgroup)
aws athena start-query-execution \
  --work-group "$WORKGROUP" \
  --query-string "SELECT * FROM customers LIMIT 1;" \
  --result-configuration "OutputLocation=s3://$(terraform -chdir=infra output -raw raw_bucket)/athena/"
