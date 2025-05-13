# Contributing to **lakehouse-code**

Thank you for helping us build the 30-minute Lakehouse!  
Please follow the rules below to keep the repo clean and reproducible.

## 1. Branch & PR workflow

| Step | Rule | Example |
|------|------|---------|
| Branch name | `<type>/<topic>` (kebab) | `feat/ci_guard`, `fix/lf_mask` |
| Commit      | ≤ 50 chars, imperative | `chore: unify naming to snake_case` |
| PR title    | `[type] short summary`  | `[feat] add EMR Serverless module` |

## 2. Naming convention

| Category | Allowed case | Prefix / Scope | Example |
|----------|--------------|----------------|---------|
| Directories & files  | snake_case | – | `spark_demo/`, `ci_plan_apply.yml` |
| Terraform modules    | snake_case | – | `emr_serverless/`                    |
| Terraform identifiers| snake_case | – | `resource "aws_s3_bucket" "raw_data"` |
| GitHub workflows     | snake_case | `ci_` or `cd_` | `ci_guard.yml`, `cd_release.yml` |
| Scripts (.sh/.py)    | snake_case | verb first | `run_demo_queries.sh` |
| Make targets         | snake_case | – | `pipeline_demo`, `nuke` |
| Variables / env      | UPPER_SNAKE | – | `ALERT_EMAIL`, `IS_PROD` |
| Git branches     | kebab-case | `<type>/<topic>` | `feat/ci-guard`, `fix/ingest-bug` |
| External resource names (S3 bucket, IAM role, tags) | kebab-case or vendor default | value-only | `lh-demo-landing-zone`, `emr-serverless-job` |

> *Guideline* — kebab-case is **allowed only** for human-facing *values* (S3 bucket name, AWS tag, etc.) and for Git branch names. Everything that appears in code (files, modules, identifiers) must be snake_case.

## 3. Pre-commit checklist

Run:

```bash
pre-commit run --all-files
```

Required hooks: `black`, `isort`, `shellcheck`, `codespell`, `case-check`.

## 4. Code of conduct

Be kind, be specific, cite sources, and assume positive intent.

### Add the case-check hook

```bash
mkdir -p scripts
cat > scripts/case_check.sh <<'EOF'
#!/usr/bin/env bash
bad=$(git diff --cached --name-only | grep -E '[-][a-z0-9_.]+(\.ya?ml|\.sh|\.py)$')
if [[ -n "$bad" ]]; then
  echo "✗ Kebab-case detected in file names:"
  echo "$bad"
  exit 1
fi
EOF
chmod +x scripts/case_check.sh
```

Append to `.pre-commit-config.yaml`:

```yaml
- repo: local
  hooks:
    - id: case-check
      name: snake_case_only
      entry: scripts/case_check.sh
      language: script
```
