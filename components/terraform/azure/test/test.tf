provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "john-resources"
  location = "WestUS2"
}

data "http" "public_ip" {
  url = "http://ipv4.icanhazip.com"
}

locals {
  public_ip = replace(data.http.public_ip.response_body, "\n", "")
}

module "keyvault" {
  source = "../keyvault"

  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "standard"
  suffix              = "john"
  public_network_access_enabled = true

  rbac_authorization_enabled = true
  admin_objects_ids = [ "8bae38e7-5781-4203-ae73-4e2b282794b8" ]
  reader_objects_ids = [ "8bae38e7-5781-4203-ae73-4e2b282794b8" ]
  network_acls = {
    ip_rules = [local.public_ip]
  }
}

output "public_ip" {
  value = local.public_ip
}
