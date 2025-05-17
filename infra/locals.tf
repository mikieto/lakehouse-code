# infra/locals.tf

locals {
  account_id  = data.aws_caller_identity.current.account_id
  full_prefix = "${var.prefix}-${var.env}-${local.account_id}-${random_pet.global_suffix.id}"
}
