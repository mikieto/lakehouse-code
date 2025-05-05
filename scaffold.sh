#!/usr/bin/env bash
set -e

echo "▶ creating folders …"
mkdir -p infra/modules/{vpc,s3_buckets,glue,athena_iceberg,emr_serverless,msk_serverless,lambda_vacuum,lakeformation_tags,s3_lifecycle_logs}
mkdir -p pipelines/models/{staging,intermediate,datavault,gold}
mkdir -p docker/workspace .devcontainer .github/workflows
mkdir -p portal portal-docker data_producers/kafka

# Developer Portal placeholder
cat > portal-docker/docker-compose.yml <<'YML'
version: "3.9"
services:
  portal:
    image: backstage/backstage
    ports: ["7007:7007"]
    environment:
      - APP_CONFIG_app_baseUrl=http://localhost:7007
YML

echo "▶ writing placeholder files …"

# Kafka Producer placeholder
cat > data_producers/kafka/producer.py <<'PY'
import json, random, time, uuid
from kafka import KafkaProducer
producer = KafkaProducer(bootstrap_servers="localhost:9092",
                         value_serializer=lambda v: json.dumps(v).encode())
while True:
    event = {"id": str(uuid.uuid4()), "ts": int(time.time()), "value": random.random()}
    producer.send("orders", event)
    time.sleep(0.5)
PY
cat > data_producers/kafka/requirements.txt <<'REQ'
kafka-python==2.0.2
REQ

cat > infra/main.tf <<'TF'
terraform {
  required_version = ">=1.6.0"
  backend "s3" {}
}
TF

for mod in infra/modules/*; do
  printf '%s\n' '# TODO: implement' > "$mod/main.tf"
done

cat > pipelines/dbt_project.yml <<'YML'
name: lakehouse
profile: mvp
config-version: 2
version: '1.8'
YML

cat > docker/workspace/Dockerfile <<'DOCKER'
FROM python:3.12-slim
RUN pip install -q dbt-duckdb "pyspark==3.5.*" delta-spark dbt-spark
CMD ["bash"]
DOCKER

cat > Makefile <<'MK'
.PHONY: deploy-foundation
deploy-foundation:
	terraform -chdir=infra init -backend=false
MK

cat > .github/workflows/ci-code.yml <<'YML'
name: ci-code (placeholder)
on: [push]
jobs:
  noop:
    runs-on: ubuntu-latest
    steps:
      - run: echo "replace with real workflow"
YML

echo "✅ lakehouse-code skeleton done."
