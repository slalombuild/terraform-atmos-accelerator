variable "display_name" {
  type        = string
  description = "The folder's display name. A folder's display name must be unique amongst its siblings, e.g. no two folders with the same parent can share the same display name. The display name must start and end with a letter or digit, may contain letters, digits, spaces, hyphens and underscores and can be no longer than 30 characters."
}

variable "parent" {
  type        = string
  description = "The resource name of the parent Folder or Organization. Must be of the form folders/{folder_id} or organizations/{org_id}."
}

variable "iam_bindings" {
  type = list(object({
    members = list(string),
    role    = string
  }))
  description = "One or more objects containing IAM members (users, groups, service accounts, etc.) and their respective roles that will be assigned to the folder."
  default     = []
}
