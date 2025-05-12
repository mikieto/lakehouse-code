<!-- markdownlint-disable MD013 -->
# Sprint S-1 — Boundary Definition

| Item | Content |
|------|---------|
| **Goal** | Deploy a **serverless AWS stack** in ≤ 30 min and prove the CSV → Iceberg → Athena round-trip. |
| **In-Scope** | S3 buckets (`raw/iceberg`), Glue Catalog DB & Iceberg table, Athena WorkGroup. |
| **Out-of-Scope** | Kafka / streaming, Lake Formation masking, Marquez lineage, MLOps, cost optimisation beyond Budgets. |
| **Done Definition** | Exit Criteria **#1 – #3** pass and a Budgets stop-spend rule is active. |
| **Constraints** | **Monthly cost ≤ US $20**, CI deploy job timeout 20 min. |
| **Milestone Tag** | `s1-complete` |
