# Appendix A — 20-Check Production Checklist

*Lakehouse-code* · Last updated: TODO-DATE

> Use this list as a final gate before promoting a PoC stack to shared or production
> environments. Each check links to the code or policy that enforces it.

| # | Category | Check | Enforcement hook | Status |
|---|----------|-------|------------------|--------|
| 1 | **Infra** | Terraform state is **remotely stored** & version-locked | `ci/plan_apply.yml` lock table | ☐ |
| 2 |          | All resources are tagged `env`, `owner`, `ttl` | `terraform_null_label` module | ☐ |
| 3 | **Cost** | AWS Budget alert ≤ **US $20 / mo** (demo) | `infra/budget_alarm.tf` | ☐ |
| 4 |          | Iceberg compaction scheduled ≤ 24 h | `etl/airflow_dag.py` | ☐ |
| 5 | **Data** | Raw ⇨ Curated buckets have **object lock** disabled | N/A (manual) | ☐ |
| … |          | *(add 15 more checks)* | | |

## How to use

1. Copy this file to your project’s `docs/` folder.  
2. Mark each ☑ once the corresponding CI guard or manual approval is in place.  
