# Role ARN and names for automation roles
variable "iac_automation_role_arn" {
  type        = string
  description = "Existing IaC role ARN for Automation account"
}

variable "iac_automation_role_name" {
  type        = string
  description = "Existing IaC role name for Automation account"
}

# Account IDs
variable "accounts" {
  type = map(number)
  default = {
    auto    = null
    dev     = null
    staging = null
    prod    = null
  }
  description = "Map of Account IDs to be used"
}

# Name of the project for which this is being deployed
variable "project_name" {
  type        = string
  default     = ""
  description = "The name of the project into which this is being deployed"
}
