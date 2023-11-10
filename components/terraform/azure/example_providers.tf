terraform {
  required_version = ">1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.80.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  tenant_id       = var.azure_tenant_id

  use_oidc = true # OIDC is the best-practice approach for authenticating the Service Principal

  # If using GitHub Actions
  oidc_request_token = var.oidc_request_token
  oidc_request_url   = var.oidc_request_url

  # For generic OIDC providers
  # Support for oidc_token_file_path is not implemented, to discourage committing file contents to source control
  # oidc_token = var.oidc_token
}

# Creates a resource group (required to hold all virtual resources)
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.resource_group_location
}


