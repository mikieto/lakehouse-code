# 🚀 30-Minute Self-Service Lakehouse — *lakehouse-code*

| Guard | License | Cost ≤ $20 / month |
|-------|---------|--------------------|
| ![guard](https://img.shields.io/github/actions/workflow/status/mikieto/lakehouse-code/guard.yml?label=guard&logo=github) | ![license](https://img.shields.io/github/license/mikieto/lakehouse-code?color=blue) | ![cost](https://img.shields.io/badge/monthly_cost-≤%20$20-brightgreen) |

> **Goal** – Publish a *“30-Minute Self-Service Lakehouse”* course (book + code) in **4 weeks**.  
> • AI | IDP | SBOM & SLSA | Fin- & Green-Ops | Low-Code  
> • *IaC → 2-person PR approval → auto-apply*  
> • **AWS Serverless-only**, capped at **$20 USD per month**

---

## 📚 What You’ll Learn

* Build an **end-to-end Bronze → Silver → Gold pipeline** in 30 minutes — 100 % Serverless  
* ΔLake on **EMR Serverless**, Iceberg, Glue Streaming CDC, MLflow→SageMaker, Backstage on App Runner  
* **SBOM + cosign** signing / **Great Expectations** data contracts for security & quality  
* **Fin-Ops**: Infracost, Budgets, auto-Destroy to optimise carbon and dollars

---

## 🏃 Quick Start

```bash
# Full hands-on (≈30 min, uses real AWS services)
./quick-start.sh --use-serverless

# CI smoke test (local & free)
./quick-start.sh --smoke --local-mode
