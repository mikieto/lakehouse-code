# infra/variables.tf

variable "prefix" {
  description = "Common prefix for all resource names"
  type        = string
}

variable "env" {
  description = "Environment name (dev, prod, etc.)"
  type        = string
}
variable "budget_email" {
  description = "Who gets the cost alarm"
  type        = string
}
