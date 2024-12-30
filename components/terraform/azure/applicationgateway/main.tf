resource "azurerm_resource_group" "appgateway" {
  count = var.resource_group_name == null ? 1 : 0

  location = var.location
  name     = local.resource_group_name
  tags = merge(module.this.tags,
    {
      Component    = "applicationgateway"
      ExpenseClass = "network"
    }
  )
}

resource "time_sleep" "wait_for_creation" {
  create_duration = "60s"

  depends_on = [azurerm_resource_group.appgateway]
}

data "azurerm_resource_group" "appgateway" {
  count = var.resource_group_name != null ? 1 : 0

  name = var.resource_group_name != null ? var.resource_group_name : local.resource_group_name
}

module "application_gateway" {
  source  = "Azure/avm-res-network-applicationgateway/azurerm"
  version = "0.3.0"

  name                    = module.naming.application_gateway.name
  resource_group_name     = local.resource_group_name
  location                = var.location
  fips_enabled            = var.fips_enabled
  zones                   = var.zones
  tags                    = module.this.tags
  sku                     = var.sku
  autoscale_configuration = var.autoscale_configuration
  gateway_ip_configuration = {
    name      = "appgateway-gateway-ip-config"
    subnet_id = data.azurerm_subnet.subnet[0].id
  }
  frontend_ip_configuration_public_name = var.frontend_ip_configuration_public_name
  frontend_ip_configuration_private     = var.frontend_ip_configuration_private
  public_ip_name                        = var.public_ip_name
  frontend_ports                        = var.frontend_ports
  backend_address_pools                 = var.backend_address_pools
  backend_http_settings                 = var.backend_http_settings
  redirect_configuration                = var.redirect_configuration
  probe_configurations                  = var.probe_configurations
  http_listeners                        = var.http_listeners
  request_routing_rules                 = var.request_routing_rules
  ssl_certificates = {
    argo = {
      name                = var.ssl_certificate_name
      key_vault_secret_id = format("https://%s.vault.azure.net/secrets/%s/%s", module.kv_naming.key_vault.name, var.secret_name, var.secret_version != "" ? var.secret_version : "")
    }
  }
  waf_configuration = var.waf_configuration
  managed_identities = {
    user_assigned_resource_ids = [azurerm_user_assigned_identity.appgw_identity.id]
    system_assigned            = true
  }
  role_assignments    = var.role_assignments
  diagnostic_settings = var.diagnostic_settings
  lock                = var.lock
  create_public_ip    = true

  depends_on = [time_sleep.wait_for_creation]
}