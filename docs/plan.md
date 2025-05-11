# Project Plan — *lakehouse‑code*

> **Scope** – Freeze a **complete, runnable Lakehouse codebase (v0.9)** in Prep Week, then keep it green with CI guard rails. Book‑writing timeline is tracked in *lakehouse‑book*.

---

## 1. Purpose (WHY)

Make it possible for any learner to deploy & tear down a fully managed Bronze → Gold Lakehouse in **≤ 30 minutes** for **≤ \$20 USD / ¥3 000 JPY per month** — code first, docs later.

---

## 2. Goals (WHAT)

### 2.1 World‑State KPI

| KPI                   | Target   | Validation                |
| --------------------- | -------- | ------------------------- |
| Quick‑Start runtime   | ≤ 30 min | CI smoke + stopwatch      |
| Pipeline success rate | ≥ 95 %   | `e2e.yml` workflow        |
| p95 query latency     | < 200 ms | Locust load test          |
| MTTR                  | < 30 min | Chaos script + alert test |

### 2.2 Policy‑Norm KPI

| Metric                 | Target          | Enforcement         |
| ---------------------- | --------------- | ------------------- |
| Monthly AWS cost       | ≤ \$20 / ¥3 000 | Infracost + Budgets |
| CO₂ / month            | ≤ 50 kg         | Carbon‑Calc script  |
| SBOM & cosign coverage | 100 %           | `sbom.yml` workflow |
| Data‑contract pass     | 100 % tables    | Great Expectations  |

---

## 3. Execution (HOW)

1. **Prep Week – Code v0.9 freeze**

   * Terraform/CDK for all resources (Bronze→Gold, MLflow→SageMaker, Backstage on App Runner)
   * Sample data (orders/users CSV) loaded
   * Guard CI (`guard.yml`, `smoke.yml`, `infra.yml`) passes
   * Tag **`v0.9.0`** pushed
2. **Policy‑as‑Code & Fin/Green‑Ops**

   * OPA/Rego, tfsec, Infracost, Budgets
   * 12‑hour auto‑Destroy cron for disposable services
3. **SBOM + cosign** – Syft generates SPDX, `infra.yml` signs via GitHub OIDC.
4. **Two‑person PR → auto‑apply** – Protected branches `infra/*` & `pipelines/*`.
5. **Smoke → Full E2E** – `quick-start.sh --smoke` local, then `--use-serverless`.
6. **Cost hardening tweaks**

   * **App Runner Auto‑Pause** enabled (0 ACU when idle) to cut always‑on cost.
   * **Grafana dashboards** migrated to CloudWatch + CloudFront; Managed Grafana becomes *optional* add‑on.
7. **Rapid‑win simplifications**

   * **Composite GitHub Action** – extract common steps in `guard`, `smoke`, `infra` to `./.github/actions/common`, reducing YAML duplication.
   * **Slim Makefile** with 5 targets: `deploy`, `smoke`, `destroy`, `lint`, `docs`; gives learners one‑liner commands.
   * **Flat Terraform root** – v0.9 can live in a single root module; deeper modules are optional refactors, lowering onboarding time.

---

## 4. Timeline

| Phase                  | Deliverables                                                                               | CI Gate                           |
| ---------------------- | ------------------------------------------------------------------------------------------ | --------------------------------- |
| **Prep Week (Step 0)** | • **Code v0.9 tag** (Bronze→Gold, MLflow→SageMaker, Backstage Catalog)<br>• Guard CI green | `guard.yml` + `smoke.yml` passing |
| **Maintenance (W1 +)** | • Weekly dependency bump<br>• CI keep‑green                                                | CI passes                         |

---

## 5. Done Criteria

* [ ] Quick‑Start deploys in ≤ 30 min, reproducible
* [ ] All KPI / Policy‑Norm targets met
* [ ] README badges *passing*
* [ ] `CHANGELOG` updated & Git tag `v0.9.0` pushed

---

## 6. Ownership

| Area                  | Owner         | Reviewers     |
| --------------------- | ------------- | ------------- |
| Infra (Terraform/CDK) | @platform‑sre | @data‑eng     |
| Pipelines & ETL       | @data‑eng     | @platform‑sre |
| CI / Guard            | @platform‑sre | @editor       |

---

## 7. Risks & Mitigations

| Risk               | Impact                | Mitigation                         |
| ------------------ | --------------------- | ---------------------------------- |
| Prep Week slip     | Book schedule delayed | Scope lock + daily stand‑up        |
| AWS cost spike     | Learner churn         | Budgets alert + nightly Destroy    |
| Service API change | CI fails              | Pin versions + weekly update check |

---

### ✍️ Change Log

| Date       | Author  | Summary                                     |
| ---------- | ------- | ------------------------------------------- |
| 2025‑05‑11 | @editor | Add cost tweaks/quick-win simplifications   |
| 2025‑05‑11 | @editor | Replace plan with Code v0.9 freeze timeline |
| 2025-05-11 | @editor | Revise for code-first (v0.9) release        |
