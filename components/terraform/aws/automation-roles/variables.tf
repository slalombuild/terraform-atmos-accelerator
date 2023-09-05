# Name of the project for which this is being deployed
variable "project_name" {
  type        = string
  description = "The name of the project into which this is being deployed"
  default     = ""
}

# Account IDs
variable "accounts" {
  type        = map(number)
  description = "Map of Account IDs to be used"
  default = {
    auto    = null
    dev     = null
    staging = null
    prod    = null
  }
}

# Role ARN and names for automation roles
variable "iac_automation_role_arn" {
  type        = string
  description = "Existing IaC role ARN for Automation account"
}

variable "iac_automation_role_name" {
  type        = string
  description = "Existing IaC role name for Automation account"
}
