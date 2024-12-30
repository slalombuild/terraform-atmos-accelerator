output "account_arns" {
  description = "List of account ARNs (excluding root account)"
  value       = local.all_account_arns
}

output "account_ids" {
  description = "List of account IDs (excluding root account)"
  value       = local.all_account_ids
}

output "account_info_map" {
  description = <<-EOT
    Map of account names to
      eks: boolean, account hosts at least one EKS cluster
      id: account id (number)
      stage: (optional) the account "stage"
      tenant: (optional) the account "tenant"
    EOT
  value       = local.account_info_map
}

output "account_names_account_arns" {
  description = "Map of account names to account ARNs (excluding root account)"
  value       = local.account_names_account_arns
}

output "account_names_account_ids" {
  description = "Map of account names to account IDs (excluding root account)"
  value       = local.account_names_account_ids
}

output "account_names_account_scp_arns" {
  description = "Map of account names to SCP ARNs for accounts with SCPs"
  value       = local.account_names_account_scp_arns
}

output "account_names_account_scp_ids" {
  description = "Map of account names to SCP IDs for accounts with SCPs"
  value       = local.account_names_account_scp_ids
}

output "eks_accounts" {
  description = "List of EKS accounts"
  value       = local.eks_account_names
}

output "non_eks_accounts" {
  description = "List of non EKS accounts"
  value       = local.non_eks_account_names
}

output "organization_arn" {
  description = "Organization ARN"
  value       = local.organization_arn
}

output "organization_id" {
  description = "Organization ID"
  value       = local.organization_id
}

output "organization_master_account_arn" {
  description = "Organization master account ARN"
  value       = local.organization_master_account_arn
}

output "organization_master_account_email" {
  description = "Organization master account email"
  value       = local.organization_master_account_email
}

output "organization_master_account_id" {
  description = "Organization master account ID"
  value       = local.organization_master_account_id
}

output "organization_scp_arn" {
  description = "Organization Service Control Policy ARN"
  value       = join("", module.organization_service_control_policies.*.organizations_policy_arn)
}

output "organization_scp_id" {
  description = "Organization Service Control Policy ID"
  value       = join("", module.organization_service_control_policies.*.organizations_policy_id)
}

output "organizational_unit_arns" {
  description = "List of Organizational Unit ARNs"
  value       = local.organizational_unit_arns
}

output "organizational_unit_ids" {
  description = "List of Organizational Unit IDs"
  value       = local.organizational_unit_ids
}

output "organizational_unit_names_organizational_unit_arns" {
  description = "Map of Organizational Unit names to Organizational Unit ARNs"
  value       = local.organizational_unit_names_organizational_unit_arns
}

output "organizational_unit_names_organizational_unit_ids" {
  description = "Map of Organizational Unit names to Organizational Unit IDs"
  value       = local.organizational_unit_names_organizational_unit_ids
}

output "organizational_unit_names_organizational_unit_scp_arns" {
  description = "Map of OU names to SCP ARNs"
  value       = local.organizational_unit_names_organizational_unit_scp_arns
}

output "organizational_unit_names_organizational_unit_scp_ids" {
  description = "Map of OU names to SCP IDs"
  value       = local.organizational_unit_names_organizational_unit_scp_ids
}
