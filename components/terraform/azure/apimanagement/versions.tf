terraform {
  required_version = ">=1.3"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.53.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "< 4.15"
    }
  }
}
