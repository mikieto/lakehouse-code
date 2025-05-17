# Contributing to **lakehouse-code**

Thank you for helping us build the 30-minute Lakehouse!  
Please follow the rules below to keep the repo clean and reproducible.

---

## 1  Branch & PR workflow

| Step | Rule | Example |
|------|------|---------|
| Branch name | `<type>/<topic>` (kebab) | `feat/ci_guard`, `fix/lf_mask` |
| Commit      | ≤ 50 chars, imperative  | `chore: unify naming to snake_case` |
| PR title    | `[type] short summary`  | `[feat] add EMR Serverless module` |

### Docs-only quick-fixes

Small documentation-only changes (typos, broken links, wording tweaks  
**that touch no code or CI**) may be pushed directly to **`main`**.  
If a doc change is substantial or can affect build/CI/infrastructure,  
use the normal PR workflow so others can review.

---

## 2  Naming convention

| Category | Allowed case | Prefix / Scope | Example |
|----------|--------------|----------------|---------|
| Directories & files          | **snake_case** (default) | – | `spark_demo/`, `ci_plan_apply.yml` |
|                              | **exception** (skip via `.case_check_ignore`) | – | `portal/docker-compose.yml` |
| Terraform modules            | snake_case | – | `emr_serverless/` |
| Terraform identifiers        | snake_case | – | `resource "aws_s3_bucket" "raw_data"` |
| GitHub workflows             | snake_case | `ci_` or `cd_` | `ci_guard.yml`, `cd_release.yml` |
| Scripts (.sh / .py)          | snake_case | verb first | `run_demo_queries.sh` |
| Make targets                 | snake_case | – | `pipeline_demo`, `nuke` |
| Variables / env              | UPPER_SNAKE | – | `ALERT_EMAIL`, `IS_PROD` |
| Git branches                 | kebab-case | `<type>/<topic>` | `feat/ci-guard`, `fix/ingest-bug` |
| External resource names (S3, IAM, tags) | kebab-case **or vendor default** | value-only | `lh-demo-landing-zone`, `emr-serverless-job` |

> **Guideline** — kebab-case is **allowed only** for human-facing *values*  
> (S3 bucket name, AWS tag, etc.) and for Git branch names.  
> Everything that appears in code (files, modules, identifiers) must be snake_case.

### Case-check exceptions

If you must keep a kebab-case filename (e.g. `docker-compose.yml`), add its
relative path to **`.case_check_ignore`** so the pre-commit hook skips it:

```bash
echo "portal/docker-compose.yml" >> .case_check_ignore
git add .case_check_ignore
````

---

## 3  Pre-commit checklist

Run:

```bash
pre-commit run --all-files
```

Required hooks: **`black` · `isort` · `shellcheck` · `codespell` · `case-check`**.

---

## 4  Code of conduct

Be kind, be specific, cite sources, and assume positive intent.
