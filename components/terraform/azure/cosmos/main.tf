##################
# Resource Group #
##################

resource "azurerm_resource_group" "cs_rg" {
  count = local.create_cosmosdb_account && var.resource_group_name == null ? 1 : 0

  location = var.location
  name     = module.naming.resource_group.name
  tags = merge(
    module.this.tags,
    {
      Component    = "cosmosdb"
      ExpenseClass = "database"
    }
  )
}

##########
# Cosmos #
##########

resource "azurerm_cosmosdb_account" "cs_db" {
  count = local.create_cosmosdb_account ? 1 : 0

  location                              = var.location
  name                                  = module.naming.cosmosdb_account.name
  offer_type                            = var.offer_type
  resource_group_name                   = data.azurerm_resource_group.cs_rg.name
  access_key_metadata_writes_enabled    = var.access_key_metadata_writes_enabled
  analytical_storage_enabled            = var.analytical_storage_enabled
  automatic_failover_enabled            = var.enable_automatic_failover
  create_mode                           = var.create_mode
  default_identity_type                 = var.default_identity_type
  free_tier_enabled                     = var.free_tier_enabled
  ip_range_filter                       = join(",", var.allowed_cidrs)
  is_virtual_network_filter_enabled     = var.is_virtual_network_filter_enabled
  key_vault_key_id                      = try(var.key_vault_key_id, null)
  kind                                  = var.kind
  local_authentication_disabled         = var.local_authentication_disabled
  minimal_tls_version                   = var.minimal_tls_version
  mongo_server_version                  = var.kind == "MongoDB" ? var.mongo_server_version : null
  multiple_write_locations_enabled      = var.multiple_write_locations_enabled
  network_acl_bypass_for_azure_services = var.network_acl_bypass_for_azure_services
  network_acl_bypass_ids                = var.network_acl_bypass_ids
  public_network_access_enabled         = var.public_network_access_enabled
  tags = merge(
    module.this.tags,
    {
      ResourceGroup = data.azurerm_resource_group.cs_rg.name
    }
  )

  consistency_policy {
    consistency_level       = var.consistency_policy_level
    max_interval_in_seconds = var.consistency_policy_max_interval_in_seconds
    max_staleness_prefix    = var.consistency_policy_max_staleness_prefix
  }
  dynamic "geo_location" {
    for_each = var.geo_locations != null ? var.geo_locations : local.default_failover_locations

    content {
      failover_priority = geo_location.value.failover_priority
      location          = geo_location.value.location
      zone_redundant    = geo_location.value.zone_redundant
    }
  }
  dynamic "analytical_storage" {
    for_each = var.analytical_storage_type != null ? ["enabled"] : []

    content {
      schema_type = var.analytical_storage_type
    }
  }
  dynamic "backup" {
    for_each = var.backup != null ? ["enabled"] : []

    content {
      type                = var.backup.type
      interval_in_minutes = var.backup.interval_in_minutes
      retention_in_hours  = var.backup.retention_in_hours
      storage_redundancy  = var.backup.storage_redundancy
      tier                = var.backup.type == "Continuous" ? var.backup.tier : null
    }
  }
  dynamic "capabilities" {
    for_each = toset(var.capabilities)

    content {
      name = capabilities.key
    }
  }
  dynamic "capacity" {
    for_each = var.capacity_throughput_limit != null ? ["enabled"] : []

    content {
      total_throughput_limit = var.capacity_throughput_limit
    }
  }
  dynamic "cors_rule" {
    for_each = var.cors_rules != null ? ["enabled"] : []

    content {
      allowed_headers    = var.cors_rules.allowed_headers
      allowed_methods    = var.cors_rules.allowed_methods
      allowed_origins    = var.cors_rules.allowed_origins
      exposed_headers    = var.cors_rules.exposed_headers
      max_age_in_seconds = var.cors_rules.max_age_in_seconds
    }
  }
  dynamic "identity" {
    for_each = var.identity_type != null ? ["enabled"] : []

    content {
      type         = var.identity_type
      identity_ids = var.identity_type == "UserAssigned" || var.identity_type == "SystemAssigned, UserAssigned" ? var.identity_ids : []
    }
  }
  timeouts {
    create = "2h"
    delete = "2h"
    update = "2h"
  }
  dynamic "virtual_network_rule" {
    for_each = local.virtual_network_rule

    content {
      id                                   = virtual_network_rule.value.id
      ignore_missing_vnet_service_endpoint = virtual_network_rule.value.ignore_missing_vnet_service_endpoint
    }
  }
}

##########################################
#  CosmosDB azure defender configuration #
##########################################
resource "azurerm_advanced_threat_protection" "defender" {
  count = local.create_cosmosdb_account && var.enable_advanced_threat_protection ? 1 : 0

  enabled            = var.enable_advanced_threat_protection
  target_resource_id = azurerm_cosmosdb_account.cs_db[0].id
}

###################
#  CosmosDB Table #
###################
resource "azurerm_cosmosdb_table" "ct" {
  for_each = var.create_cosmosdb_table ? { for table, _ in var.cosmosdb_table : table => _ } : {}

  account_name        = local.create_cosmosdb_account ? azurerm_cosmosdb_account.cs_db[0].name : module.cosmosdb_naming[0].cosmosdb_account.name
  name                = each.value.name != null ? each.value.name : "${module.naming.cosmosdb_account.name}-table"
  resource_group_name = data.azurerm_resource_group.cs_rg.name
  throughput          = each.value.autoscale_settings == null ? each.value.throughput : null

  dynamic "autoscale_settings" {
    for_each = each.value.autoscale_settings != null ? ["Enabled"] : []

    content {
      max_throughput = each.value.throughput == null ? each.value.autoscale_settings.max_throughput : null
    }
  }
  timeouts {
    create = "2h"
    delete = "2h"
    update = "2h"
  }
}

##########################
#  CosmosDB SQL Database #
##########################
resource "azurerm_cosmosdb_sql_database" "sql_db" {
  count = var.create_cosmosdb_sql_database || var.create_cosmosdb_sql_container ? 1 : 0

  account_name        = local.create_cosmosdb_account ? azurerm_cosmosdb_account.cs_db[0].name : module.cosmosdb_naming[0].cosmosdb_account.name
  name                = "${module.naming.cosmosdb_account.name}-sql-db"
  resource_group_name = data.azurerm_resource_group.cs_rg.name
  throughput          = var.cosmosdb_sqldb_autoscale_settings == null ? var.cosmosdb_sqldb_throughput : null

  dynamic "autoscale_settings" {
    for_each = var.cosmosdb_sqldb_autoscale_settings != null ? ["Enabled"] : []

    content {
      max_throughput = var.cosmosdb_sqldb_throughput == null ? var.cosmosdb_sqldb_autoscale_settings.max_throughput : null
    }
  }
  timeouts {
    create = "2h"
    delete = "2h"
    update = "2h"
  }
}

###########################
#  CosmosDB SQL Container #
###########################
resource "azurerm_cosmosdb_sql_container" "sql" {
  for_each = var.create_cosmosdb_sql_container ? { for container, _ in var.cosmosdb_sql_container : container => _ } : {}

  account_name           = local.create_cosmosdb_account ? azurerm_cosmosdb_account.cs_db[0].name : module.cosmosdb_naming[0].cosmosdb_account.name
  database_name          = azurerm_cosmosdb_sql_database.sql_db[0].name
  name                   = each.value.name != null ? each.value.name : "${module.naming.cosmosdb_account.name}-sql-container"
  resource_group_name    = data.azurerm_resource_group.cs_rg.name
  analytical_storage_ttl = each.value.analytical_storage_ttl
  default_ttl            = each.value.default_ttl
  partition_key_kind     = each.value.partition_key_kind
  partition_key_paths    = each.value.partition_key_paths
  partition_key_version  = each.value.partition_key_version
  throughput             = each.value.autoscale_settings == null ? each.value.throughput : null

  dynamic "autoscale_settings" {
    for_each = each.value.autoscale_settings != null ? ["Enabled"] : []

    content {
      max_throughput = each.value.throughput == null ? each.value.autoscale_settings.max_throughput : null
    }
  }
  dynamic "conflict_resolution_policy" {
    for_each = each.value.conflict_resolution_policy != null ? ["Enabled"] : []

    content {
      mode                          = each.value.conflict_resolution_policy.mode
      conflict_resolution_path      = each.value.conflict_resolution_policy.conflict_resolution_path
      conflict_resolution_procedure = each.value.conflict_resolution_policy.conflict_resolution_procedure
    }
  }
  dynamic "indexing_policy" {
    for_each = each.value.indexing_policy != null ? ["Enabled"] : []

    content {
      indexing_mode = each.value.indexing_policy.indexing_mode

      dynamic "composite_index" {
        for_each = lookup(each.value.indexing_policy, "composite_index") != null ? ["Enabled"] : []

        content {
          index {
            order = each.value.indexing_policy.composite_index.index.order
            path  = each.value.indexing_policy.composite_index.index.path
          }
        }
      }
      dynamic "excluded_path" {
        for_each = lookup(each.value.indexing_policy, "excluded_path") != null ? ["Enabled"] : []

        content {
          path = each.value.indexing_policy.excluded_path.path
        }
      }
      dynamic "included_path" {
        for_each = lookup(each.value.indexing_policy, "included_path") != null ? ["Enabled"] : []

        content {
          path = each.value.indexing_policy.included_path.path
        }
      }
      dynamic "spatial_index" {
        for_each = lookup(each.value.indexing_policy, "spatial_index") != null ? ["Enabled"] : []

        content {
          path = each.value.indexing_policy.spatial_index.path
        }
      }
    }
  }
  timeouts {
    create = "2h"
    delete = "2h"
    update = "2h"
  }
  dynamic "unique_key" {
    for_each = each.value.unique_key != null ? ["Enabled"] : []

    content {
      paths = each.value.unique_key.paths
    }
  }
}
