# functionappwindows

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
| <a name="module_apim_naming"></a> [apim\_naming](#module\_apim\_naming) | Azure/naming/azurerm | 0.4.2 |
| <a name="module_appinsights_naming"></a> [appinsights\_naming](#module\_appinsights\_naming) | Azure/naming/azurerm | 0.4.2 |
| <a name="module_cosmosdb_account_naming"></a> [cosmosdb\_account\_naming](#module\_cosmosdb\_account\_naming) | Azure/naming/azurerm | 0.4.2 |
| <a name="module_diagnostic_setting_naming"></a> [diagnostic\_setting\_naming](#module\_diagnostic\_setting\_naming) | Azure/naming/azurerm | 0.4.2 |
| <a name="module_naming"></a> [naming](#module\_naming) | Azure/naming/azurerm | 0.4.2 |
| <a name="module_storage"></a> [storage](#module\_storage) | ../storage | n/a |
| <a name="module_subnet_naming"></a> [subnet\_naming](#module\_subnet\_naming) | Azure/naming/azurerm | 0.4.2 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |
| <a name="module_vnet_naming"></a> [vnet\_naming](#module\_vnet\_naming) | Azure/naming/azurerm | 0.4.2 |
| <a name="module_windows_naming"></a> [windows\_naming](#module\_windows\_naming) | Azure/naming/azurerm | 0.4.2 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_backend.backend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_backend) | resource |
| [azurerm_monitor_diagnostic_setting.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.slot](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.rbac](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_service_plan.plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_windows_function_app.windows_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app) | resource |
| [azurerm_windows_function_app_slot.windows_function_slot](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app_slot) | resource |
| [azuread_group.principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_application_insights.appinsights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_cosmosdb_account.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cosmosdb_account) | data source |
| [azurerm_function_app_host_keys.host_keys](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/function_app_host_keys) | data source |
| [azurerm_log_analytics_workspace.la_diag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_resource_group.func_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_service_plan.app_service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/service_plan) | data source |
| [azurerm_storage_account.la_st](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.authorized_subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.vnet_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_api_management_backends"></a> [api\_management\_backends](#input\_api\_management\_backends) | n/a | <pre>list(object({<br>    apim_name    = string,<br>    backend_name = optional(string, null)<br>    backend_path = string<br>  }))</pre> | `[]` | no |
| <a name="input_app_service_environment_id"></a> [app\_service\_environment\_id](#input\_app\_service\_environment\_id) | ID of the App Service Environment to create this Service Plan in. Requires an Isolated SKU. Use one of I1, I2, I3 for azurerm\_app\_service\_environment, or I1v2, I2v2, I3v2 for azurerm\_app\_service\_environment\_v3. | `string` | `null` | no |
| <a name="input_app_service_plan_name"></a> [app\_service\_plan\_name](#input\_app\_service\_plan\_name) | The name of the app service plan that function apps will be created within.<br>If no app service plan name is specified, the component will create a new one. | `string` | `null` | no |
| <a name="input_application_insights_daily_data_cap"></a> [application\_insights\_daily\_data\_cap](#input\_application\_insights\_daily\_data\_cap) | Daily data volume cap (in GB) for Application Insights. | `number` | `null` | no |
| <a name="input_application_insights_daily_data_cap_notifications_disabled"></a> [application\_insights\_daily\_data\_cap\_notifications\_disabled](#input\_application\_insights\_daily\_data\_cap\_notifications\_disabled) | Whether disable email notifications when data volume cap is met. | `bool` | `null` | no |
| <a name="input_application_insights_enabled"></a> [application\_insights\_enabled](#input\_application\_insights\_enabled) | Whether Application Insights should be deployed. | `bool` | `true` | no |
| <a name="input_application_insights_force_customer_storage_for_profiler"></a> [application\_insights\_force\_customer\_storage\_for\_profiler](#input\_application\_insights\_force\_customer\_storage\_for\_profiler) | Whether to enforce users to create their own Storage Account for profiling in Application Insights. | `bool` | `false` | no |
| <a name="input_application_insights_id"></a> [application\_insights\_id](#input\_application\_insights\_id) | ID of the existing Application Insights to use instead of deploying a new one. | `string` | `null` | no |
| <a name="input_application_insights_internet_ingestion_enabled"></a> [application\_insights\_internet\_ingestion\_enabled](#input\_application\_insights\_internet\_ingestion\_enabled) | Whether ingestion support from Application Insights component over the Public Internet is enabled. | `bool` | `true` | no |
| <a name="input_application_insights_internet_query_enabled"></a> [application\_insights\_internet\_query\_enabled](#input\_application\_insights\_internet\_query\_enabled) | Whether querying support from Application Insights component over the Public Internet is enabled. | `bool` | `true` | no |
| <a name="input_application_insights_ip_masking_disabled"></a> [application\_insights\_ip\_masking\_disabled](#input\_application\_insights\_ip\_masking\_disabled) | Whether IP masking in logs is disabled. | `bool` | `false` | no |
| <a name="input_application_insights_local_authentication_disabled"></a> [application\_insights\_local\_authentication\_disabled](#input\_application\_insights\_local\_authentication\_disabled) | Whether Non-Azure AD based authentication is disabled. | `bool` | `false` | no |
| <a name="input_application_insights_log_analytics_workspace_id"></a> [application\_insights\_log\_analytics\_workspace\_id](#input\_application\_insights\_log\_analytics\_workspace\_id) | ID of the Log Analytics Workspace to be used with Application Insights. | `string` | `null` | no |
| <a name="input_application_insights_retention"></a> [application\_insights\_retention](#input\_application\_insights\_retention) | Retention period (in days) for logs. | `number` | `90` | no |
| <a name="input_application_insights_sampling_percentage"></a> [application\_insights\_sampling\_percentage](#input\_application\_insights\_sampling\_percentage) | Percentage of data produced by the monitored application sampled for Application Insights telemetry. | `number` | `null` | no |
| <a name="input_application_insights_type"></a> [application\_insights\_type](#input\_application\_insights\_type) | Application Insights type if need to be generated. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights#application_type | `string` | `"web"` | no |
| <a name="input_application_zip_package_path"></a> [application\_zip\_package\_path](#input\_application\_zip\_package\_path) | Local or remote path of a zip package to deploy on the Function App. | `string` | `null` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_auth_settings_v2"></a> [auth\_settings\_v2](#input\_auth\_settings\_v2) | Authentication settings V2. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app#auth_settings_v2 | `any` | `{}` | no |
| <a name="input_authorized_ips"></a> [authorized\_ips](#input\_authorized\_ips) | IPs restriction for Function in CIDR format. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#ip_restriction | `list(string)` | `[]` | no |
| <a name="input_authorized_service_tags"></a> [authorized\_service\_tags](#input\_authorized\_service\_tags) | Service Tags restriction for Function App. See documentation https://www.terraform.io/docs/providers/azurerm/r/function_app.html#ip_restriction | `list(string)` | `[]` | no |
| <a name="input_authorized_subnets"></a> [authorized\_subnets](#input\_authorized\_subnets) | Subnets restriction for Function App. See documentation https://www.terraform.io/docs/providers/azurerm/r/function_app.html#ip_restriction | <pre>list(object({<br>    subnet_name = string,<br>    vnet_name   = string<br>  }))</pre> | `[]` | no |
| <a name="input_builtin_logging_enabled"></a> [builtin\_logging\_enabled](#input\_builtin\_logging\_enabled) | Whether built-in logging is enabled. | `bool` | `true` | no |
| <a name="input_client_certificate_enabled"></a> [client\_certificate\_enabled](#input\_client\_certificate\_enabled) | Whether the Function App uses client certificates. | `bool` | `null` | no |
| <a name="input_client_certificate_mode"></a> [client\_certificate\_mode](#input\_client\_certificate\_mode) | The mode of the Function App's client certificates requirement for incoming requests. Possible values are `Required`, `Optional`, and `OptionalInteractiveUser`. | `string` | `null` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_cosmos_role_definition"></a> [cosmos\_role\_definition](#input\_cosmos\_role\_definition) | The Built in or Custom role definition name for cosmos | `list(string)` | `[]` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_diagnostic_setting"></a> [diagnostic\_setting](#input\_diagnostic\_setting) | The values reuired for creating Diagnostic Setting to sends/store resource logs<br>  Defaults to `{}`.<br>  - `log_analytics_destination_type` - Deafults to `AzureDiagnostics`. The possible values are `Dedicated`, `AzureDiagnostics`.  When set to `Dedicated`, logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy `AzureDiagnostics` table. | <pre>object({<br>    enabled                        = optional(bool, false),<br>    storage_account_name           = optional(string, null)<br>    eventhub_name                  = optional(string, null),<br>    eventhub_authorization_rule_id = optional(string, null),<br>    log_analytics_workspace_name   = optional(string, null),<br>    log_analytics_destination_type = optional(string, "AzureDiagnostics"),<br>    metrics = optional(object({<br>      enabled  = optional(bool, true),<br>      category = optional(string, "AllMetrics")<br>    }), {}),<br>    logs = optional(object({<br>      category       = optional(string, null),<br>      category_group = optional(string, "AllLogs")<br>    }), {}),<br>  })</pre> | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_function_app_application_settings"></a> [function\_app\_application\_settings](#input\_function\_app\_application\_settings) | Function App application settings. | `map(string)` | `{}` | no |
| <a name="input_function_app_application_settings_drift_ignore"></a> [function\_app\_application\_settings\_drift\_ignore](#input\_function\_app\_application\_settings\_drift\_ignore) | Ignore drift from settings manually set. | `bool` | `true` | no |
| <a name="input_function_app_settings"></a> [function\_app\_settings](#input\_function\_app\_settings) | Function App application settings for data lookup to get ID's. | `map(string)` | <pre>{<br>  "appinsights_name": null,<br>  "cosmosdb_account_name": null,<br>  "cosmosdb_database_name": null<br>}</pre> | no |
| <a name="input_function_app_version"></a> [function\_app\_version](#input\_function\_app\_version) | Version of the function app runtime to use. | `number` | `4` | no |
| <a name="input_function_app_vnet_integration"></a> [function\_app\_vnet\_integration](#input\_function\_app\_vnet\_integration) | The subnet to associate with the Function App (Virtual Network integration). | <pre>object({<br>    subnet_name = string,<br>    vnet_name   = string,<br>  })</pre> | `null` | no |
| <a name="input_https_only"></a> [https\_only](#input\_https\_only) | Whether HTTPS traffic only is enabled. | `bool` | `true` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | User Assigned Identities IDs to add to Function App. Mandatory if type is UserAssigned. | `list(string)` | `null` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Add an Identity (MSI) to the function app. Possible values are SystemAssigned or UserAssigned. | `string` | `"SystemAssigned"` | no |
| <a name="input_ip_restriction_default_action"></a> [ip\_restriction\_default\_action](#input\_ip\_restriction\_default\_action) | The Default action for traffic that does not match any ip\_restriction rule. possible values include Allow and Deny. Defaults to Allow. | `string` | `"Allow"` | no |
| <a name="input_ip_restriction_headers"></a> [ip\_restriction\_headers](#input\_ip\_restriction\_headers) | IPs restriction headers for Function. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#headers | `map(list(string))` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location for Function App and related resources. | `string` | n/a | yes |
| <a name="input_maximum_elastic_worker_count"></a> [maximum\_elastic\_worker\_count](#input\_maximum\_elastic\_worker\_count) | Maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU. | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_per_site_scaling_enabled"></a> [per\_site\_scaling\_enabled](#input\_per\_site\_scaling\_enabled) | Should per site scaling be enabled on the Service Plan. | `bool` | `false` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group resources should be created within.<br>If no resource group name is specified, the component will create a new one. | `string` | `null` | no |
| <a name="input_role_assignment"></a> [role\_assignment](#input\_role\_assignment) | The key value pair of role\_defination\_name and active directory name to assign user/role permissions | `map(list(string))` | `{}` | no |
| <a name="input_scm_authorized_ips"></a> [scm\_authorized\_ips](#input\_scm\_authorized\_ips) | SCM IPs restriction for Function App. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#scm_ip_restriction | `list(string)` | `[]` | no |
| <a name="input_scm_authorized_service_tags"></a> [scm\_authorized\_service\_tags](#input\_scm\_authorized\_service\_tags) | SCM Service Tags restriction for Function App. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#scm_ip_restriction | `list(string)` | `[]` | no |
| <a name="input_scm_authorized_subnet_ids"></a> [scm\_authorized\_subnet\_ids](#input\_scm\_authorized\_subnet\_ids) | SCM subnets restriction for Function App. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#scm_ip_restriction | `list(string)` | `[]` | no |
| <a name="input_scm_ip_restriction_headers"></a> [scm\_ip\_restriction\_headers](#input\_scm\_ip\_restriction\_headers) | IPs restriction headers for Function App. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#scm_ip_restriction | `map(list(string))` | `null` | no |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | Site config for Function App. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#site_config. IP restriction attribute is not managed in this block. | `any` | `{}` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU for the Service Plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, WS3, and Y1. | `string` | `"Y1"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_staging_slot_custom_application_settings"></a> [staging\_slot\_custom\_application\_settings](#input\_staging\_slot\_custom\_application\_settings) | Override staging slot with custom application settings. | `map(string)` | `null` | no |
| <a name="input_staging_slot_enabled"></a> [staging\_slot\_enabled](#input\_staging\_slot\_enabled) | Create a staging slot alongside the Function App for blue/green deployment purposes. | `bool` | `false` | no |
| <a name="input_sticky_settings"></a> [sticky\_settings](#input\_sticky\_settings) | Lists of connection strings and app settings to prevent from swapping between slots. | <pre>object({<br>    app_setting_names       = optional(list(string))<br>    connection_string_names = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_storage_account_authorized_ips"></a> [storage\_account\_authorized\_ips](#input\_storage\_account\_authorized\_ips) | IPs restrictions for Function Storage Account in CIDR format. | `list(string)` | `[]` | no |
| <a name="input_storage_account_enable_advanced_threat_protection"></a> [storage\_account\_enable\_advanced\_threat\_protection](#input\_storage\_account\_enable\_advanced\_threat\_protection) | Whether advanced threat protection is enabled. See documentation: https://docs.microsoft.com/en-us/azure/storage/common/storage-advanced-threat-protection?tabs=azure-portal | `bool` | `false` | no |
| <a name="input_storage_account_https_traffic_only_enabled"></a> [storage\_account\_https\_traffic\_only\_enabled](#input\_storage\_account\_https\_traffic\_only\_enabled) | Whether HTTPS traffic only is enabled for Storage Account. | `bool` | `true` | no |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | ID of the existing Storage Account to use. | `string` | `null` | no |
| <a name="input_storage_account_identity_ids"></a> [storage\_account\_identity\_ids](#input\_storage\_account\_identity\_ids) | Specifies a list of User Assigned Managed Identity IDs to be assigned to the Storage Account. | `list(string)` | `null` | no |
| <a name="input_storage_account_identity_type"></a> [storage\_account\_identity\_type](#input\_storage\_account\_identity\_type) | Type of Managed Service Identity that should be configured on the Storage Account. | `string` | `null` | no |
| <a name="input_storage_account_kind"></a> [storage\_account\_kind](#input\_storage\_account\_kind) | Storage Account Kind. | `string` | `"StorageV2"` | no |
| <a name="input_storage_account_min_tls_version"></a> [storage\_account\_min\_tls\_version](#input\_storage\_account\_min\_tls\_version) | Storage Account minimal TLS version. | `string` | `"TLS1_2"` | no |
| <a name="input_storage_account_network_bypass"></a> [storage\_account\_network\_bypass](#input\_storage\_account\_network\_bypass) | Whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of `Logging`, `Metrics`, `AzureServices`, or `None`. | `list(string)` | <pre>[<br>  "Logging",<br>  "Metrics",<br>  "AzureServices"<br>]</pre> | no |
| <a name="input_storage_account_network_rules_enabled"></a> [storage\_account\_network\_rules\_enabled](#input\_storage\_account\_network\_rules\_enabled) | Whether to enable Storage Account network default rules for functions. | `bool` | `true` | no |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | (Required) Defines the type of replication to use for this storage account. Valid options are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`.  Defaults to `ZRS` | `string` | `"RAGZRS"` | no |
| <a name="input_storage_uses_managed_identity"></a> [storage\_uses\_managed\_identity](#input\_storage\_uses\_managed\_identity) | Whether the Function App use Managed Identity to access the Storage Account. **Caution** This disable the storage keys on the Storage Account if created within the module. | `bool` | `false` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Suffix for naming module | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_use_existing_storage_account"></a> [use\_existing\_storage\_account](#input\_use\_existing\_storage\_account) | Whether existing Storage Account should be used instead of creating a new one. | `bool` | `false` | no |
| <a name="input_worker_count"></a> [worker\_count](#input\_worker\_count) | Number of Workers (instances) to be allocated. | `number` | `null` | no |
| <a name="input_zone_balancing_enabled"></a> [zone\_balancing\_enabled](#input\_zone\_balancing\_enabled) | Should the Service Plan balance across Availability Zones in the region. Defaults to `false` because the default SKU `Y1` for the App Service Plan cannot use this feature. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_app_id"></a> [function\_app\_id](#output\_function\_app\_id) | Function app id |
| <a name="output_function_app_name"></a> [function\_app\_name](#output\_function\_app\_name) | Function app name |
| <a name="output_function_app_principal_id"></a> [function\_app\_principal\_id](#output\_function\_app\_principal\_id) | Function app principal ID |
| <a name="output_function_app_rg_name"></a> [function\_app\_rg\_name](#output\_function\_app\_rg\_name) | Function app resource group name |
| <a name="output_function_app_slot_id"></a> [function\_app\_slot\_id](#output\_function\_app\_slot\_id) | Function app slot id |
| <a name="output_function_app_slot_name"></a> [function\_app\_slot\_name](#output\_function\_app\_slot\_name) | Function App Slot name |
| <a name="output_function_app_staging_slot_principal_id"></a> [function\_app\_staging\_slot\_principal\_id](#output\_function\_app\_staging\_slot\_principal\_id) | Function app Staging Slot principal ID |
<!-- END-TERRAFORM-DOCS -->