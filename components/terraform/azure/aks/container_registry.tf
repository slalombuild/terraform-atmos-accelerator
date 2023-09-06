resource "azurerm_container_registry" "container_registry" {
  location            = var.location
  name                = module.naming.container_registry.name_unique
  resource_group_name = local.resource_group.name
  sku                 = "Premium"
  retention_policy {
    days    = 7
    enabled = true
  }
  depends_on = [
    azurerm_resource_group.main
  ]
  tags = var.default_tags
}
