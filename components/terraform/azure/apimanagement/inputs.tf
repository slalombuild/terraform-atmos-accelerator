module "inputs" {
  count                 = module.this.enabled && var.key_vault_name != null ? 1 : 0
  source                = "../outputs"
  namespace             = module.this.namespace
  environment           = module.this.environment
  key_vault_name        = var.key_vault_name
  key_vault_secret_name = azurerm_api_management.apim.name
  keyvault_inputs = {
    name                            = azurerm_api_management.apim.name
    id                              = azurerm_api_management.apim.id
    resource_group_name             = data.azurerm_resource_group.apim_rg.name
    management_gateway_url          = azurerm_api_management.apim.gateway_url
    management_gateway_regional_url = azurerm_api_management.apim.gateway_regional_url
    publisher_portal_url            = azurerm_api_management.apim.portal_url
    public_ip_addresses             = azurerm_api_management.apim.public_ip_addresses
    private_ip_addresses            = azurerm_api_management.apim.private_ip_addresses
    management_api_url              = azurerm_api_management.apim.management_api_url
    identity                        = azurerm_api_management.apim.identity[0].principal_id
  }
}
