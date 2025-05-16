# infra/main.tf
module "cost_guard" {
  source = "./modules/cost_guard"
  email  = var.budget_email
}
