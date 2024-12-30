output "audit_terraform_profile_name" {
  description = "The AWS config profile name for Terraform to use to provision resources in the \"audit\" role account, when profiles are in use"
  value       = local.profiles_enabled ? local.account_map.terraform_profiles[local.account_map.audit_account_account_name] : null
}

output "audit_terraform_role_arn" {
  description = "The AWS Role ARN for Terraform to use to provision resources in the \"audit\" role account, when Role ARNs are in use"
  value       = local.profiles_enabled ? null : local.account_map.terraform_roles[local.account_map.audit_account_account_name]
}

output "aws_partition" {
  description = "The AWS \"partition\" to use when constructing resource ARNs"
  value       = local.account_map.aws_partition
}

output "current_account_account_name" {
  description = <<-EOT
    The account name (usually `<tenant>-<stage>`) for the account configured by this module's inputs.
    Roughly analogous to `data "aws_caller_identity"`, but returning the name of the caller account as used in our configuration.
    EOT
  value       = local.account_name
}

output "dns_terraform_profile_name" {
  description = "The AWS config profile name for Terraform to use to provision DNS Zone delegations, when profiles are in use"
  value       = local.profiles_enabled ? local.account_map.terraform_profiles[local.account_map.dns_account_account_name] : null
}

output "dns_terraform_role_arn" {
  description = "The AWS Role ARN for Terraform to use to provision DNS Zone delegations, when Role ARNs are in use"
  value       = local.profiles_enabled ? null : local.account_map.terraform_roles[local.account_map.dns_account_account_name]
}

output "global_environment_name" {
  description = "The `null-label` `environment` value used for regionless (global) resources"
  value       = var.overridable_global_environment_name
}

output "global_stage_name" {
  description = "The `null-label` `stage` value for the organization management account (where the `account-map` state is stored)"
  value       = var.overridable_global_stage_name
}

output "global_tenant_name" {
  description = "The `null-label` `tenant` value used for organization-wide resources"
  value       = var.overridable_global_tenant_name
}

output "identity_account_account_name" {
  description = "The account name (usually `<tenant>-<stage>`) for the account holding primary IAM roles"
  value       = local.account_map.identity_account_account_name
}

output "identity_terraform_profile_name" {
  description = "The AWS config profile name for Terraform to use to provision resources in the \"identity\" role account, when profiles are in use"
  value       = local.profiles_enabled ? local.account_map.terraform_profiles[local.account_map.identity_account_account_name] : null
}

output "identity_terraform_role_arn" {
  description = "The AWS Role ARN for Terraform to use to provision resources in the \"identity\" role account, when Role ARNs are in use"
  value       = local.profiles_enabled ? null : local.account_map.terraform_roles[local.account_map.identity_account_account_name]
}

output "org_role_arn" {
  description = "The AWS Role ARN for Terraform to use when SuperAdmin is provisioning resources in the account"
  value       = local.account_org_role_arn
}

output "profiles_enabled" {
  description = "When true, use AWS config profiles in Terraform AWS provider configurations. When false, use Role ARNs."
  value       = local.profiles_enabled
}

output "terraform_profile_name" {
  description = "The AWS config profile name for Terraform to use when provisioning resources in the account, when profiles are in use"
  value       = local.profiles_enabled ? local.final_terraform_profile_name : null
}

output "terraform_role_arn" {
  description = "The AWS Role ARN for Terraform to use when provisioning resources in the account, when Role ARNs are in use"
  value       = local.profiles_enabled ? null : local.final_terraform_role_arn
}

output "terraform_role_arns" {
  description = "All of the terraform role arns"
  value       = local.account_map.terraform_roles
}
