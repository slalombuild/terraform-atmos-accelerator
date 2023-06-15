# Provider variables
variable "subscription_id" {
  type        = string
  description = "Uniquely identifies your subscription to use Azure services; can be sourced from the ARM_SUBSCRIPTION_ID environment variable and set as TF_VAR_subscription_id"
  default     = ""
}

variable "tenant_id" {
  type        = string
  description = "Uniquely identifies your Azure Active Directory instance; can be sourced from the ARM_TENANT_ID environment variable and set as TF_VAR_tenant_id"
  default     = ""
}

variable "client_id" {
  type        = string
  description = "The application ID the Azure portal assigned to your application; can be sourced from the ARM_CLIENT_ID environment variable and set as TF_VAR_client_id"
  default     = ""
}

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

variable "oidc_token" {
  type        = string
  description = "(For generic OIDC providers) Contents of OIDC token. Do not declare in *.tfvars -- instead store in Key Vault as TF_VAR_oidc_token"
  default     = ""
}

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
