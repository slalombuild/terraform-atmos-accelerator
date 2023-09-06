resource "azurerm_log_analytics_workspace" "main" {
  name                = module.naming.log_analytics_workspace.name_unique
  location            = local.resource_group.location
  resource_group_name = local.resource_group.name
  retention_in_days   = 30
  sku                 = "PerGB2018"
  tags                = var.default_tags
  depends_on = [
    azurerm_resource_group.main
  ]
}

resource "azurerm_log_analytics_solution" "main" {
  location              = local.resource_group.location
  resource_group_name   = local.resource_group.name
  solution_name         = "ContainerInsights"
  workspace_name        = azurerm_log_analytics_workspace.main.name
  workspace_resource_id = azurerm_log_analytics_workspace.main.id
  plan {
    product   = "OMSGallery/ContainerInsights"
    publisher = "Microsoft"
  }
  tags = var.default_tags
}
