resource "azurerm_resource_group" "rg" {
  count = var.resource_group_name == null ? 1 : 0

  location = var.location
  name     = module.naming.resource_group.name
  tags = merge(
    {
      Component : "functionappwindows"
      ExpenseClass : "compute"
    },
    module.this.tags
  )
}

resource "azurerm_service_plan" "plan" {
  count = var.app_service_plan_name == null ? 1 : 0

  location                     = var.location
  name                         = local.app_service_plan_name
  os_type                      = "Windows"
  resource_group_name          = data.azurerm_resource_group.func_rg.name
  sku_name                     = var.sku_name
  app_service_environment_id   = var.app_service_environment_id
  maximum_elastic_worker_count = var.maximum_elastic_worker_count
  per_site_scaling_enabled     = var.per_site_scaling_enabled
  tags = merge(
    module.this.tags,
    {
      ResourceGroup = data.azurerm_resource_group.func_rg.name
  })
  worker_count           = var.worker_count
  zone_balancing_enabled = var.zone_balancing_enabled
}

module "storage" {
  source                    = "../storage"
  name                      = module.this.name
  suffix                    = var.suffix
  context                   = module.this.context
  location                  = var.location
  resource_group_name       = data.azurerm_resource_group.func_rg.name
  account_replication_type  = var.storage_account_replication_type
  shared_access_key_enabled = var.storage_uses_managed_identity ? false : true
  network_rules = {
    virtual_network_subnets = var.function_app_vnet_integration != null ? [{
      vnet_name   = var.function_app_vnet_integration.vnet_name
      subnet_name = var.function_app_vnet_integration.subnet_name
    }] : []
  }
}

resource "azurerm_windows_function_app" "windows_function" {
  location                      = var.location
  name                          = module.naming.function_app.name
  resource_group_name           = data.azurerm_resource_group.func_rg.name
  service_plan_id               = var.app_service_plan_name != null ? data.azurerm_service_plan.app_service_plan.id : azurerm_service_plan.plan[0].id # if an app service plan is specified, lookup the id, otherwise use the newly created one
  app_settings                  = local.function_app_application_settings
  builtin_logging_enabled       = var.builtin_logging_enabled
  client_certificate_enabled    = var.client_certificate_enabled
  client_certificate_mode       = var.client_certificate_mode
  functions_extension_version   = "~${var.function_app_version}"
  https_only                    = var.https_only
  storage_account_access_key    = var.storage_uses_managed_identity ? null : module.storage.azurerm_storage_account_resource.primary_access_key
  storage_account_name          = module.storage.azurerm_storage_account_name
  storage_uses_managed_identity = var.storage_uses_managed_identity ? true : null
  tags = merge(
    module.this.tags,
    {
      ResourceGroup = data.azurerm_resource_group.func_rg.name
  })
  virtual_network_subnet_id = var.function_app_vnet_integration != null ? data.azurerm_subnet.vnet_subnet[0].id : null

  dynamic "site_config" {
    for_each = [local.site_config]

    content {
      always_on                              = lookup(site_config.value, "always_on", null)
      api_definition_url                     = lookup(site_config.value, "api_definition_url", null)
      api_management_api_id                  = lookup(site_config.value, "api_management_api_id", null)
      app_command_line                       = lookup(site_config.value, "app_command_line", null)
      app_scale_limit                        = lookup(site_config.value, "app_scale_limit", null)
      application_insights_connection_string = lookup(site_config.value, "application_insights_connection_string", null)
      application_insights_key               = lookup(site_config.value, "application_insights_key", false)
      default_documents                      = lookup(site_config.value, "default_documents", null)
      elastic_instance_minimum               = lookup(site_config.value, "elastic_instance_minimum", null)
      ftps_state                             = lookup(site_config.value, "ftps_state", "Disabled")
      health_check_eviction_time_in_min      = lookup(site_config.value, "health_check_eviction_time_in_min", null)
      health_check_path                      = lookup(site_config.value, "health_check_path", null)
      http2_enabled                          = lookup(site_config.value, "http2_enabled", null)
      ip_restriction_default_action          = var.ip_restriction_default_action
      load_balancing_mode                    = lookup(site_config.value, "load_balancing_mode", null)
      managed_pipeline_mode                  = lookup(site_config.value, "managed_pipeline_mode", null)
      minimum_tls_version                    = lookup(site_config.value, "minimum_tls_version", lookup(site_config.value, "min_tls_version", "1.2"))
      pre_warmed_instance_count              = lookup(site_config.value, "pre_warmed_instance_count", null)
      remote_debugging_enabled               = lookup(site_config.value, "remote_debugging_enabled", false)
      remote_debugging_version               = lookup(site_config.value, "remote_debugging_version", null)
      runtime_scale_monitoring_enabled       = lookup(site_config.value, "runtime_scale_monitoring_enabled", null)
      scm_type                               = lookup(site_config.value, "scm_type", null)
      scm_use_main_ip_restriction            = length(var.scm_authorized_ips) > 0 || var.scm_authorized_subnet_ids != null ? false : true
      use_32_bit_worker                      = lookup(site_config.value, "use_32_bit_worker", null)
      vnet_route_all_enabled                 = lookup(site_config.value, "vnet_route_all_enabled", var.function_app_vnet_integration != null)
      websockets_enabled                     = lookup(site_config.value, "websockets_enabled", false)
      worker_count                           = lookup(site_config.value, "worker_count", null)

      dynamic "app_service_logs" {
        for_each = lookup(site_config.value, "app_service_logs", null) != null ? ["app_service_logs"] : []

        content {
          disk_quota_mb         = lookup(site_config.value.app_service_logs, "disk_quota_mb", null)
          retention_period_days = lookup(site_config.value.app_service_logs, "retention_period_days", null)
        }
      }
      dynamic "application_stack" {
        for_each = lookup(site_config.value, "application_stack", null) == null ? [] : ["application_stack"]

        content {
          dotnet_version              = lookup(local.site_config.application_stack, "dotnet_version", null)
          java_version                = lookup(local.site_config.application_stack, "java_version", null)
          node_version                = lookup(local.site_config.application_stack, "node_version", null)
          powershell_core_version     = lookup(local.site_config.application_stack, "powershell_core_version", null)
          use_custom_runtime          = lookup(local.site_config.application_stack, "use_custom_runtime", null)
          use_dotnet_isolated_runtime = lookup(local.site_config.application_stack, "use_dotnet_isolated_runtime", null)
        }
      }
      dynamic "cors" {
        for_each = lookup(site_config.value, "cors", null) != null ? ["cors"] : []

        content {
          allowed_origins     = lookup(site_config.value.cors, "allowed_origins", [])
          support_credentials = lookup(site_config.value.cors, "support_credentials", false)
        }
      }
      dynamic "ip_restriction" {
        for_each = concat(local.subnets, local.cidrs, local.service_tags)

        content {
          action                    = ip_restriction.value.action
          headers                   = ip_restriction.value.headers
          ip_address                = ip_restriction.value.ip_address
          name                      = ip_restriction.value.name
          priority                  = ip_restriction.value.priority
          service_tag               = ip_restriction.value.service_tag
          virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id
        }
      }
      dynamic "scm_ip_restriction" {
        for_each = concat(local.scm_subnets, local.scm_cidrs, local.scm_service_tags)

        content {
          action                    = scm_ip_restriction.value.action
          headers                   = scm_ip_restriction.value.headers
          ip_address                = scm_ip_restriction.value.ip_address
          name                      = scm_ip_restriction.value.name
          priority                  = scm_ip_restriction.value.priority
          service_tag               = scm_ip_restriction.value.service_tag
          virtual_network_subnet_id = scm_ip_restriction.value.virtual_network_subnet_id
        }
      }
    }
  }
  dynamic "auth_settings_v2" {
    for_each = lookup(local.auth_settings_v2, "auth_enabled", false) ? [local.auth_settings_v2] : []

    content {
      auth_enabled                            = lookup(auth_settings_v2.value, "auth_enabled", false)
      config_file_path                        = lookup(auth_settings_v2.value, "config_file_path", null)
      default_provider                        = lookup(auth_settings_v2.value, "default_provider", "azureactivedirectory")
      excluded_paths                          = lookup(auth_settings_v2.value, "excluded_paths", null)
      forward_proxy_convention                = lookup(auth_settings_v2.value, "forward_proxy_convention", "NoProxy")
      forward_proxy_custom_host_header_name   = lookup(auth_settings_v2.value, "forward_proxy_custom_host_header_name", null)
      forward_proxy_custom_scheme_header_name = lookup(auth_settings_v2.value, "forward_proxy_custom_scheme_header_name", null)
      http_route_api_prefix                   = lookup(auth_settings_v2.value, "http_route_api_prefix", "/.auth")
      require_authentication                  = lookup(auth_settings_v2.value, "require_authentication", null)
      require_https                           = lookup(auth_settings_v2.value, "require_https", true)
      runtime_version                         = lookup(auth_settings_v2.value, "runtime_version", "~1")
      unauthenticated_action                  = lookup(auth_settings_v2.value, "unauthenticated_action", "RedirectToLoginPage")

      login {
        allowed_external_redirect_urls    = lookup(local.auth_settings_v2_login, "allowed_external_redirect_urls", null)
        cookie_expiration_convention      = lookup(local.auth_settings_v2_login, "cookie_expiration_convention", "FixedTime")
        cookie_expiration_time            = lookup(local.auth_settings_v2_login, "cookie_expiration_time", "08:00:00")
        logout_endpoint                   = lookup(local.auth_settings_v2_login, "logout_endpoint", null)
        nonce_expiration_time             = lookup(local.auth_settings_v2_login, "nonce_expiration_time", "00:05:00")
        preserve_url_fragments_for_logins = lookup(local.auth_settings_v2_login, "preserve_url_fragments_for_logins", false)
        token_refresh_extension_time      = lookup(local.auth_settings_v2_login, "token_refresh_extension_time", 72)
        token_store_enabled               = lookup(local.auth_settings_v2_login, "token_store_enabled", false)
        token_store_path                  = lookup(local.auth_settings_v2_login, "token_store_path", null)
        token_store_sas_setting_name      = lookup(local.auth_settings_v2_login, "token_store_sas_setting_name", null)
        validate_nonce                    = lookup(local.auth_settings_v2_login, "validate_nonce", true)
      }
      dynamic "active_directory_v2" {
        for_each = try(local.auth_settings_v2.active_directory_v2[*], [])

        content {
          client_id                            = lookup(active_directory_v2.value, "client_id", null)
          tenant_auth_endpoint                 = lookup(active_directory_v2.value, "tenant_auth_endpoint", null)
          allowed_applications                 = lookup(active_directory_v2.value, "allowed_applications", null)
          allowed_audiences                    = lookup(active_directory_v2.value, "allowed_audiences", null)
          allowed_groups                       = lookup(active_directory_v2.value, "allowed_groups", null)
          allowed_identities                   = lookup(active_directory_v2.value, "allowed_identities", null)
          client_secret_certificate_thumbprint = lookup(active_directory_v2.value, "client_secret_certificate_thumbprint", null)
          client_secret_setting_name           = lookup(active_directory_v2.value, "client_secret_setting_name", null)
          jwt_allowed_client_applications      = lookup(active_directory_v2.value, "jwt_allowed_client_applications", null)
          jwt_allowed_groups                   = lookup(active_directory_v2.value, "jwt_allowed_groups", null)
          login_parameters                     = lookup(active_directory_v2.value, "login_parameters", null)
          www_authentication_disabled          = lookup(active_directory_v2.value, "www_authentication_disabled", false)
        }
      }
      dynamic "apple_v2" {
        for_each = try(local.auth_settings_v2.apple_v2[*], [])

        content {
          client_id                  = lookup(apple_v2.value, "client_id", null)
          client_secret_setting_name = lookup(apple_v2.value, "client_secret_setting_name", null)
        }
      }
      dynamic "azure_static_web_app_v2" {
        for_each = try(local.auth_settings_v2.azure_static_web_app_v2[*], [])

        content {
          client_id = lookup(azure_static_web_app_v2.value, "client_id", null)
        }
      }
      dynamic "custom_oidc_v2" {
        for_each = try(local.auth_settings_v2.custom_oidc_v2[*], [])

        content {
          client_id                     = lookup(custom_oidc_v2.value, "client_id", null)
          name                          = lookup(custom_oidc_v2.value, "name", null)
          openid_configuration_endpoint = lookup(custom_oidc_v2.value, "openid_configuration_endpoint", null)
          authorisation_endpoint        = lookup(custom_oidc_v2.value, "authorisation_endpoint", null)
          certification_uri             = lookup(custom_oidc_v2.value, "certification_uri", null)
          client_credential_method      = lookup(custom_oidc_v2.value, "client_credential_method", null)
          client_secret_setting_name    = lookup(custom_oidc_v2.value, "client_secret_setting_name", null)
          issuer_endpoint               = lookup(custom_oidc_v2.value, "issuer_endpoint", null)
          name_claim_type               = lookup(custom_oidc_v2.value, "name_claim_type", null)
          scopes                        = lookup(custom_oidc_v2.value, "scopes", null)
          token_endpoint                = lookup(custom_oidc_v2.value, "token_endpoint", null)
        }
      }
      dynamic "facebook_v2" {
        for_each = try(local.auth_settings_v2.facebook_v2[*], [])

        content {
          app_id                  = lookup(facebook_v2.value, "app_id", null)
          app_secret_setting_name = lookup(facebook_v2.value, "app_secret_setting_name", null)
          graph_api_version       = lookup(facebook_v2.value, "graph_api_version", null)
          login_scopes            = lookup(facebook_v2.value, "login_scopes", null)
        }
      }
      dynamic "github_v2" {
        for_each = try(local.auth_settings_v2.github_v2[*], [])

        content {
          client_id                  = lookup(github_v2.value, "client_id", null)
          client_secret_setting_name = lookup(github_v2.value, "client_secret_setting_name", null)
          login_scopes               = lookup(github_v2.value, "login_scopes", null)
        }
      }
      dynamic "google_v2" {
        for_each = try(local.auth_settings_v2.google_v2[*], [])

        content {
          client_id                  = lookup(google_v2.value, "client_id", null)
          client_secret_setting_name = lookup(google_v2.value, "client_secret_setting_name", null)
          allowed_audiences          = lookup(google_v2.value, "allowed_audiences", null)
          login_scopes               = lookup(google_v2.value, "login_scopes", null)
        }
      }
      dynamic "microsoft_v2" {
        for_each = try(local.auth_settings_v2.microsoft_v2[*], [])

        content {
          client_id                  = lookup(microsoft_v2.value, "client_id", null)
          client_secret_setting_name = lookup(microsoft_v2.value, "client_secret_setting_name", null)
          allowed_audiences          = lookup(microsoft_v2.value, "allowed_audiences", null)
          login_scopes               = lookup(microsoft_v2.value, "login_scopes", null)
        }
      }
      dynamic "twitter_v2" {
        for_each = try(local.auth_settings_v2.twitter_v2[*], [])

        content {
          consumer_key                 = lookup(twitter_v2.value, "consumer_key", null)
          consumer_secret_setting_name = lookup(twitter_v2.value, "consumer_secret_setting_name", null)
        }
      }
    }
  }
  dynamic "identity" {
    for_each = var.identity_type != null ? ["identity"] : []

    content {
      type = var.identity_type
      # Avoid perpetual changes if SystemAssigned and identity_ids is not null
      identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
    }
  }
  dynamic "sticky_settings" {
    for_each = var.sticky_settings[*]

    content {
      app_setting_names       = sticky_settings.value.app_setting_names
      connection_string_names = sticky_settings.value.connection_string_names
    }
  }

  depends_on = [azurerm_resource_group.rg, azurerm_service_plan.plan]

  lifecycle {
    ignore_changes = [
      app_settings.WEBSITE_RUN_FROM_ZIP,
      app_settings.WEBSITE_RUN_FROM_PACKAGE,
      app_settings.MACHINEKEY_DecryptionKey,
      app_settings.WEBSITE_CONTENTAZUREFILECONNECTIONSTRING,
      app_settings.WEBSITE_CONTENTSHARE,
    ]
  }
}

resource "azurerm_windows_function_app_slot" "windows_function_slot" {
  count = var.staging_slot_enabled ? 1 : 0

  function_app_id               = azurerm_windows_function_app.windows_function.id
  name                          = local.staging_slot_name
  app_settings                  = var.staging_slot_custom_application_settings == null ? local.function_app_application_settings : var.staging_slot_custom_application_settings
  builtin_logging_enabled       = var.builtin_logging_enabled
  functions_extension_version   = "~${var.function_app_version}"
  https_only                    = var.https_only
  storage_account_access_key    = var.storage_uses_managed_identity ? null : module.storage.azurerm_storage_account_resource.primary_access_key
  storage_account_name          = module.storage.azurerm_storage_account_name
  storage_uses_managed_identity = var.storage_uses_managed_identity ? true : null
  tags = merge(
    module.this.tags,
    {
      resourcegroup = data.azurerm_resource_group.func_rg.name
  })
  virtual_network_subnet_id = var.function_app_vnet_integration != null ? data.azurerm_subnet.vnet_subnet[0].id : null

  dynamic "site_config" {
    for_each = [local.site_config]

    content {
      always_on                              = lookup(site_config.value, "always_on", null)
      api_definition_url                     = lookup(site_config.value, "api_definition_url", null)
      api_management_api_id                  = lookup(site_config.value, "api_management_api_id", null)
      app_command_line                       = lookup(site_config.value, "app_command_line", null)
      app_scale_limit                        = lookup(site_config.value, "app_scale_limit", null)
      application_insights_connection_string = lookup(site_config.value, "application_insights_connection_string", null)
      application_insights_key               = lookup(site_config.value, "application_insights_key", false)
      default_documents                      = lookup(site_config.value, "default_documents", null)
      elastic_instance_minimum               = lookup(site_config.value, "elastic_instance_minimum", null)
      ftps_state                             = lookup(site_config.value, "ftps_state", "Disabled")
      health_check_eviction_time_in_min      = lookup(site_config.value, "health_check_eviction_time_in_min", null)
      health_check_path                      = lookup(site_config.value, "health_check_path", null)
      http2_enabled                          = lookup(site_config.value, "http2_enabled", null)
      ip_restriction_default_action          = var.ip_restriction_default_action
      load_balancing_mode                    = lookup(site_config.value, "load_balancing_mode", null)
      managed_pipeline_mode                  = lookup(site_config.value, "managed_pipeline_mode", null)
      minimum_tls_version                    = lookup(site_config.value, "minimum_tls_version", lookup(site_config.value, "min_tls_version", "1.2"))
      pre_warmed_instance_count              = lookup(site_config.value, "pre_warmed_instance_count", null)
      remote_debugging_enabled               = lookup(site_config.value, "remote_debugging_enabled", false)
      remote_debugging_version               = lookup(site_config.value, "remote_debugging_version", null)
      runtime_scale_monitoring_enabled       = lookup(site_config.value, "runtime_scale_monitoring_enabled", null)
      scm_type                               = lookup(site_config.value, "scm_type", null)
      scm_use_main_ip_restriction            = length(var.scm_authorized_ips) > 0 || var.scm_authorized_subnet_ids != null ? false : true
      use_32_bit_worker                      = lookup(site_config.value, "use_32_bit_worker", null)
      vnet_route_all_enabled                 = lookup(site_config.value, "vnet_route_all_enabled", var.function_app_vnet_integration != null)
      websockets_enabled                     = lookup(site_config.value, "websockets_enabled", false)
      worker_count                           = lookup(site_config.value, "worker_count", null)

      dynamic "app_service_logs" {
        for_each = lookup(site_config.value, "app_service_logs", null) != null ? ["app_service_logs"] : []

        content {
          disk_quota_mb         = lookup(site_config.value.app_service_logs, "disk_quota_mb", null)
          retention_period_days = lookup(site_config.value.app_service_logs, "retention_period_days", null)
        }
      }
      dynamic "application_stack" {
        for_each = lookup(site_config.value, "application_stack", null) == null ? [] : ["application_stack"]

        content {
          dotnet_version              = lookup(local.site_config.application_stack, "dotnet_version", null)
          java_version                = lookup(local.site_config.application_stack, "java_version", null)
          node_version                = lookup(local.site_config.application_stack, "node_version", null)
          powershell_core_version     = lookup(local.site_config.application_stack, "powershell_core_version", null)
          use_custom_runtime          = lookup(local.site_config.application_stack, "use_custom_runtime", null)
          use_dotnet_isolated_runtime = lookup(local.site_config.application_stack, "use_dotnet_isolated_runtime", null)
        }
      }
      dynamic "cors" {
        for_each = lookup(site_config.value, "cors", null) != null ? ["cors"] : []

        content {
          allowed_origins     = lookup(site_config.value.cors, "allowed_origins", [])
          support_credentials = lookup(site_config.value.cors, "support_credentials", false)
        }
      }
      dynamic "ip_restriction" {
        for_each = concat(local.subnets, local.cidrs, local.service_tags)

        content {
          action                    = ip_restriction.value.action
          headers                   = ip_restriction.value.headers
          ip_address                = ip_restriction.value.ip_address
          name                      = ip_restriction.value.name
          priority                  = ip_restriction.value.priority
          service_tag               = ip_restriction.value.service_tag
          virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id
        }
      }
      dynamic "scm_ip_restriction" {
        for_each = concat(local.scm_subnets, local.scm_cidrs, local.scm_service_tags)

        content {
          action                    = scm_ip_restriction.value.action
          headers                   = scm_ip_restriction.value.headers
          ip_address                = scm_ip_restriction.value.ip_address
          name                      = scm_ip_restriction.value.name
          priority                  = scm_ip_restriction.value.priority
          service_tag               = scm_ip_restriction.value.service_tag
          virtual_network_subnet_id = scm_ip_restriction.value.virtual_network_subnet_id
        }
      }
    }
  }
  dynamic "identity" {
    for_each = var.identity_type != null ? ["identity"] : []

    content {
      type         = var.identity_type
      identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
    }
  }

  lifecycle {
    ignore_changes = [
      app_settings.WEBSITE_RUN_FROM_ZIP,
      app_settings.WEBSITE_RUN_FROM_PACKAGE,
      app_settings.MACHINEKEY_DecryptionKey,
      app_settings.WEBSITE_CONTENTAZUREFILECONNECTIONSTRING,
      app_settings.WEBSITE_CONTENTSHARE,
    ]
  }
}

#######################
# Diagnostic Settings #
#######################

resource "azurerm_monitor_diagnostic_setting" "main" {
  count = var.diagnostic_setting.enabled ? 1 : 0

  name                           = module.naming.monitor_diagnostic_setting.name
  target_resource_id             = azurerm_windows_function_app.windows_function.id
  eventhub_authorization_rule_id = var.diagnostic_setting.eventhub_authorization_rule_id
  eventhub_name                  = var.diagnostic_setting.eventhub_name
  log_analytics_destination_type = var.diagnostic_setting.log_analytics_destination_type
  log_analytics_workspace_id     = try(data.azurerm_log_analytics_workspace.la_diag[0].id, null)
  storage_account_id             = try(data.azurerm_storage_account.la_st[0].id, null)

  enabled_log {
    category       = var.diagnostic_setting.logs.category
    category_group = var.diagnostic_setting.logs.category_group
  }
  metric {
    category = var.diagnostic_setting.metrics.category
    enabled  = var.diagnostic_setting.metrics.enabled
  }
}

resource "azurerm_monitor_diagnostic_setting" "slot" {
  count = var.diagnostic_setting.enabled && var.staging_slot_enabled ? 1 : 0

  name                           = "${module.naming.monitor_diagnostic_setting.name}-${azurerm_windows_function_app_slot.windows_function_slot[0].name}"
  target_resource_id             = azurerm_windows_function_app_slot.windows_function_slot[0].id
  eventhub_authorization_rule_id = var.diagnostic_setting.eventhub_authorization_rule_id
  eventhub_name                  = var.diagnostic_setting.eventhub_name
  log_analytics_destination_type = var.diagnostic_setting.log_analytics_destination_type
  log_analytics_workspace_id     = try(data.azurerm_log_analytics_workspace.la_diag[0].id, null)
  storage_account_id             = try(data.azurerm_storage_account.la_st[0].id, null)

  enabled_log {
    category       = var.diagnostic_setting.logs.category
    category_group = var.diagnostic_setting.logs.category_group
  }
  metric {
    category = var.diagnostic_setting.metrics.category
    enabled  = var.diagnostic_setting.metrics.enabled
  }
}
