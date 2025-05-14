#!/usr/bin/env bash
set -eu

# -----------------------------------------------------------------------------
# Run a simple COUNT query against the demo Iceberg table inside the Spark
# container. Exit 0 if the result is '1', else non-zero.
# -----------------------------------------------------------------------------
docker compose -f spark_demo/docker_compose.yaml exec -T spark \
  /opt/spark/bin/spark-sql \
  -e "SELECT count(*) FROM demo.default.customer;" |
  grep -q 1
