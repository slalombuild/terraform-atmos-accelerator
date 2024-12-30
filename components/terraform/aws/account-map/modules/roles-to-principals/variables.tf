variable "overridable_global_environment_name" {
  type        = string
  default     = "global"
  description = "Global environment name"
}

variable "overridable_global_stage_name" {
  type        = string
  default     = "root"
  description = "The stage name for the organization management account (where the `account-map` state is stored)"
}

## The overridable_* variables in this file provide Cloud Posse defaults.
## Because this module is used in bootstrapping Terraform, we do not configure
## these inputs in the normal way. Instead, to change the values, you should
## add a `variables_override.tf` file and change the default to the value you want.
variable "overridable_global_tenant_name" {
  type        = string
  default     = ""
  description = "The tenant name used for organization-wide resources"
}

variable "overridable_team_permission_set_name_pattern" {
  type        = string
  default     = "Identity%sTeamAccess"
  description = "The pattern used to generate the AWS SSO PermissionSet name for each team"
}

variable "overridable_team_permission_sets_enabled" {
  type        = bool
  default     = true
  description = <<-EOT
    When true, any roles (teams or team-roles) in the identity account references in `role_map`
    will cause corresponding AWS SSO PermissionSets to be included in the `permission_set_arn_like` output.
    This has the effect of treating those PermissionSets as if they were teams.
    The main reason to set this `false` is if IAM trust policies are exceeding size limits and you are not using AWS SSO.
    EOT
}

variable "permission_set_map" {
  type        = map(list(string))
  default     = {}
  description = "Map of account:[PermissionSet, PermissionSet...] specifying AWS SSO PermissionSets when accessed from specified accounts"
}

variable "privileged" {
  type        = bool
  default     = false
  description = "True if the default provider already has access to the backend"
}

variable "role_map" {
  type        = map(list(string))
  default     = {}
  description = "Map of account:[role, role...]. Use `*` as role for entire account"
}

variable "teams" {
  type        = list(string)
  default     = []
  description = "List of team names to translate to AWS SSO PermissionSet names"
}
