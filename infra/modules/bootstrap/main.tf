###############################################################################
# bootstrap –- Remote state, lock table, cost guard (Budgets)
###############################################################################

terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  tags = merge(var.default_tags, { "module" = "bootstrap" })
}

# --- S3 remote state bucket --------------------------------------------------
resource "aws_s3_bucket" "tf_state" {
  bucket        = "${var.project}-tf-state"
  force_destroy = true

  tags = local.tags

  # Server-side encryption (KMS)
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.state_key.arn
      }
    }
  }

  # Public access block
  lifecycle_rule {
    id      = "expire-old-versions"
    enabled = true
    noncurrent_version_expiration {
      days = 30
    }
  }
}

# KMS key for state bucket
resource "aws_kms_key" "state_key" {
  description         = "KMS key for Terraform state bucket"
  enable_key_rotation = true
  tags                = local.tags
}

# --- DynamoDB lock table -----------------------------------------------------
resource "aws_dynamodb_table" "tf_lock" {
  name         = "${var.project}_tf_lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags
}

# --- Budgets – stop-spend guard ---------------------------------------------
resource "aws_budgets_budget" "monthly_stop" {
  name         = "${var.project}-monthly-stop"
  budget_type  = "COST"
  limit_amount = var.budget_limit
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  cost_filter {
    name   = "Service"
    values = ["Amazon Simple Storage Service", "Amazon EC2", "AWS Glue"]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [var.alert_email]
  }
}
