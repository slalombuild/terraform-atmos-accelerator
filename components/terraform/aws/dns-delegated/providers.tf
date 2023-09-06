provider "aws" {
  # The AWS provider to use to make changes in the primary (main zone) account
  region = var.region
  alias  = "primary"
  assume_role {
    role_arn = format("arn:aws:iam::%s:role/%s-automation-role", var.account_map["automation"], "accelerator-auto")
  }
}

provider "aws" {
  # The AWS provider to use to make changes in the target (delegated) account
  region = var.region

  assume_role {
    role_arn = format("arn:aws:iam::%s:role/accelerator-%s-automation-role", var.account_number, var.account_name)
  }
}
