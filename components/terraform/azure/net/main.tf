module "naming" {
  source        = "Azure/naming/azurerm"
  version       = "0.3.0"
  unique-length = 4
  suffix        = [var.component_suffix]
}

resource "azurerm_resource_group" "this" {
  count = var.create_resource_group ? 1 : 0

  location = local.resource_group.location
  name     = local.resource_group.name
  tags     = var.default_tags
}

