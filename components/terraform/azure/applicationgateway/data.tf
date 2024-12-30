data "azurerm_client_config" "current" {}

##########
# Subnet #
##########

data "azurerm_subnet" "subnet" {
  count = var.subnet_name != null && var.vnet_name != null ? 1 : 0

  name                 = replace(module.vnet_naming[0].subnet.name, var.vnet_name, var.subnet_name)
  resource_group_name  = module.vnet_naming[0].resource_group.name
  virtual_network_name = module.vnet_naming[0].virtual_network.name
}

#############
# Key Vault #
#############

data "azurerm_key_vault" "kv" {
  name                = module.kv_naming.key_vault.name
  resource_group_name = module.kv_naming.resource_group.name
}