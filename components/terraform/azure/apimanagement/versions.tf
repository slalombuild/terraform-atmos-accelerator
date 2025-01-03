terraform {
  required_version = ">=1.3"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.63.0, < 4.0"
    }
  }
}
