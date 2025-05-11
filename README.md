# 🚀 30-Minute Self-Service Lakehouse — *lakehouse-code*

| Guard | License | Cost ≤ $20 / month |
|-------|---------|--------------------|
| ![guard](https://img.shields.io/github/actions/workflow/status/mikieto/lakehouse-code/guard.yml?label=guard&logo=github) | ![license](https://img.shields.io/github/license/mikieto/lakehouse-code?color=blue) | ![cost](https://img.shields.io/badge/monthly_cost-≤%20$20-brightgreen) |

> **Purpose —** Spin up and tear down a **fully managed Lakehouse in ≤ 30 minutes** while keeping cloud costs **under $20 per month**. *(code v0.9 tagged)*
> A step-by-step *walk-through book* will be published soon — this repo already contains **all code** you need to follow along.

---

## 📚 What You’ll Learn

* Build an **end-to-end Bronze → Silver → Gold pipeline** in 30 minutes — 100 % Serverless
* ΔLake on **EMR Serverless**, Iceberg, Glue Streaming CDC, MLflow → SageMaker, Backstage on App Runner
* **SBOM + cosign** signing / **Great Expectations** data contracts for security & quality
* **Fin-Ops & Green-Ops**: Infracost, Budgets, auto-Destroy to optimise carbon and dollars
* AI-assisted Low-Code patterns & Internal Developer Platform integration

---

## 🏃 Quick Start

```bash
# (Optional) Work on the frozen release tag
git checkout v0.9.0

# Full hands-on (≈ 30 min, uses real AWS services)
./quick-start.sh --use-serverless

# CI smoke test (local & free)
./quick-start.sh --smoke --local-mode
```
