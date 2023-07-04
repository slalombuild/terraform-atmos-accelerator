resource "azurerm_subnet" "snet" {
  for_each = var.network.subnets

  name                 = module.naming.subnet.name_unique
  resource_group_name  = local.resource_group.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value]

  service_endpoints = [
    "Microsoft.AzureActiveDirectory",
    "Microsoft.KeyVault",
    "Microsoft.ServiceBus",
    "Microsoft.Sql",
    "Microsoft.Storage",
    "Microsoft.AzureCosmosDB"
  ]

}

# resource "azurerm_subnet_route_table_association" "snet" {
#   for_each = {
#     for subnet in keys(data.terraform_remote_state.config.outputs.network.subnets) :
#     subnet => data.terraform_remote_state.config.outputs.network.subnets[subnet]
#     if subnet != "web_app_firewall"
#   }

#   subnet_id      = azurerm_subnet.snet[each.key].id
#   route_table_id = azurerm_route_table.routes.id
# }
