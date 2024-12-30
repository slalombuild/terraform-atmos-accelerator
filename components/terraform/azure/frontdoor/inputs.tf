module "inputs" {
  count                 = module.this.enabled && var.key_vault_name != null ? 1 : 0
  source                = "../outputs"
  namespace             = module.this.namespace
  environment           = module.this.environment
  key_vault_name        = var.key_vault_name
  key_vault_secret_name = module.naming.frontdoor.name
  keyvault_inputs = {
    name                = module.naming.frontdoor.name
    resource_group_name = data.azurerm_resource_group.fd_rg.name
    profile_id          = azurerm_cdn_frontdoor_profile.fd_profile.id
    endpoints = try({ for i, j in azurerm_cdn_frontdoor_endpoint.fd_endpoint : i => {
      name = i.name
      id   = i.id
    host_name = i.host_name } }, {})
    origin_groups = try({ for i, j in azurerm_cdn_frontdoor_origin_group.fd_origin_group : i => {
      name = i.name
    id = i.id } }, {})
    origins = try({ for i, j in azurerm_cdn_frontdoor_origin.fd_origin : i => {
      name = i.name
    id = i.id } }, {})
    routes = try({ for i, j in azurerm_cdn_frontdoor_route.fd_route : i => {
      name = i.name
    id = i.id } }, {})
    rule_sets = try({ for i, j in azurerm_cdn_frontdoor_rule_set.fd_rule_set : i => {
      name = i.name
    id = i.id } }, {})
    rules = try({ for i, j in azurerm_cdn_frontdoor_rule.fd_rules : i => {
      name = i.name
    id = i.id } }, {})
    custom_domain_validation_token = try({ for i, j in azurerm_cdn_frontdoor_custom_domain.fd_custom_domain : i => {
      name = i.name
    id = i.id } }, {})
  }
}
