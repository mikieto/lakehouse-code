# random.tf
resource "random_pet" "ci_suffix" {
  length    = 2
  separator = "-"
  keepers = {
    is_ci = terraform.workspace == "ci"
  }
}
