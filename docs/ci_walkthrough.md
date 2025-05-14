# CI Walkthrough — Jobs ↔ README Anchors ↔ Ten Principles

> Each workflow enforces **one primary Ten Principle**; secondary principles (if any) are commented inside the YAML.

| CI Job                       | README section ↔ anchor                          | Primary Principle (#)      | Notes                                                     |
| ---------------------------- | ------------------------------------------------ | -------------------------- | --------------------------------------------------------- |
| `ci_plan_apply`              | [Ch 4](../README.md#ch-4-landing-zone)          | #4 Everything-as-Code      | Terraform plan/apply stopwatch (+ #1, #10)                |
| `ci_guard`                   | [Ch 4](../README.md#ch-4-landing-zone)          | #8 Security & Governance   | lint / tfsec / Infracost / **Lake Formation mask test**   |
| `ci_smoke_aws`               | [Ch 5](../README.md#ch-5-pipeline)              | #1 Storage-centric         | Iceberg row loop; ping Marquez (#2, #3, #7)               |
| `ci_lineage_check`           | [Ch 5](../README.md#ch-5-pipeline)              | #7 Observability & Lineage | Marquez API → `jobs.count ≥ 1`                             |
| `ci_walkthrough_consistency` | [Reading Guide](../README.md#reading-guide)     | #4 Everything-as-Code      | Ensures README ↔ workflow docs stay in sync               |
| `ci_smoke_local`             | [Reading Guide](../README.md#reading-guide)     | #5 Shift-left CI/Ops       | Docker-only sandbox integrity                             |
| `ci_dbt_test`                | [Ch 6](../README.md#ch-6-governance)            | #2 Open Table Format       | dbt run & test                                            |
| `ci_expectations`            | [Ch 6](../README.md#ch-6-governance)            | #3 Metadata-driven         | Great Expectations hard-fail                              |
| `ci_cdc_latency`             | [Ch 9](../README.md#ch-9-cdc-adv)               | #6 Loose-Coupling & Event  | Kafka → Iceberg latency SLA                               |
| `ci_observability`           | [Ch 8](../README.md#ch-8-devops-adv)            | #7 Observability & Lineage | EMF → Grafana SLO                                         |
| `ci_finops_alert`            | [Ch 8](../README.md#ch-8-devops-adv)            | #9 Cost-aware FinOps       | Cost-anomaly SNS test                                     |
| `ci_incident_review`         | [Ch 8](../README.md#ch-8-devops-adv)            | #5 Shift-left CI/Ops       | Runbook & post-mortem check                               |
| `ci_backup_check`            | [Ch 10](../README.md#ch-10-optimize)            | #10 Serverless-first       | CRR / LakeFS smoke                                        |
| `ci_portal_build`            | [Ch 8](../README.md#ch-8-devops-adv)            | #4 Everything-as-Code      | Build & deploy Developer Portal                           |

---

## How to read this table

- **Click the section link** to jump straight to the relevant anchor in `README.md`.
- **Primary Principle** shows the main Ten Principle this CI job enforces.
- Workflows marked ✔ mandatory in `project_plan.md` must be ✅ green on every PR.

[Back to README](../README.md#ci-pipelines)
