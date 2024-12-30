# cosmos

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

<!-- BEGIN-TERRAFORM-DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.63.0, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.63.0, < 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cosmosdb_naming"></a> [cosmosdb\_naming](#module\_cosmosdb\_naming) | Azure/naming/azurerm | 0.4.2 |
| <a name="module_diagnostic_setting_naming"></a> [diagnostic\_setting\_naming](#module\_diagnostic\_setting\_naming) | Azure/naming/azurerm | 0.4.2 |
| <a name="module_inputs"></a> [inputs](#module\_inputs) | ../outputs | n/a |
| <a name="module_naming"></a> [naming](#module\_naming) | Azure/naming/azurerm | 0.4.2 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |
| <a name="module_vnet_naming"></a> [vnet\_naming](#module\_vnet\_naming) | Azure/naming/azurerm | 0.4.2 |

## Resources

| Name | Type |
|------|------|
| [azurerm_advanced_threat_protection.defender](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/advanced_threat_protection) | resource |
| [azurerm_cosmosdb_account.cs_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account) | resource |
| [azurerm_cosmosdb_sql_container.sql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_container) | resource |
| [azurerm_cosmosdb_sql_database.sql_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_database) | resource |
| [azurerm_cosmosdb_table.ct](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_table) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_resource_group.cs_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.rbac](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuread_group.principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_cosmosdb_account.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_log_analytics_workspace.la_diag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_resource_group.cs_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.la_st](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key_metadata_writes_enabled"></a> [access\_key\_metadata\_writes\_enabled](#input\_access\_key\_metadata\_writes\_enabled) | Is write operations on metadata resources (databases, containers, throughput) via account keys enabled? | `bool` | `true` | no |
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | CosmosDB Firewall Support: This value specifies the set of IP addresses or IP address ranges in CIDR form to be included as the allowed list of client IP's for a given database account. | `list(string)` | `[]` | no |
| <a name="input_analytical_storage_enabled"></a> [analytical\_storage\_enabled](#input\_analytical\_storage\_enabled) | Enable Analytical Storage option for this Cosmos DB account. Defaults to `false`. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_analytical_storage_type"></a> [analytical\_storage\_type](#input\_analytical\_storage\_type) | The schema type of the Analytical Storage for this Cosmos DB account. Possible values are `FullFidelity` and `WellDefined`. | `string` | `null` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_backup"></a> [backup](#input\_backup) | Backup block with type (Continuous / Periodic), interval\_in\_minutes, retention\_in\_hours keys and storage\_redundancy | <pre>object({<br>    type                = optional(string, "Periodic")<br>    tier                = optional(string, null) # Possible values are Continuous7Days and Continuous30Days.<br>    interval_in_minutes = optional(number, 240)<br>    retention_in_hours  = optional(number, 8)<br>    storage_redundancy  = optional(string, "Geo")<br>  })</pre> | `{}` | no |
| <a name="input_capabilities"></a> [capabilities](#input\_capabilities) | Configures the capabilities to enable for this Cosmos DB account:<br>Possible values are<br>  AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses,<br>  EnableAggregationPipeline, EnableCassandra, EnableGremlin,EnableMongo, EnableTable, EnableServerless,<br>  MongoDBv3.4 and mongoEnableDocLevelTTL. | `list(string)` | `[]` | no |
| <a name="input_capacity_throughput_limit"></a> [capacity\_throughput\_limit](#input\_capacity\_throughput\_limit) | The total throughput limit imposed on this Cosmos DB account (RU/s). Possible values are at least -1. -1 means no limit. | `string` | `null` | no |
| <a name="input_consistency_policy_level"></a> [consistency\_policy\_level](#input\_consistency\_policy\_level) | Consistency policy level. Allowed values are `BoundedStaleness`, `Eventual`, `Session`, `Strong` or `ConsistentPrefix` | `string` | `"BoundedStaleness"` | no |
| <a name="input_consistency_policy_max_interval_in_seconds"></a> [consistency\_policy\_max\_interval\_in\_seconds](#input\_consistency\_policy\_max\_interval\_in\_seconds) | When used with the Bounded Staleness consistency level, this value represents the time amount of staleness (in seconds) tolerated. Accepted range for this value is 5 - 86400 (1 day). Defaults to 5. Required when consistency\_level is set to BoundedStaleness. | `number` | `10` | no |
| <a name="input_consistency_policy_max_staleness_prefix"></a> [consistency\_policy\_max\_staleness\_prefix](#input\_consistency\_policy\_max\_staleness\_prefix) | When used with the Bounded Staleness consistency level, this value represents the number of stale requests tolerated. Accepted range for this value is 10 – 2147483647. Defaults to 100. Required when consistency\_level is set to BoundedStaleness. | `number` | `200` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_cors_rules"></a> [cors\_rules](#input\_cors\_rules) | Cross-Origin Resource Sharing (CORS) is an HTTP feature that enables a web application running under one domain to access resources in another domain. | <pre>object({<br>    allowed_headers    = list(string)<br>    allowed_methods    = list(string)<br>    allowed_origins    = list(string)<br>    exposed_headers    = list(string)<br>    max_age_in_seconds = optional(number)<br>  })</pre> | `null` | no |
| <a name="input_cosmosdb_account_name"></a> [cosmosdb\_account\_name](#input\_cosmosdb\_account\_name) | The Name of the CosmosDB Account | `string` | `null` | no |
| <a name="input_cosmosdb_sql_container"></a> [cosmosdb\_sql\_container](#input\_cosmosdb\_sql\_container) | Manages a SQL Container within a Cosmos DB Account. | <pre>list(object({<br>    name                   = optional(string, null)<br>    analytical_storage_ttl = optional(number, null)<br>    default_ttl            = optional(number, null)<br>    partition_key_kind     = optional(string, "Hash")<br>    partition_key_paths    = optional(list(string), ["/definition/id"])<br>    partition_key_version  = optional(number, 1)<br>    throughput             = optional(number, null)<br>    autoscale_settings = optional(object({<br>      max_throughput = number<br>    })),<br>    conflict_resolution_policy = optional(object({<br>      mode                          = string<br>      conflict_resolution_path      = string<br>      conflict_resolution_procedure = string<br>    })),<br>    indexing_policy = optional(object({<br>      indexing_mode = optional(string)<br>      included_path = optional(object({<br>        path = string<br>      }))<br>      excluded_path = optional(object({<br>        path = string<br>      }))<br>      composite_index = optional(object({<br>        index = optional(object({<br>          path  = string<br>          order = string<br>        }))<br>      }))<br>      spatial_index = optional(object({<br>        path = string<br>      }))<br>    }))<br>    unique_key = optional(object({<br>      paths = list(string)<br>    }))<br>  }))</pre> | <pre>[<br>  {<br>    "name": null<br>  }<br>]</pre> | no |
| <a name="input_cosmosdb_sqldb_autoscale_settings"></a> [cosmosdb\_sqldb\_autoscale\_settings](#input\_cosmosdb\_sqldb\_autoscale\_settings) | The maximum throughput of the Table (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply. | <pre>object({<br>    max_throughput = string<br>  })</pre> | `null` | no |
| <a name="input_cosmosdb_sqldb_throughput"></a> [cosmosdb\_sqldb\_throughput](#input\_cosmosdb\_sqldb\_throughput) | The throughput of Table (RU/s). Must be set in increments of `100`. The minimum value is `400`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply. | `number` | `null` | no |
| <a name="input_cosmosdb_table"></a> [cosmosdb\_table](#input\_cosmosdb\_table) | Manages a Table within a Cosmos DB Account. | <pre>list(object({<br>    name = optional(string, null)<br>    autoscale_settings = optional(object({<br>      max_throughput = number<br>    }), null)<br>    throughput = optional(number, null)<br>  }))</pre> | <pre>[<br>  {<br>    "name": null<br>  }<br>]</pre> | no |
| <a name="input_create_cosmosdb_sql_container"></a> [create\_cosmosdb\_sql\_container](#input\_create\_cosmosdb\_sql\_container) | Manages a SQL Container within a Cosmos DB Account | `bool` | `false` | no |
| <a name="input_create_cosmosdb_sql_database"></a> [create\_cosmosdb\_sql\_database](#input\_create\_cosmosdb\_sql\_database) | Manages a SQL Database within a Cosmos DB Account | `bool` | `false` | no |
| <a name="input_create_cosmosdb_table"></a> [create\_cosmosdb\_table](#input\_create\_cosmosdb\_table) | Manages a Table within a Cosmos DB Account | `bool` | `false` | no |
| <a name="input_create_mode"></a> [create\_mode](#input\_create\_mode) | The creation mode for the CosmosDB Account. Possible values are Default and Restore. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_default_identity_type"></a> [default\_identity\_type](#input\_default\_identity\_type) | The default identity for accessing Key Vault. Possible values are FirstPartyIdentity, SystemAssignedIdentity or UserAssignedIdentity. Defaults to FirstPartyIdentity. | `string` | `"FirstPartyIdentity"` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_diagnostic_setting"></a> [diagnostic\_setting](#input\_diagnostic\_setting) | The values reuired for creating Diagnostic Setting to sends/store resource logs<br>  Defaults to `{}`.<br>  - `log_analytics_destination_type` - Deafults to `AzureDiagnostics`. The possible values are `Dedicated`, `AzureDiagnostics`.  When set to `Dedicated`, logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy `AzureDiagnostics` table. | <pre>object({<br>    enabled                        = optional(bool, false),<br>    storage_account_name           = optional(string, null)<br>    eventhub_name                  = optional(string, null),<br>    eventhub_authorization_rule_id = optional(string, null),<br>    log_analytics_workspace_name   = optional(string, null),<br>    log_analytics_destination_type = optional(string, "AzureDiagnostics"),<br>    metrics = optional(object({<br>      enabled  = optional(bool, true),<br>      category = optional(string, "AllMetrics")<br>    }), {}),<br>    logs = optional(object({<br>      category       = optional(string, null),<br>      category_group = optional(string, "AllLogs")<br>    }), {}),<br>  })</pre> | `{}` | no |
| <a name="input_enable_advanced_threat_protection"></a> [enable\_advanced\_threat\_protection](#input\_enable\_advanced\_threat\_protection) | Threat detection policy configuration, known in the API as Server Security Alerts Policy. Currently available only for the SQL API. | `bool` | `false` | no |
| <a name="input_enable_automatic_failover"></a> [enable\_automatic\_failover](#input\_enable\_automatic\_failover) | Enable automatic failover for this Cosmos DB account. | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_free_tier_enabled"></a> [free\_tier\_enabled](#input\_free\_tier\_enabled) | Enable the option to opt-in for the free database account within subscription. | `bool` | `false` | no |
| <a name="input_geo_locations"></a> [geo\_locations](#input\_geo\_locations) | The name of the Azure region to host replicated data and their priority. | <pre>map(object({<br>    location          = string<br>    failover_priority = optional(number, 0)<br>    zone_redundant    = optional(bool, false)<br>  }))</pre> | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Specifies a list of User Assigned Managed Identity IDs to be assigned to this Cosmos Account. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | CosmosDB identity type. Possible values for type are: `null`, `SystemAssigned`, `UserAssigned` and `SystemAssigned, UserAssigned`. | `string` | `"SystemAssigned"` | no |
| <a name="input_is_virtual_network_filter_enabled"></a> [is\_virtual\_network\_filter\_enabled](#input\_is\_virtual\_network\_filter\_enabled) | Enables virtual network filtering for this Cosmos DB account | `bool` | `true` | no |
| <a name="input_key_vault_key_id"></a> [key\_vault\_key\_id](#input\_key\_vault\_key\_id) | A versionless Key Vault Key ID for CMK encryption. Changing this forces a new resource to be created. | `any` | `null` | no |
| <a name="input_kind"></a> [kind](#input\_kind) | Specifies the Kind of CosmosDB to create - possible values are `GlobalDocumentDB` and `MongoDB`. | `string` | `"GlobalDocumentDB"` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_local_authentication_disabled"></a> [local\_authentication\_disabled](#input\_local\_authentication\_disabled) | Disable local authentication and ensure only MSI and AAD can be used exclusively for authentication. Can be set only when using the SQL API. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the CosmosDB is created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_minimal_tls_version"></a> [minimal\_tls\_version](#input\_minimal\_tls\_version) | pecifies the minimal TLS version for the CosmosDB account. Possible values are: Tls, Tls11, and Tls12 | `string` | `"Tls12"` | no |
| <a name="input_mongo_server_version"></a> [mongo\_server\_version](#input\_mongo\_server\_version) | The Server Version of a MongoDB account. See possible values https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account#mongo_server_version | `string` | `"4.2"` | no |
| <a name="input_multiple_write_locations_enabled"></a> [multiple\_write\_locations\_enabled](#input\_multiple\_write\_locations\_enabled) | Enable multiple write locations for this Cosmos DB account | `bool` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_network_acl_bypass_for_azure_services"></a> [network\_acl\_bypass\_for\_azure\_services](#input\_network\_acl\_bypass\_for\_azure\_services) | If azure services can bypass ACLs. | `bool` | `false` | no |
| <a name="input_network_acl_bypass_ids"></a> [network\_acl\_bypass\_ids](#input\_network\_acl\_bypass\_ids) | The list of resource Ids for Network Acl Bypass for this Cosmos DB account. | `list(string)` | `null` | no |
| <a name="input_offer_type"></a> [offer\_type](#input\_offer\_type) | Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to Standard. | `string` | `"Standard"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this CosmosDB account. | `bool` | `true` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group to which resource to be created | `string` | `null` | no |
| <a name="input_role_assignment"></a> [role\_assignment](#input\_role\_assignment) | The Key and Value Pair of role\_defination\_name and principal id to allow the users to access Frontdoor | `map(list(string))` | `{}` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Suffix for naming module | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_virtual_network_rule"></a> [virtual\_network\_rule](#input\_virtual\_network\_rule) | Specifies a virtual\_network\_rules resource used to define which subnets are allowed to access this CosmosDB account | <pre>list(object({<br>    subnet_name                          = string<br>    vnet_name                            = string<br>    ignore_missing_vnet_service_endpoint = optional(bool, false)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_names"></a> [container\_names](#output\_container\_names) | Names of the CosmosDB SQL containers |
| <a name="output_cosmosdb_account_name"></a> [cosmosdb\_account\_name](#output\_cosmosdb\_account\_name) | The account name of CosmosDB |
| <a name="output_cosmosdb_rg_name"></a> [cosmosdb\_rg\_name](#output\_cosmosdb\_rg\_name) | The CosmosDB resource group name |
| <a name="output_cosmosdb_sql_db_name"></a> [cosmosdb\_sql\_db\_name](#output\_cosmosdb\_sql\_db\_name) | The name of cosmos sql database |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The endpoint used to connect to the CosmosDB account. |
| <a name="output_id"></a> [id](#output\_id) | The CosmosDB Account ID. |
| <a name="output_primary_key"></a> [primary\_key](#output\_primary\_key) | The Primary key for the CosmosDB Account |
| <a name="output_primary_sql_connection_string"></a> [primary\_sql\_connection\_string](#output\_primary\_sql\_connection\_string) | Primary SQL connection string for the CosmosDB Account. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal ID associated with this Managed Service Identity. |
| <a name="output_secondary_key"></a> [secondary\_key](#output\_secondary\_key) | The Secondary key for the CosmosDB Account |
| <a name="output_secondary_sql_connection_string"></a> [secondary\_sql\_connection\_string](#output\_secondary\_sql\_connection\_string) | Secondary SQL connection string for the CosmosDB Account. |
| <a name="output_table_names"></a> [table\_names](#output\_table\_names) | Names of the CosmosDB Tables |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The Tenant ID associated with this Managed Service Identity. |
<!-- END-TERRAFORM-DOCS -->