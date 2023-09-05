resource "azurerm_virtual_network" "aks" {
  address_space       = ["10.52.0.0/16"]
  location            = local.resource_group.location
  name                = module.naming.virtual_network.name_unique
  resource_group_name = local.resource_group.name
  depends_on = [
    azurerm_resource_group.main
  ]
  tags = var.default_tags
}

resource "azurerm_subnet" "aks" {
  address_prefixes                          = ["10.52.0.0/24"]
  name                                      = module.naming.subnet.name_unique
  resource_group_name                       = local.resource_group.name
  virtual_network_name                      = azurerm_virtual_network.aks.name
  private_endpoint_network_policies_enabled = false
}
