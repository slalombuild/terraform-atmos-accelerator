variable "billing_account_id" {
  description = "The alphanumeric ID of the billing account the project will belong to. The user or service account performing this operation with Terraform must have Billing Account Administrator privileges (roles/billing.admin) on the GCP organization or folder the project will be deployed to."
  type        = string
}

variable "org_id" {
  type        = string
  description = "The numeric ID of the organization the project will belong to. Changing this forces a new project to be created. Only one of org_id or folder_id may be specified. If the org_id is specified then the project is created at the top level. Changing this forces the project to be migrated to the newly specified organization."
  default     = null
}

variable "folder_id" {
  type        = string
  description = "The numeric ID of the folder the project will belong to. Only one of org_id or folder_id may be specified. If the folder_id is specified, then the project is created under the specified folder. Changing this forces the project to be migrated to the newly specified folder."
  default     = null
}

variable "project_id" {
  description = "An ID for the new GCP project. Once this value is set it can't be changed."
  type        = string
}

variable "apis" {
  description = "Google APIs to enable on the new GCP project."
  type        = list(string)
  default = [
    "cloudkms.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "servicenetworking.googleapis.com",
    "serviceusage.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "iam.googleapis.com",
    "dns.googleapis.com",
    "secretmanager.googleapis.com",
    "iap.googleapis.com",
  ]
}

variable "iam_bindings" {
  type = list(object({
    members = list(string),
    role    = string
  }))
  description = "One or more objects containing IAM members (users, groups, service accounts, etc.) and their respective roles that will be assigned to the project. Note: these are project-wise permissions."
  default     = []
}

variable "labels" {
  type        = map(string)
  description = "Labels to apply to the GCP project and its resources."
  default     = {}
}

variable "skip_delete" {
  type        = bool
  description = "If true, the Terraform resource can be deleted without deleting the Project via the Google API"
  default     = false
}

variable "auto_create_network" {
  type        = bool
  description = "To create the network automatically when project is getting created"
  default     = false
}

variable "disable_dependent_services" {
  type        = bool
  description = " If true, services that are enabled and which depend on this service should also be disabled when this service is destroyed"
  default     = true
}

variable "disable_on_destroy" {
  type        = bool
  description = " If true, disable the service when the Terraform resource is destroyed"
  default     = true
}