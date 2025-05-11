# Project Plan — *lakehouse-code*

> **Mission** – Deliver a *Skeleton Lakehouse* that any learner can spin up, verify, and tear down in **≤ 30 minutes**, with **CI green** and **seven objective exit checks**.  
> *This file is the **single source of truth** for the exit-criteria table; when you update it, copy & paste the fenced block into `README.md` and `lakehouse-book/docs/00-project-plan.md`.*

---

## 1  Purpose (WHY)

Enable instant, cost-safe experimentation.  
Learners should achieve a *first win in thirty minutes* on a clean AWS account, then dig deeper layer-by-layer.

---

## 2  Exit Criteria – **Skeleton-Done**

> **Always edit the table *here*.** Copy the entire `BEGIN/END` block to other docs when it changes.

<!-- BEGIN EXIT_CRITERIA -->
| # | Objective Check | Pass Condition | Verifier |
|---|-----------------|----------------|----------|
| 1 | **30-min deploy** | `make up` completes in ≤ 30 min | CI stopwatch artifact |
| 2 | **Data loop** | CSV → Iceberg → Athena returns a row | `run_demo_queries.sh` |
| 3 | **CI green** | Guard workflow succeeds **3×** consecutively | `guard.yml` |
| 4 | **Lineage graph** | Marquez UI shows ≥ 1 job/node | Screenshot |
| 5 | **100 % IaC** | `terraform plan` shows 0 unmanaged | Guard output |
| 6 | **Security baseline** | Lake Formation column mask hides **ssn** | SQL test |
| 7 | **Fin/Obs guards** | Budgets alarm + CloudWatch dashboard with ≥ 3 metrics | Terraform outputs |
<!-- END EXIT_CRITERIA -->

*The first commit that passes all seven checks is tagged **`skeleton-done`** and freezes the base for further work.*

---

## 3  Key Performance Indicators

| KPI | Target | Validation |
|-----|--------|------------|
| Quick-Start runtime | ≤ 30 min | CI stopwatch |
| Monthly AWS cost | ≤ US $20 | Infracost + Budgets alert test |
| CI success streak | ≥ 95 % | `e2e.yml` history |
| Data-contract pass rate | 100 % tables | Great Expectations |

---

## 4  Execution Roadmap

| Sprint | Focus | Major Tasks | Owner |
|--------|-------|-------------|-------|
| **S-0 Bootstrap** | Local smoke + DevContainer | Dockerised Kafka + MinIO, `make smoke` | Data Eng |
| **S-1 Skeleton Deploy** | AWS serverless stack | Terraform modules, `quick-start.sh` | Platform SRE |
| **S-2 Quality & Lineage** | GE tests + Marquez | Seed expectations, OpenLineage | Data Eng |
| **S-3 Fin/Sec Guard-rails** | Budgets + Lake Formation | Cost alarm, column mask | SecOps |
| **S-4 CI Hardening** | Repeatability | Guard matrix, optional self-hosted runner | DevOps |
| **S-5 Freeze** | Tag & docs sync | Stopwatch proof, push `skeleton-done` | All |

---

## 5  Timeline (Weeks)

| Week | Deliverables | CI Gate |
|------|--------------|---------|
| **W0** | DevContainer + local smoke green | `smoke.yml` |
| **W1** | Serverless deploy ≤ 30 min | `deploy.yml` |
| **W2** | Lineage & GE tests pass | `e2e.yml` |
| **W3** | Budgets, mask, IaC 100 % | `guard.yml` |
| **W4** | **`skeleton-done` tag** + artefacts | Manual stopwatch + CI |

---

## 6  Ownership

| Area | Primary | Reviewers |
|------|---------|-----------|
| Terraform modules | @platform-sre | @secops |
| Pipelines & GE | @data-eng | @platform-sre |
| CI / DevEx | @devops | @editor |

---

## 7  Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|-----------|
| Provisioning > 30 min | Exit #1 fails | Switch fully to serverless; downsize MSK |
| AWS cost spike | Learner churn | Nightly `make nuke`; Budgets “stop-spend” |
| Lineage collector bug | Exit #4 fails | Pin OpenLineage version; health check |

---

## 8  Done Checklist

- [ ] All seven exit checks pass (`skeleton-done` tag)  
- [ ] README Quick-Start verified from fresh laptop  
- [ ] Cost & CO₂ badges green  
- [ ] CHANGELOG updated  

---

### ✍️ Change Log

| Date | Author | Summary |
|------|--------|---------|
| 2025-05-11 | @editor | Mark plan.md as canonical for Exit Criteria; added BEGIN/END block |
