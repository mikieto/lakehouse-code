# 🚀 **30-Minute Self-Service Lakehouse**

| Guard | Plan-Apply | License | Cost ≤ US $20 / month |
|-------|------------|---------|-----------------------|
| ![guard](https://img.shields.io/github/actions/workflow/status/mikieto/lakehouse-code/ci_guard.yml?label=guard\&logo=github) | ![plan-apply](https://img.shields.io/github/actions/workflow/status/mikieto/lakehouse-code/ci_plan_apply.yml?label=plan-apply&logo=github) | ![license](https://img.shields.io/github/license/mikieto/lakehouse-code?color=blue) | ![cost](https://img.shields.io/badge/monthly_cost-≤%20\$20-brightgreen) |

> **Spin up — learn — tear down** a fully-managed, serverless Lakehouse in **under 30 minutes**.
> All cloud resources can be kept below **US \$20/month** with the default settings.
> *A companion book is in the works; this repo already contains the complete, runnable code.*

---

## 📦  What’s Inside

| Layer             | Tech Stack                                   | Highlights                                  |
| ----------------- | -------------------------------------------- | ------------------------------------------- |
| **Storage**       | Amazon S3 (Bronze / Silver / Gold)           | Hive-style partitions, lifecycle policies   |
| **Table Format**  | Apache Iceberg                               | ACID, time-travel, schema evolution         |
| **Orchestration** | Glue Serverless, dbt, Airflow (on Docker)    | Declarative pipelines, DAG-based scheduling |
| **Streaming**     | MSK + Kafka Connect (Debezium)               | Change-Data-Capture to S3                   |
| **ML & MLOps**    | SageMaker Serverless, MLflow                 | End-to-end model lifecycle                  |
| **Observability** | OpenLineage + Marquez, CloudWatch Dashboards | Lineage graph & near-real-time metrics      |
| **Fin/Ops & Sec** | AWS Budgets, Infracost, Lake Formation       | Cost guard-rails, column-level masking      |

---

## 🛠  Prerequisites

| Tool                 | Minimum Version | Purpose                |
| -------------------- | --------------- | ---------------------- |
| **AWS CLI**          | v2.15           | Deploy & operate       |
| **Terraform**        | v1.7            | Infrastructure as Code |
| **Docker + Compose** | 24.x            | Local runners & Kafka  |
| **Git**              | 2.40            | Clone & tag checkout   |
| **bash / zsh**       | —               | Runs helper scripts    |

> You’ll need an AWS account with permission to create S3, Glue, IAM, MSK, and SageMaker resources.
> **Tip:** Use a *fresh* sub-account or an *AWS Control Tower sandbox* to keep billing and policy boundaries clean.

---

## ⚡️  Quick Start ( ≈ 30 min )

```bash
# 1. Clone the repo
git clone https://github.com/mikieto/lakehouse-code.git
cd lakehouse-code

# 2. (Optional) work on the latest stable tag
# git checkout v0.9.0

# 3. Deploy — this creates all serverless resources in your default AWS region
./scripts/quick_start.sh --deploy                # ≈ 20-25 min

# 4. Smoke-test the full Bronze→Gold path
./spark_demo/run_demo_queries.sh            # < 1 min

# 5. Explore
open "https://us-east-1.console.aws.amazon.com/athena/home"     # query tables
open "http://localhost:3000"                                    # Marquez UI
```

### Tear Down  (≈ 3 min)

```bash
./scripts/quick_start.sh --destroy               # Deletes every resource created by this repo
```

*The guard CI job runs the same workflow non-interactively; see `.github/workflows/guard.yml`.*

---

## ✅  What Counts as “Success”?

<!-- BEGIN EXIT_CRITERIA -->
| # | Objective Check | Pass Condition | Verifier |
|---|-----------------|----------------|----------|
| 1 | **30-min deploy** | `make up` completes in ≤ 30 min ✅ | `ci_plan_apply.yml` stopwatch |
| 2 | **Data loop** | CSV → Iceberg → Athena returns a row ✅ | `run_demo_queries.sh` |
| 3 | **CI green** | Guard workflow succeeds **3×** consecutively | `ci_guard.yml` |
| 4 | **Lineage graph** | Marquez UI shows ≥ 1 job/node | Screenshot |
| 5 | **100 % IaC** | `terraform plan` shows 0 unmanaged | Guard output |
| 6 | **Security baseline** | Lake Formation column mask hides **ssn** | SQL test |
| 7 | **Fin/Obs guards** | Budgets alarm + CloudWatch dashboard with ≥ 3 metrics | Terraform outputs |
<!-- END EXIT_CRITERIA -->

If all seven pass, you’ve reproduced the full 30-minute Lakehouse.

---

## 🧰  Useful Make Targets

| Command      | Action                                        |
| ------------ | --------------------------------------------- |
| `make plan`  | Dry-run Terraform                             |
| `make up`    | Same as `quick_start.sh --deploy`             |
| `make nuke`  | Same as `quick_start.sh --destroy`            |
| `make smoke` | Local Docker-only pipeline test (no AWS cost) |

---

## 🤝  Contributing

1. Fork the repository.
2. Create a feature branch.
3. Run `make test` (lint + unit) **and** `make smoke`.
4. Open a PR — the guard workflow must be green.

See **`CONTRIBUTING.md`** for tag conventions and review check-lists.

---

## 🏷  License & Cost Footnote

Distributed under the **MIT License**.
The *≤ US \$20/mo* badge assumes **us-east-1**, default dataset size (< 1 GB), and no SageMaker GPU usage. Heavy workloads can exceed this — **set Budgets alerts** before experimenting.

---

### Happy Building! 🎉

*Questions or feedback?* Open an issue or reach out on Twitter [@mikieto](https://twitter.com/mikieto).
