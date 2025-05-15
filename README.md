# 🚀 30-Minute Self-Service Lakehouse

> **Single-source note:** canonical locations are listed in CONTRIBUTING.md §0.
> Spin up → learn → tear down a fully-managed, **serverless Lakehouse in under 30 minutes** for ≈ US $20 / month.

| Guard | Plan-Apply | License | Budget ≤ US $20 |
|-------|-----------|---------|-----------------|
| ![guard](https://img.shields.io/github/actions/workflow/status/mikieto/lakehouse-code/ci_guard.yml?label=guard&logo=github) | ![plan](https://img.shields.io/github/actions/workflow/status/mikieto/lakehouse-code/ci_plan_apply.yml?label=plan-apply&logo=github) | ![license](https://img.shields.io/github/license/mikieto/lakehouse-code?color=blue) | ![cost](https://img.shields.io/badge/monthly_cost-≤%20\$20-brightgreen) |

---

## 🧭 Reading Guide <a id="reading-guide"></a>

| Why / What / How | Resource / TL;DR |
|------------------|------------------|
| **Why** – Two macro-shifts: **1️⃣ Physical → Logical** (cloud-native tags, IAM, policies replace rack-level fences) **& 2️⃣ Manual → Code-as-Default** (configs, tests, policies live in Git) | *Intro chapter of the book* |
| **What** – Five modern-data pillars: **Elastic · Serverless · Governed · Cost-Aware · AI-Ready** — the yardsticks that drive every design and CI gate in this repo | *Chapter 2 of the book* |
| **How** – Ten-Principles cheat-sheet | [`docs/ten_principles_cheat_sheet.md`](docs/ten_principles_cheat_sheet.md) |
| **What** – Tool-Triad: **Terraform Modules** (infra), **GitHub Reusable Workflows** (automation), **Apache Iceberg** (open-table format) — the glue that lets you reuse the patterns in any cloud | *Hands-on chapters 4-7* |
| **Loop** – Org-adoption canvas: map PoC → Scale-up → Org-wide adoption on one page to surface trade-offs early | *Appendix C (forthcoming)* |

---

## 📚 Chapters at a Glance

| # | Chapter (anchor) | 1-line value + hands-on goal |
|---|------------------|-----------------------------|
| 1 <a id="ch-1-evolution"></a> | **Evolution** | Storage became the new gravity—why it matters. |
| 2 <a id="ch-2-paradigms"></a> | **Paradigms** | Ops-as-Code toggle: demo ⇄ prod in minutes. |
| 3 <a id="ch-3-strategy"></a> | **Strategy & Value** | FinOps-first: live cost diff with Infracost. |
| 4 <a id="ch-4-landing-zone"></a> | **Landing Zone** | Guard-railed AWS landing zone in 15 min. |
| 5 <a id="ch-5-pipeline"></a> | **Pipeline** | Iceberg Bronze → Silver, schema-safe, 20 min. |
| 6 <a id="ch-6-governance"></a> | **Governance** | Catalog + Mask + GE gate + Lineage in 20 min. |
| 7 <a id="ch-7-mlops-adv"></a> | **MLOps (Adv.)** | Retrain & redeploy in < 15 min when drift hits. |
| 8 <a id="ch-8-devops-adv"></a> | **DevOps (Adv.)** | GitHub-native workflow + ChatOps in 15 min. |
| 9 <a id="ch-9-cdc-adv"></a> | **CDC (Adv.)** | Ingest each change in 500 ms; live lake mirror. |
| 10 <a id="ch-10-optimize"></a> | **Optimize** | Iceberg OPTIMIZE + Cost-Guard loop in 20 min. |

### Appendices

| ID | Title | Use |
|----|-------|-----|
| A <a id="appendix-a"></a> | 20-Check Production Checklist | One-page go-live list |
| B <a id="appendix-b"></a> | Copy-&-Paste Policy Pack | Ready-to-use IaC / policy snippets |

---

## 📂 Repo layout

➡️  See the full table in [project _plan.md §5 Repository Structure](docs/project_plan.md#5-repository-structure).

---

## ⚡️ Quick Start (~ 30 min)

1. **Clone & env‑file** – user clones repo and copies `.env.sample → .env` with AWS profile + region.
2. **Run `scripts/quick_start.sh`** – the wrapper script orchestrates everything below:

   * *Terraform* `init → apply` to provision minimal lakehouse stack (S3 / Glue / Iceberg catalog, etc.).
   * *Infracost* check to surface projected monthly spend.
   * *Smoke workflow* triggers (`ci/ci_smoke.yml`) to prove infra is reachable.
   * *Budget Alarm* example deploys a Cost‑Explorer alert at ¥3 000 / mo.
   * Prints **Next Steps** (dbt seed, notebook URL, teardown command).
3. **Optional `make destroy`** – one‑liner to clean all resources.

*Outcome: working, budget‑guarded lakehouse in ≈30 min.*

```bash
git clone https://github.com/mikieto/lakehouse-code.git
cd lakehouse-code

# Deploy everything (≈ 20-25 min)
./scripts/quick_start.sh --deploy

# Smoke-test Iceberg round-trip (< 1 min)
bash pipelines/run_demo_queries.sh
````

**Destroy**: `./scripts/quick_start.sh --destroy` (≈ 3 min)

---

## ✅ Exit Criteria

| # | Objective         | Pass condition                      | Verifier                                       |
| - | ----------------- | ----------------------------------- | ---------------------------------------------- |
| 1 | 30-min deploy     | `make up` ≤ 30 min                  | `ci_plan_apply` stopwatch                      |
| 2 | Data loop         | Iceberg → Athena returns ≥ 1 row    | `pipelines/run_demo_queries.sh`                |
| 3 | CI green          | `ci_guard` succeeds 3 ×             | `ci_guard.yml`                                 |
| 4 | Lineage           | Marquez UI shows ≥ 1 job            | `ci_lineage_check`                             |
| 5 | 100 % IaC         | `terraform plan` shows 0 unmanaged  | guard output                                   |
| 6 | Security baseline | Lake Formation mask hides **ssn**   | `pipelines/tests/lakeformation_mask.sql`       |
| 7 | Fin/Obs guard     | Budgets alarm + CW dash ≥ 3 metrics | [`docs/budget_alarm.md`](docs/budget_alarm.md) |

---

## 🔗 FinOps Alarm Guide

See **[`docs/budget_alarm.md`](docs/budget_alarm.md)** for the 5-step procedure to verify cost alerts.
← Back to [Reading Guide](#reading-guide)

---

## 🤝 Contributing & License

* Fork → feature branch → `make smoke` → PR (**guard must be green**).
* Licensed under **MIT**. Monthly cost badge assumes *us-east-1* and default data size (< 1 GB).

Happy building 🎉 — Questions? Open an issue or DM [@mikieto](https://twitter.com/mikieto).
