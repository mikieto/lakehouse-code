# Appendix B — Copy-and-Paste Policy Pack

*Lakehouse-code* · Last updated: TODO-DATE

This appendix collects reusable *Policy-as-Code* snippets that enforce the
principles in Appendix A. Copy what you need, tweak the variables, and drop the
file into your own repo.

---

## 🛡️ AWS Budget Alarm (Terraform)

```hcl
module "budget_alarm" {
  source  = "terraform-aws-modules/budgets/aws"
  version = "~> 5.0"

  name              = var.project
  limit_amount      = var.cost_limit   # default: 20
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  notifications     = ["ACTUAL > 80"]
  subscriber_emails = [var.alert_email]
}
```

---

## 🔑 IAM Least-Privilege Guard (OPA / Rego)

```rego
package iam.guardrails

default allow = false

allow {
  input.action == " iam:PassRole "
  startswith(input.role, "arn:aws:iam::${ACCOUNT_ID}:role/lh-")
  not contains(input.role, ":admin")
}
```

---

## ✅ GitHub Workflow Drift Check (Bash)

```bash
#!/usr/bin/env bash
# Fail if ci/workflows and .github/workflows differ.

set -euo pipefail
diff -qr ci/workflows .github/workflows >/dev/null && {
  echo "✅  No CI drift."
} || {
  echo "❌  Drift detected, run: make sync-ci"
  exit 1
}
```

---

## Usage notes

* **Terraform** modules follow the **zero-input, sensible-default** pattern; override only what you really need.
* **Rego** snippets assume an `OPA` check step in `ci/guard.yml`.
* **Shell guards** can be wired into a pre-commit hook or run in CI.

> **TODO:** Add Data Catalog, Encryption, and SLSA provenance policies next.
