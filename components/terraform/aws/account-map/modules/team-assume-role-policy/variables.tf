variable "allowed_permission_sets" {
  type        = map(list(string))
  default     = {}
  description = "Map of account:[PermissionSet, PermissionSet...] specifying AWS SSO PermissionSets allowed to assume the role when coming from specified account"
}

variable "allowed_principal_arns" {
  type        = list(string)
  default     = []
  description = "List of AWS principal ARNs allowed to assume the role."
}

variable "allowed_roles" {
  type        = map(list(string))
  default     = {}
  description = <<-EOT
    Map of account:[role, role...] specifying roles allowed to assume the role.
    Roles are symbolic names like `ops` or `terraform`. Use `*` as role for entire account.
    EOT
}

variable "denied_permission_sets" {
  type        = map(list(string))
  default     = {}
  description = "Map of account:[PermissionSet, PermissionSet...] specifying AWS SSO PermissionSets denied access to the role when coming from specified account"
}

variable "denied_principal_arns" {
  type        = list(string)
  default     = []
  description = "List of AWS principal ARNs explicitly denied access to the role."
}

variable "denied_roles" {
  type        = map(list(string))
  default     = {}
  description = <<-EOT
    Map of account:[role, role...] specifying roles explicitly denied permission to assume the role.
    Roles are symbolic names like `ops` or `terraform`. Use `*` as role for entire account.
    EOT
}

variable "iam_users_enabled" {
  type        = bool
  default     = false
  description = "True if you would like IAM Users to be able to assume the role."
}

variable "privileged" {
  type        = bool
  default     = false
  description = "True if the default provider already has access to the backend"
}
