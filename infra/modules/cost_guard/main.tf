# infra/modules/cost_guard/main.tf

terraform {
  required_version = ">= 1.5.0"
}

variable "email" {
  type        = string
  description = "Notification address for budget alarms"
}

resource "aws_budgets_budget" "lh_monthly_budget" {
  name         = "lh_monthly_budget"
  budget_type  = "COST"
  limit_amount = "20"
  limit_unit   = "USD"
  time_unit    = "MONTHLY"
  cost_filters = { "TagKeyValue" = "Project:StarterLakehouse" }

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 90
    threshold_type      = "PERCENTAGE"
    notification_type   = "FORECASTED"
    subscriber {
      subscription_type = "EMAIL"
      address           = var.email
    }
  }
}
