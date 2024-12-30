variable "location" {
  type        = string
  description = <<DESCRIPTION
The location/region where the CosmosDB is created. Changing this forces a new resource to be created.
DESCRIPTION
}

variable "access_key_metadata_writes_enabled" {
  type        = bool
  default     = true
  description = "Is write operations on metadata resources (databases, containers, throughput) via account keys enabled?"
}

variable "allowed_cidrs" {
  type        = list(string)
  default     = []
  description = "CosmosDB Firewall Support: This value specifies the set of IP addresses or IP address ranges in CIDR form to be included as the allowed list of client IP's for a given database account."
}

variable "analytical_storage_enabled" {
  type        = bool
  default     = false
  description = "Enable Analytical Storage option for this Cosmos DB account. Defaults to `false`. Changing this forces a new resource to be created."
}

variable "analytical_storage_type" {
  type        = string
  default     = null
  description = "The schema type of the Analytical Storage for this Cosmos DB account. Possible values are `FullFidelity` and `WellDefined`."

  validation {
    condition     = try(contains(["FullFidelity", "WellDefined"], var.analytical_storage_type), true)
    error_message = "The `analytical_storage_type` value must be valid. Possible values are `FullFidelity` and `WellDefined`."
  }
}

variable "backup" {
  type = object({
    type                = optional(string, "Periodic")
    tier                = optional(string, null) # Possible values are Continuous7Days and Continuous30Days.
    interval_in_minutes = optional(number, 240)
    retention_in_hours  = optional(number, 8)
    storage_redundancy  = optional(string, "Geo")
  })
  default     = {}
  description = "Backup block with type (Continuous / Periodic), interval_in_minutes, retention_in_hours keys and storage_redundancy"
}

variable "capabilities" {
  type        = list(string)
  default     = []
  description = <<EOD
Configures the capabilities to enable for this Cosmos DB account:
Possible values are
  AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses,
  EnableAggregationPipeline, EnableCassandra, EnableGremlin,EnableMongo, EnableTable, EnableServerless,
  MongoDBv3.4 and mongoEnableDocLevelTTL.
EOD
}

variable "capacity_throughput_limit" {
  type        = string
  default     = null
  description = "The total throughput limit imposed on this Cosmos DB account (RU/s). Possible values are at least -1. -1 means no limit."
}

variable "consistency_policy_level" {
  type        = string
  default     = "BoundedStaleness"
  description = "Consistency policy level. Allowed values are `BoundedStaleness`, `Eventual`, `Session`, `Strong` or `ConsistentPrefix`"
}

variable "consistency_policy_max_interval_in_seconds" {
  type        = number
  default     = 10
  description = "When used with the Bounded Staleness consistency level, this value represents the time amount of staleness (in seconds) tolerated. Accepted range for this value is 5 - 86400 (1 day). Defaults to 5. Required when consistency_level is set to BoundedStaleness."
}

variable "consistency_policy_max_staleness_prefix" {
  type        = number
  default     = 200
  description = "When used with the Bounded Staleness consistency level, this value represents the number of stale requests tolerated. Accepted range for this value is 10 – 2147483647. Defaults to 100. Required when consistency_level is set to BoundedStaleness."
}

variable "cors_rules" {
  type = object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = optional(number)
  })
  default     = null
  description = "Cross-Origin Resource Sharing (CORS) is an HTTP feature that enables a web application running under one domain to access resources in another domain."
}

variable "cosmosdb_account_name" {
  type        = string
  default     = null
  description = "The Name of the CosmosDB Account"
}

variable "cosmosdb_sql_container" {
  type = list(object({
    name                   = optional(string, null)
    analytical_storage_ttl = optional(number, null)
    default_ttl            = optional(number, null)
    partition_key_kind     = optional(string, "Hash")
    partition_key_paths    = optional(list(string), ["/definition/id"])
    partition_key_version  = optional(number, 1)
    throughput             = optional(number, null)
    autoscale_settings = optional(object({
      max_throughput = number
    })),
    conflict_resolution_policy = optional(object({
      mode                          = string
      conflict_resolution_path      = string
      conflict_resolution_procedure = string
    })),
    indexing_policy = optional(object({
      indexing_mode = optional(string)
      included_path = optional(object({
        path = string
      }))
      excluded_path = optional(object({
        path = string
      }))
      composite_index = optional(object({
        index = optional(object({
          path  = string
          order = string
        }))
      }))
      spatial_index = optional(object({
        path = string
      }))
    }))
    unique_key = optional(object({
      paths = list(string)
    }))
  }))
  default = [
    {
      name = null
    }
  ]
  description = "Manages a SQL Container within a Cosmos DB Account."
}

variable "cosmosdb_sqldb_autoscale_settings" {
  type = object({
    max_throughput = string
  })
  default     = null
  description = "The maximum throughput of the Table (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply."
}

variable "cosmosdb_sqldb_throughput" {
  type        = number
  default     = null
  description = "The throughput of Table (RU/s). Must be set in increments of `100`. The minimum value is `400`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply."
}

variable "cosmosdb_table" {
  type = list(object({
    name = optional(string, null)
    autoscale_settings = optional(object({
      max_throughput = number
    }), null)
    throughput = optional(number, null)
  }))
  default = [
    {
      name = null
    }
  ]
  description = "Manages a Table within a Cosmos DB Account."
}

variable "create_cosmosdb_sql_container" {
  type        = bool
  default     = false
  description = "Manages a SQL Container within a Cosmos DB Account"
}

variable "create_cosmosdb_sql_database" {
  type        = bool
  default     = false
  description = "Manages a SQL Database within a Cosmos DB Account"
}

variable "create_cosmosdb_table" {
  type        = bool
  default     = false
  description = "Manages a Table within a Cosmos DB Account"
}

variable "create_mode" {
  type        = string
  default     = null
  description = "The creation mode for the CosmosDB Account. Possible values are Default and Restore. Changing this forces a new resource to be created."
}

variable "default_identity_type" {
  type        = string
  default     = "FirstPartyIdentity"
  description = "The default identity for accessing Key Vault. Possible values are FirstPartyIdentity, SystemAssignedIdentity or UserAssignedIdentity. Defaults to FirstPartyIdentity."
}

variable "diagnostic_setting" {
  type = object({
    enabled                        = optional(bool, false),
    storage_account_name           = optional(string, null)
    eventhub_name                  = optional(string, null),
    eventhub_authorization_rule_id = optional(string, null),
    log_analytics_workspace_name   = optional(string, null),
    log_analytics_destination_type = optional(string, "AzureDiagnostics"),
    metrics = optional(object({
      enabled  = optional(bool, true),
      category = optional(string, "AllMetrics")
    }), {}),
    logs = optional(object({
      category       = optional(string, null),
      category_group = optional(string, "AllLogs")
    }), {}),
  })
  default     = {}
  description = <<DESCRIPTION
  The values reuired for creating Diagnostic Setting to sends/store resource logs
  Defaults to `{}`.
  - `log_analytics_destination_type` - Deafults to `AzureDiagnostics`. The possible values are `Dedicated`, `AzureDiagnostics`.  When set to `Dedicated`, logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy `AzureDiagnostics` table.
  DESCRIPTION
}

variable "enable_advanced_threat_protection" {
  default     = false
  description = "Threat detection policy configuration, known in the API as Server Security Alerts Policy. Currently available only for the SQL API."
}

variable "enable_automatic_failover" {
  type        = bool
  default     = true
  description = "Enable automatic failover for this Cosmos DB account."
}

variable "free_tier_enabled" {
  type        = bool
  default     = false
  description = "Enable the option to opt-in for the free database account within subscription."
}

variable "geo_locations" {
  type = map(object({
    location          = string
    failover_priority = optional(number, 0)
    zone_redundant    = optional(bool, false)
  }))
  default     = null
  description = "The name of the Azure region to host replicated data and their priority."
}

variable "identity_ids" {
  type        = list(string)
  default     = []
  description = "Specifies a list of User Assigned Managed Identity IDs to be assigned to this Cosmos Account."
}

variable "identity_type" {
  type        = string
  default     = "SystemAssigned"
  description = "CosmosDB identity type. Possible values for type are: `null`, `SystemAssigned`, `UserAssigned` and `SystemAssigned, UserAssigned`."
}

variable "is_virtual_network_filter_enabled" {
  type        = bool
  default     = true
  description = "Enables virtual network filtering for this Cosmos DB account"
}

variable "key_vault_key_id" {
  default     = null
  description = "A versionless Key Vault Key ID for CMK encryption. Changing this forces a new resource to be created."
}

variable "kind" {
  type        = string
  default     = "GlobalDocumentDB"
  description = "Specifies the Kind of CosmosDB to create - possible values are `GlobalDocumentDB` and `MongoDB`."
}

variable "local_authentication_disabled" {
  type        = bool
  default     = true
  description = "Disable local authentication and ensure only MSI and AAD can be used exclusively for authentication. Can be set only when using the SQL API."
}

variable "minimal_tls_version" {
  type        = string
  default     = "Tls12"
  description = "pecifies the minimal TLS version for the CosmosDB account. Possible values are: Tls, Tls11, and Tls12"
}

variable "mongo_server_version" {
  type        = string
  default     = "4.2"
  description = "The Server Version of a MongoDB account. See possible values https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account#mongo_server_version"
}

variable "multiple_write_locations_enabled" {
  type        = bool
  default     = null
  description = "Enable multiple write locations for this Cosmos DB account"
}

variable "network_acl_bypass_for_azure_services" {
  type        = bool
  default     = false
  description = "If azure services can bypass ACLs."
}

variable "network_acl_bypass_ids" {
  type        = list(string)
  default     = null
  description = "The list of resource Ids for Network Acl Bypass for this Cosmos DB account."
}

variable "offer_type" {
  type        = string
  default     = "Standard"
  description = "Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to Standard."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = true
  description = "Whether or not public network access is allowed for this CosmosDB account."
}

variable "resource_group_name" {
  type        = string
  default     = null
  description = "Name of the resource group to which resource to be created"
}

variable "role_assignment" {
  type        = map(list(string))
  default     = {}
  description = "The Key and Value Pair of role_defination_name and principal id to allow the users to access Frontdoor"
}

variable "suffix" {
  type        = string
  default     = null
  description = "Suffix for naming module"
}

variable "virtual_network_rule" {
  type = list(object({
    subnet_name                          = string
    vnet_name                            = string
    ignore_missing_vnet_service_endpoint = optional(bool, false)
  }))
  default     = []
  description = "Specifies a virtual_network_rules resource used to define which subnets are allowed to access this CosmosDB account"
}
