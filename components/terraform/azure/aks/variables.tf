variable "create_resource_group" {
  type        = bool
  description = "If true, a new resource group will be created using resource_group_name. If false, resource_group_name must be an existing resource group."
  default     = true
  nullable    = false
}

variable "key_vault_firewall_bypass_ip_cidr" {
  type        = string
  description = "IP range to allow access to Keyvault. If null, the requesting IP address will be added to enable resource provisioning."
  default     = null
}

variable "location" {
  type        = string
  description = "The Azure location to create resources in."
}

variable "managed_identity_principal_id" {
  type        = string
  description = "Managed identity principal id to use to enable keyvault access for a specific user or service principal."
  default     = null
}

variable "resource_group_name" {
  type        = string
  description = "Resource group to use when creating resources."
  default     = null
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags to apply to resources created by this component."
  default     = {}
}

variable "component_suffix" {
  type        = string
  description = "This component uses a naming module. The component_suffix will be suffixed to all resource names. Lowercase alphabet only."
  default     = "aks"
  nullable    = false
}