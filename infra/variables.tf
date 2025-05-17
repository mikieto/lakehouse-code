# infra/variables.tf

variable "prefix" {
  description = "Common prefix for all resource names"
  type        = string
  default     = "dev"
}

variable "env" {
  description = "Environment name (dev, prod, etc.)"
  type        = string
  default     = "starter-lh"
}

variable "budget_email" {
  description = "Notification address for cost alarms"
  type        = string
}
