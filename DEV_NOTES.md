# 2025-05-13 — Sprint S-1 Wrap-up

## What we did today 🗓️

1. **Remote-state & locking**  
   • Created S3 bucket `skeleton-tfstate-<acct>` and DynamoDB table `skeleton-tf-lock`.  
   • Added explicit `-backend-config` flags to `deploy.yml`; backend is remote & idempotent.

2. **CI / CD hardening**  
   • Added Infracost and production deploy workflows.  
   • Enabled OIDC (`configure-aws-credentials@v4`); purged long-lived AWS keys.  
   • Updated `.gitignore` (`.env`, `.terraform/`, `*.tfstate*`).

3. **Secret-leak remediation**  
   • Push-Protection blocked AWS keys → removed via `git filter-repo`, force-push.

4. **Infra v1 shipped**  
   • Terraform now creates Raw & Iceberg buckets, Glue DB, Athena WG, \$20 Budget.  
   • `terraform apply` on prod workspace returns **No Changes**.

5. **Data loop (Exit-2) closed**  
   • Created Iceberg table `customers` via Athena:  

     ```sql
     CREATE TABLE skeleton_db.customers (
       id INT,
       name STRING
     )
     LOCATION 's3://…-iceberg/customers/'
     TBLPROPERTIES ('table_type'='ICEBERG');
     INSERT INTO skeleton_db.customers VALUES (1,'Alice');
     ```  

   • `SELECT * FROM skeleton_db.customers LIMIT 1;` succeeds.

6. **Sprint S-1 status**  
   • Exit #1, #2, #3, #5, #7 are green.  
   • Tag `s1-complete` will be pushed after docs sync.

## Next up ▶ Sprint S-2 — Medallion layer

| Stage | Key tasks (all ≤80 chars) |
|-------|---------------------------|
| Bronze → Silver | Create `${prefix}_brz` & `${prefix}_slv`; CTAS cleanse |
| Gold            | Build `customer_lifetime_value` aggregate            |
| CI              | Add smoke: `COUNT(*) FROM slv_customers_curated`    |
| Docs            | Update diagrams & README for Medallion architecture |

# 2025-05-12 — Phase B hard-freeze preparations

- **Docs sync**: README, `docs/plan.md`, and `lakehouse-book/00_project_plan.md` now share the same BEGIN/END exit-criteria block.  
- **DevContainer**: Dockerfile ships Node 18, `markdownlint-cli 0.40.0`, and GitHub CLI; `devcontainer.json` switched to the built image (`ghcr.io/.../lakehouse-code:latest`).  
- **Pre-commit**: Node 18 is used as system runtime; gitlint/markdownlint/vale all pass.  
- **Guard CI**:  
  - `guard-pr` (label gate) unchanged.  
  - New `guard-main` job runs on every push to **main**.  
  - Main branch now shows three consecutive green runs (Exit #3).  
- **Smoke CI**: Added `push@main` trigger and `timeout-minutes: 20`.  
- **Roadmap**: Timeline bumped to **Sprint S-1** (AWS Serverless “≤ 30 min deploy”).  
- **Next steps**: push the `phase-b-complete` tag + release, then start `feat/s1-serverless-deploy`.

# 2025-05-09 Cleanup

- Removed legacy workflows: build-push.yml, ci.yml

# Phase A – Manual Bootstrap (2025-05-08)

| Step            | Done | Notes                                          |
|-----------------|------|------------------------------------------------|
| README + Badge  | ✔    | Replaced `<org>` ; Guard badge is green        |
| docs/3-files    | ✔    | Committed empty placeholder files              |
| Labels          | ✔    | Added labels: environment:s3 / norm:security   |
| guard.yml       | ✔    | Confirmed echo-only workflow runs successfully |
| PR→CI→Merge     | ✔    | Guard green, merged into main                  |
| Time spent      | ??   | Record the actual time spent                   |
