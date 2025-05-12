# variables.tf
variable "prefix" {
  description = "Resource name prefix. Use something globally unique for S3."
  type        = string
  default     = "skeleton"
}

variable "region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-1"
}

variable "budget_email" {
  description = "E-mail address for cost-alert notifications"
  type        = string
}

variable "env" {
  description = "Environment name (ci | dev | prod)"
  type        = string
}
