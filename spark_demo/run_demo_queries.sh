#!/usr/bin/env bash
set -eu

COMPOSE_FILE="spark_demo/docker_compose.yaml"
SERVICE="spark"                # rename to spark-master if that’s the service name
SPARK_SQL="/opt/spark/bin/spark-sql"
QUERY="SELECT count(*) FROM demo.default.customer;"

# Wait until spark-sql inside the container exits 0 (max 60s)
echo "Waiting for Spark to become available …"
for i in {1..12}; do
  if docker compose -f "$COMPOSE_FILE" exec -T "$SERVICE" "$SPARK_SQL" -e 'SHOW DATABASES;' >/dev/null 2>&1; then
    echo "Spark is ready."
    break
  fi
  sleep 5
done

# Run the verification query; expect result = 1
docker compose -f "$COMPOSE_FILE" exec -T "$SERVICE" "$SPARK_SQL" -e "$QUERY" | grep -q 1
