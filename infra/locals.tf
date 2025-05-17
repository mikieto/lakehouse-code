# infra/locals.tf

data "aws_caller_identity" "current" {}

resource "random_pet" "suffix" {
  keepers = { workspace = terraform.workspace }
  length  = 1
}

locals {
  account_id  = data.aws_caller_identity.current.account_id
  base_prefix = "${var.prefix}-${var.env}-${local.account_id}"
  full_prefix = "${local.base_prefix}-${random_pet.suffix.id}"
}
