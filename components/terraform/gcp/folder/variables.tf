
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
