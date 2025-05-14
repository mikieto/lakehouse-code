#!/usr/bin/env bash
set -eu

COMPOSE_FILE="spark_demo/docker_compose.yaml"
SERVICE="spark"                    # ← docker compose ps で確認した名前
SPARK_SQL="/opt/spark/bin/spark-sql"
QUERY="SELECT count(*) FROM demo.default.customer;"

echo "Waiting for Spark to become available …"
for i in {1..24}; do
  if docker compose -f "$COMPOSE_FILE" exec -T "$SERVICE" "$SPARK_SQL" -e 'SHOW DATABASES;' >/dev/null 2>&1; then
    echo "Spark is ready."
    break
  fi
  sleep 5
done

# Fail fast if Spark never became ready
docker compose -f "$COMPOSE_FILE" exec -T "$SERVICE" "$SPARK_SQL" -e 'SHOW DATABASES;' >/dev/null

# Verify the demo table has 1 row
docker compose -f "$COMPOSE_FILE" exec -T "$SERVICE" "$SPARK_SQL" -e "$QUERY" | grep -q 1

