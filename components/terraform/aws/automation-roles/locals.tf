locals {
  # If the account ID exists in`vars.accounts`, define the role arn variable in question according to formatting. Otherwise, initialize an empty variable.
  automation_user_admin_role_arn = lookup(var.accounts, "auto", null) != null ? format("arn:aws:iam::%s:role/accelerator-auto-automation-role", var.accounts["auto"]) : ""
  dev_user_admin_role_arn        = lookup(var.accounts, "dev", null) != null ? format("arn:aws:iam::%s:role/accelerator-dev-automation-role", var.accounts["dev"]) : ""
  prod_user_admin_role_arn       = lookup(var.accounts, "prod", null) != null ? format("arn:aws:iam::%s:role/accelerator-prod-automation-role", var.accounts["prod"]) : ""
  staging_user_admin_role_arn    = lookup(var.accounts, "staging", null) != null ? format("arn:aws:iam::%s:role/accelerator-staging-automation-role", var.accounts["staging"]) : ""
}
