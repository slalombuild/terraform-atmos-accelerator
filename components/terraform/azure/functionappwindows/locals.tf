locals {
  app_insights          = "" #try(data.azurerm_application_insights.app_insights[0], try(azurerm_application_insights.app_insights[0], {}))
  app_service_plan_name = var.app_service_plan_name != null ? var.app_service_plan_name : module.naming.app_service_plan.name
  auth_settings_v2 = merge({
    auth_enabled = false
  }, var.auth_settings_v2)
  auth_settings_v2_login = try(var.auth_settings_v2.login, local.auth_settings_v2_login_default)
  auth_settings_v2_login_default = {
    token_store_enabled               = false
    token_refresh_extension_time      = 72
    preserve_url_fragments_for_logins = false
    cookie_expiration_convention      = "FixedTime"
    cookie_expiration_time            = "08:00:00"
    validate_nonce                    = true
    nonce_expiration_time             = "00:05:00"
  }
  cidrs = [for cidr in var.authorized_ips : {
    name                      = "ip_restriction_cidr_${join("", [1, index(var.authorized_ips, cidr)])}"
    ip_address                = cidr
    virtual_network_subnet_id = null
    service_tag               = null
    priority                  = join("", [1, index(var.authorized_ips, cidr)])
    action                    = "Allow"
    headers                   = local.ip_restriction_headers
  }]
  default_application_settings = ""
  default_ip_restrictions_headers = {
    x_azure_fdid      = null
    x_fd_health_probe = null
    x_forwarded_for   = null
    x_forwarded_host  = null
  }
  default_site_config = {
    always_on                              = !local.is_consumption && !local.is_elastic_premium
    application_insights_connection_string = "" # var.application_insights_enabled ? local.app_insights.connection_string : null
    application_insights_key               = "" # var.application_insights_enabled ? local.app_insights.instrumentation_key : null
  }
  flattened_role_assignments = flatten([
    for role, principals in var.role_assignment : [
      for principal in principals : {
        role      = role
        principal = data.azuread_group.principal[principal].object_id
      }
    ]
  ])
  function_app_application_settings = merge({
    "APPINSIGHTS_INSTRUMENTATIONKEY" : var.function_app_settings.appinsights_name != null ? data.azurerm_application_insights.appinsights[0].instrumentation_key : null
    "COSMOSDB_DATABASE_NAME" : var.function_app_settings.cosmosdb_account_name != null && var.function_app_settings.cosmosdb_database_name != null ? replace("${module.cosmosdb_account_naming[0].cosmosdb_account.name}-sql-db", var.function_app_settings.cosmosdb_account_name, var.function_app_settings.cosmosdb_database_name) : null
    "COSMOSDB_CONNECTION_STR" : var.function_app_settings.cosmosdb_account_name != null ? "AccountEndpoint=${data.azurerm_cosmosdb_account.cosmos[0].endpoint};AccountKey=${data.azurerm_cosmosdb_account.cosmos[0].primary_key};" : null
    "COSMOSDB_ID" : var.function_app_settings.cosmosdb_account_name != null ? data.azurerm_cosmosdb_account.cosmos[0].id : null
  }, var.function_app_application_settings)
  # If no VNet integration, allow Function App outbound public IPs
  function_outbound_ips  = var.function_app_vnet_integration == null ? distinct(concat(azurerm_windows_function_app.windows_function.possible_outbound_ip_address_list, azurerm_windows_function_app.windows_function.outbound_ip_address_list)) : []
  ip_restriction_headers = var.ip_restriction_headers != null ? [merge(local.default_ip_restrictions_headers, var.ip_restriction_headers)] : []
  is_consumption         = false # contains(["Y1"], data.azurerm_service_plan.plan.sku_name)
  is_elastic_premium     = false # contains(["EP1", "EP2", "EP3"], data.azurerm_service_plan.plan.sku_name)
  is_local_zip           = length(regexall("^(http(s)?|ftp)://", var.application_zip_package_path != null ? var.application_zip_package_path : 0)) == 0
  resource_group_name    = var.resource_group_name != null ? var.resource_group_name : module.naming.resource_group.name
  scm_cidrs = [for cidr in var.scm_authorized_ips : {
    name                      = "scm_ip_restriction_cidr_${join("", [1, index(var.scm_authorized_ips, cidr)])}"
    ip_address                = cidr
    virtual_network_subnet_id = null
    service_tag               = null
    priority                  = join("", [1, index(var.scm_authorized_ips, cidr)])
    action                    = "Allow"
    headers                   = local.scm_ip_restriction_headers
  }]
  scm_ip_restriction_headers = var.scm_ip_restriction_headers != null ? [merge(local.default_ip_restrictions_headers, var.scm_ip_restriction_headers)] : []
  scm_service_tags = [for service_tag in var.scm_authorized_service_tags : {
    name                      = "scm_service_tag_restriction_${join("", [1, index(var.scm_authorized_service_tags, service_tag)])}"
    ip_address                = null
    virtual_network_subnet_id = null
    service_tag               = service_tag
    priority                  = join("", [1, index(var.scm_authorized_service_tags, service_tag)])
    action                    = "Allow"
    headers                   = local.scm_ip_restriction_headers
  }]
  scm_subnets = [for subnet in var.scm_authorized_subnet_ids : {
    name                      = "scm_ip_restriction_subnet_${join("", [1, index(var.scm_authorized_subnet_ids, subnet)])}"
    ip_address                = null
    virtual_network_subnet_id = subnet
    service_tag               = null
    priority                  = join("", [1, index(var.scm_authorized_subnet_ids, subnet)])
    action                    = "Allow"
    headers                   = local.scm_ip_restriction_headers
  }]
  service_tags = [for service_tag in var.authorized_service_tags : {
    name                      = "service_tag_restriction_${join("", [1, index(var.authorized_service_tags, service_tag)])}"
    ip_address                = null
    virtual_network_subnet_id = null
    service_tag               = service_tag
    priority                  = join("", [1, index(var.authorized_service_tags, service_tag)])
    action                    = "Allow"
    headers                   = local.ip_restriction_headers
  }]
  site_config       = {} # merge(local.default_site_config, var.site_config)
  staging_slot_name = "staging-slot"
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_network_rules#ip_rules
  # > Small address ranges using "/31" or "/32" prefix sizes are not supported. These ranges should be configured using individual IP address rules without prefix specified.
  storage_ips = distinct(flatten([for cidr in distinct(concat(local.function_outbound_ips, var.storage_account_authorized_ips)) :
    length(regexall("/3[12]$", cidr)) > 0 ? [cidrhost(cidr, 0), cidrhost(cidr, -1)] : [cidr]
  ]))
  subnets = length(var.authorized_subnets) > 0 ? [for subnet in var.authorized_subnets : {
    name                      = "ip_restriction_subnet_${join("", [1, index(var.authorized_subnets, subnet)])}"
    ip_address                = null
    virtual_network_subnet_id = data.azurerm_subnet.authorized_subnets[subnet.subnet_name].id
    service_tag               = null
    priority                  = join("", [1, index(var.authorized_subnets, subnet)])
    action                    = "Allow"
    headers                   = local.ip_restriction_headers
  }] : []
  zip_package_url = ""
}
