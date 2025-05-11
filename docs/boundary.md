# Boundary Table (v0.9)

| Layer  | Component / Asset                | Owner (GitHub) |
|--------|----------------------------------|----------------|
| Domain | Orders API (placeholder)         | @app-dev       |
| Domain | Payments API (placeholder)       | @app-dev       |
| Data   | Bronze S3 bucket                 | @data-eng      |
| Data   | Silver Iceberg table             | @data-eng      |
| Data   | Gold Athena view                 | @data-eng      |
| Service| EMR Serverless Spark job         | @platform-sre  |
| Service| Glue Streaming (CDC)             | @platform-sre  |
| Service| SageMaker Serverless endpoint    | @platform-sre  |
| Service| Backstage (App Runner)           | @platform-sre  |

> **NOTE**
> 追加リソースが増えたら *Layer / Component / Owner* の 3 列を増やし、
> 空行を残さないでください。
