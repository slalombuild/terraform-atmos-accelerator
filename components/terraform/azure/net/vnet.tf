resource "azurerm_virtual_network" "this" {
  name                = module.naming.virtual_network.name_unique
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location
  address_space = [
    var.network.address_space
  ]
  depends_on = [
    azurerm_resource_group.this
  ]
  tags = var.default_tags
}

# resource "azurerm_private_dns_zone_virtual_network_link" "this" {
#   name                  = format("%sdns-link", local.prefix)
#   resource_group_name   = data.terraform_remote_state.dns.outputs.private_zones.env.resource_group_name
#   private_dns_zone_name = data.terraform_remote_state.dns.outputs.private_zones.env.zone_name
#   virtual_network_id    = azurerm_virtual_network.vnet.id
# }

# resource "azurerm_template_deployment" "log_analytics" {
#   name                = format("%svnet-analytics", local.prefix)
#   resource_group_name = azurerm_resource_group.rg.name

#   template_body = <<EOF
# {
#     "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
#     "contentVersion": "1.0.0.0",
#     "parameters": {},
#     "resources": [
#         {
#             "id": "${azurerm_virtual_network.vnet.id}/providers/Microsoft.Insights/diagnosticSettings/service",
#             "type": "Microsoft.Network/virtualNetworks/providers/diagnosticSettings",
#             "name": "${azurerm_virtual_network.vnet.name}/microsoft.insights/service",
#             "apiVersion": "2016-09-01",
#             "properties": {
#                 "storageAccountId": null,
#                 "serviceBusRuleId": null,
#                 "workspaceId": "${data.terraform_remote_state.logs.outputs.log_analytics.workspace_id}",
#                 "eventHubAuthorizationRuleId": null,
#                 "eventHubName": null,
#                 "metrics": [
#                     {
#                         "timeGrain": "AllMetrics",
#                         "category": "AllMetrics",
#                         "enabled": "true",
#                         "retentionPolicy": {
#                             "enabled": "false",
#                             "days": "0"
#                         }
#                     }
#                 ],
#                 "logs": [
#                     {
#                         "category": "VMProtectionAlerts",
#                         "enabled": "true",
#                         "retentionPolicy": {
#                             "enabled": "false",
#                             "days": "0"
#                         }
#                     }
#                 ]
#             }
#         }
#     ]
# }
# EOF

#   deployment_mode = "Incremental"
# }
