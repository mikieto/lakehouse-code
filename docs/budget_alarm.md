# FinOps Budget-Alarm Verification Guide

> **Exit #7** requires a live cost-guard.  
> Follow these five steps to prove the Budgets alarm and CloudWatch dashboard are wired correctly.

## 1. Prerequisites

* The stack is deployed (`make up` or `quick_start.sh --deploy`).
* You have **AWS CLI v2** configured with the same account/region.
* The cost budget was auto-created by Terraform (`cost_monthly`).

## 2. Locate the Budget

1. Open **AWS Console → Billing → Budgets**.  
2. Find **`lh_monthly_budget`** default limit = US $20 (≈ JP ¥3 000).  
3. Confirm the *Forecasted* line is visible.

> **Pass condition:** Budget exists and status is *OK* or *FORECASTED*.

## 3. Verify SNS Notification

1. Check **SNS → Topics → `lh_cost_alert_topic`**.
2. Confirm a message was published (or wait up to 5 min).

## 4. Inspect CloudWatch Dashboard

* **CloudWatch → Dashboards → `lh_finops_dashboard`**
* Ensure **≥ 3 widgets** are showing:

  * Forecast vs Actual
  * Daily cost trend
  * Service cost breakdown

> **Exit pass:** Alarm fired (or stays green) **and** dashboard shows all three widgets.

---

← Back to [README – Reading Guide](../README.md#reading-guide)
