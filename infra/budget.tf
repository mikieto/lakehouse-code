# budget.tf - stop-spend budget: monthly cap US$20

resource "aws_budgets_budget" "skeleton" {
  name         = "${var.prefix}-monthly-budget"
  budget_type  = "COST"
  limit_amount = "20"
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  cost_filter {
    name   = "Service"
    values = ["Amazon S3", "Amazon Athena", "AWS Glue"]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    notification_type          = "FORECASTED"
    threshold                  = 90 # %
    threshold_type             = "PERCENTAGE"
    subscriber_email_addresses = [var.budget_email]
  }
}
