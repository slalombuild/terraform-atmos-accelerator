provider "aws" {
  region = var.region
  # assume_role {
  #   role_arn = format("arn:aws:iam::%s:role/accelerator-%s-automation-role", var.account_number, var.account_name)
  # }
}
