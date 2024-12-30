output "account_info_map" {
  description = <<-EOT
    A map from account name to various information about the account.
    See the `account_info_map` output of `account` for more detail.
    EOT
  value       = local.account_info_map
}

output "all_accounts" {
  description = "A list of all accounts in the AWS Organization"
  value       = local.all_accounts
}

output "artifacts_account_account_name" {
  description = "The short name for the artifacts account"
  value       = var.artifacts_account_account_name
}

output "audit_account_account_name" {
  description = "The short name for the audit account"
  value       = var.audit_account_account_name
}

output "aws_partition" {
  description = "The AWS \"partition\" to use when constructing resource ARNs"
  value       = local.aws_partition
}

output "cicd_profiles" {
  description = "OBSOLETE: dummy results returned to avoid breaking code that depends on this output"
  value       = local.empty_account_map
}

output "cicd_roles" {
  description = "OBSOLETE: dummy results returned to avoid breaking code that depends on this output"
  value       = local.empty_account_map
}

output "dns_account_account_name" {
  description = "The short name for the primary DNS account"
  value       = var.dns_account_account_name
}

output "eks_accounts" {
  description = "A list of all accounts in the AWS Organization that contain EKS clusters"
  value       = local.eks_accounts
}

output "full_account_map" {
  description = "The map of account name to account ID (number)."
  value       = local.full_account_map
}

output "helm_profiles" {
  description = "OBSOLETE: dummy results returned to avoid breaking code that depends on this output"
  value       = local.empty_account_map
}

output "helm_roles" {
  description = "OBSOLETE: dummy results returned to avoid breaking code that depends on this output"
  value       = local.empty_account_map
}

output "iam_role_arn_templates" {
  description = "Map of accounts to corresponding IAM Role ARN templates"
  value       = local.iam_role_arn_templates
}

output "identity_account_account_name" {
  description = "The short name for the account holding primary IAM roles"
  value       = var.identity_account_account_name
}

resource "local_file" "account_info" {
  content = templatefile("${path.module}/account-info.tftmpl", {
    account_info_map = local.account_info_map
    account_profiles = local.account_profiles
    account_role_map = local.account_role_map
    namespace        = module.this.namespace
    source_profile   = coalesce(var.aws_config_identity_profile_name, format("%s-identity", module.this.namespace))
  })
  filename = "${path.module}/account-info/${module.this.id}.sh"
}

output "non_eks_accounts" {
  description = "A list of all accounts in the AWS Organization that do not contain EKS clusters"
  value       = local.non_eks_accounts
}

output "org" {
  description = "The name of the AWS Organization"
  value       = data.aws_organizations_organization.organization
}

output "profiles_enabled" {
  description = "Whether or not to enable profiles instead of roles for the backend"
  value       = var.profiles_enabled
}

output "root_account_account_name" {
  description = "The short name for the root account"
  value       = var.root_account_account_name
}

output "root_account_aws_name" {
  description = "The name of the root account as reported by AWS"
  value       = var.root_account_aws_name
}

output "terraform_access_map" {
  description = <<-EOT
  Mapping of team Role ARN to map of account name to terraform action role ARN to assume

  For each team in `aws-teams`, look at every account and see if that team has access to the designated "apply" role.
    If so, add an entry `<account-name> = "apply"` to the `terraform_access_map` entry for that team.
    If not, see if it has access to the "plan" role, and if so, add a "plan" entry.
    Otherwise, no entry is added.
  EOT
  value       = local.dynamic_role_enabled ? local.role_arn_terraform_access : null
}

output "terraform_dynamic_role_enabled" {
  description = "True if dynamic role for Terraform is enabled"
  value       = local.dynamic_role_enabled
}

output "terraform_profiles" {
  description = "A list of all SSO profiles used to run terraform updates"
  value       = local.terraform_profiles
}

output "terraform_role_name_map" {
  description = "Mapping of Terraform action (plan or apply) to aws-team-role name to assume for that action"
  value       = local.dynamic_role_enabled ? var.terraform_role_name_map : null
}

output "terraform_roles" {
  description = "A list of all IAM roles used to run terraform updates"
  value       = local.terraform_roles
}
