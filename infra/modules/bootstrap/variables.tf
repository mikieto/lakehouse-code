###############################################################################
# Variables – keep defaults minimal for starter
###############################################################################

variable "project" { type = string }
variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "budget_limit" {
  type    = number
  default = 20
}

variable "alert_email" { type = string }

variable "default_tags" {
  type = map(string)
  default = {
    Owner   = "mikieto"
    Project = "starter"
    Env     = "dev"
  }
}
