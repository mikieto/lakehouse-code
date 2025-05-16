# infra/main.tf
module "cost_guard" {
  source       = "./modules/cost_guard"
  budget_email = var.budget_email
}
