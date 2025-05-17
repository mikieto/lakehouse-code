#!/usr/bin/env bash
set -euo pipefail

# --- Fetch Terraform outputs --------------------------------------------------
WG=$(terraform -chdir=infra output -raw athena_workgroup_name)
BUCKET=$(terraform -chdir=infra output -raw raw_bucket)

# --- Submit a lightweight query ----------------------------------------------
SQL="SELECT 1;"
QID=$(aws athena start-query-execution \
        --work-group "$WG" \
        --query-string "$SQL" \
        --result-configuration "OutputLocation=s3://$BUCKET/athena/" \
        --output text --query 'QueryExecutionId')

echo "QueryExecutionId: $QID  – waiting ..."

# --- Poll until the query finishes -------------------------------------------
while true; do
  STATE=$(aws athena get-query-execution \
            --query-execution-id "$QID" \
            --output text --query 'QueryExecution.Status.State')
  case "$STATE" in
    SUCCEEDED) break ;;
    FAILED|CANCELLED)
      echo "Query $STATE"; exit 1 ;;
    *) sleep 2 ;;
  esac
done

# --- Retrieve a single value to confirm success ------------------------------
RESULT=$(aws athena get-query-results \
           --query-execution-id "$QID" \
           --output text --query 'ResultSet.Rows[1].Data[0].VarCharValue')

echo "Athena returned: $RESULT"
