# locals.tf
data "aws_caller_identity" "current" {}

locals {
  account_id  = data.aws_caller_identity.current.account_id
  base_prefix = "${var.prefix}-${var.env}-${local.account_id}"
  full_prefix = (
    terraform.workspace == "ci" ?
    "${local.base_prefix}-${random_pet.ci_suffix.id}" :
    local.base_prefix
  )
}
