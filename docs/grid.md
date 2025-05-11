# DEN-Grid (Initial, v0.9)

| Env / Box              | Owner          | security        | cost / CO₂      | resilience   |
|------------------------|----------------|-----------------|-----------------|--------------|
| EMR Serverless         | @platform-sre  | dbt tests       | Infracost ACU   | retry        |
| Glue Streaming + MSK   | @platform-sre  | IAM lint        | Stream alerts   | checkpoint   |
| SageMaker Serverless   | @platform-sre  | SBOM + cosign   | GreenCost badge | multi-AZ     |
| Backstage (AppRunner)  | @platform-sre  | SBOM + cosign   | **Auto-Pause**  | healthcheck  |
| S3 / Athena            | @data-eng      | —               | Budget guard    | cross-region |
| CloudWatch Dashboards  | @platform-sre  | —               | —               | N/A          |

> *空セルは禁止*。ルールが未確定なら `TODO` と記入し、
> 後続 PR でルールかツールを埋めていきます。
