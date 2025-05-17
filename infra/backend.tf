# infra/backend.tf

terraform {
  backend "s3" {
    use_lockfile = true
  }
}
