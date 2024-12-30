provider "aws" {
  region = var.region
  # assume_role {
  #   role_arn = format("arn:aws:iam::%s:role/accelerator-%s-automation-role", lookup(var.account_map, var.environment), var.environment)
  # }
}
