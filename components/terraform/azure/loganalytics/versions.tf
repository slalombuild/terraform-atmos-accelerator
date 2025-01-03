terraform {
  required_version = ">=1.3"
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "< 4.15"
    }
  }
}
