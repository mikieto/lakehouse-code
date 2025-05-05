# Lakehouse Code

Source code, Terraform, dbt models, and demo pipelines for the **Lakehouse Code** project.

---

## 🚀 Development Setup

All tooling is packaged in a shared **DevBox image** and a separate
**bootstrap repository**.

```bash
# 1 Clone the lightweight bootstrap repo
git clone https://github.com/<org>/lakehouse-bootstrap
cd lakehouse-bootstrap
code .

# 2 VS Code → “Dev Containers: Reopen in Container”
#   → This repo is auto-cloned to /workspace/lakehouse-code
```

That’s it—start coding inside the container.

---

## Repo Structure (quick glance)

```md
infra/              Terraform modules
pipelines/          dbt project
docker/             Local test compose files
.github/workflows/  CI definitions
```
