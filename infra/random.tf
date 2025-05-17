# infra/random.tf

resource "random_pet" "global_suffix" {
  keepers = { workspace = terraform.workspace }
  length  = 1
}
