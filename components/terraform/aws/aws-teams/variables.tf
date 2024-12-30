variable "region" {
  type        = string
  description = "AWS Region"
}

variable "teams_config" {
  type = map(object({
    denied_teams            = list(string)
    denied_permission_sets  = list(string)
    denied_role_arns        = list(string)
    max_session_duration    = number # in seconds 3600 <= max <= 43200 (12 hours)
    role_description        = string
    role_policy_arns        = list(string)
    aws_saml_login_enabled  = bool
    allowed_roles           = optional(map(list(string)), {})
    trusted_teams           = list(string)
    trusted_permission_sets = list(string)
    trusted_role_arns       = list(string)
  }))
  description = "A roles map to configure the accounts."
}

variable "account_map_environment_name" {
  type        = string
  default     = "gbl"
  description = "The name of the environment where `account_map` is provisioned"
}

variable "account_map_stage_name" {
  type        = string
  default     = "root"
  description = "The name of the stage where `account_map` is provisioned"
}

variable "aws_saml_environment_name" {
  type        = string
  default     = "gbl"
  description = "The name of the environment where SSO is provisioned"
}

variable "aws_saml_stage_name" {
  type        = string
  default     = "identity"
  description = "The name of the stage where SSO is provisioned"
}

variable "trusted_github_repos" {
  type        = map(list(string))
  default     = {}
  description = <<-EOT
    Map where keys are role names (same keys as `teams_config`) and values are lists of
    GitHub repositories allowed to assume those roles. See `account-map/modules/github-assume-role-policy.mixin.tf`
    for specifics about repository designations.
    EOT
}
