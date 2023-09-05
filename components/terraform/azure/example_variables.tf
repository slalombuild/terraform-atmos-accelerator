# Resource group variables

variable "resource_group_name" {
  type        = string
  description = "The name to use for the resource group; if changed, forces creation of a new resource group"
  default     = ""
}

variable "resource_group_location" {
  type        = string
  description = "The Azure region to create the resource group in; if changed, forces creation of a new resource group"
  default     = ""
}

# OIDC variables
variable "oidc_request_token" {
  type        = string
  description = "(For OIDC with GitHub Actions) Do not declare in *.tfvars -- instead store in Key Vault as ACTIONS_ID_TOKEN_REQUEST_TOKEN"
  default     = ""
}

variable "oidc_request_url" {
  type        = string
  description = "(For OIDC with GitHub Actions) Do not declare in *.tfvars -- instead store in Key Vault as ACTIONS_ID_TOKEN_REQUEST_URL"
  default     = ""
}
