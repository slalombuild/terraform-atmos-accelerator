##################
# Resource Group #
##################

data "azurerm_resource_group" "la_rg" {
  name = var.resource_group_name == null ? azurerm_resource_group.la_rg[0].name : var.resource_group_name
}
