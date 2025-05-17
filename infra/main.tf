# infra/main.tf
module "cost_guard" {
  source       = "./modules/cost_guard"
  full_prefix  = local.full_prefix
  budget_email = var.budget_email
}
