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

variable "privileged" {
  type        = bool
  default     = false
  description = "True if the Terraform user already has access to the backend"
}

variable "profiles_enabled" {
  type        = bool
  default     = null
  description = "Whether or not to use profiles instead of roles for Terraform. Default (null) means to use global settings."
}
