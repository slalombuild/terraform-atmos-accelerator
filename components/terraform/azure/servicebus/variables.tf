variable "location" {
  type        = string
  description = <<DESCRIPTION
The location/region where the Service Bus is created. Changing this forces a new resource to be created.
DESCRIPTION
}

variable "log_analytics_as_diagnostics_destination" {
  type        = bool
  default     = true
  description = "Log Analytics workspace as a destination to create diaganostic settings"
}

variable "queues" {
  type = map(object({
    name                                    = optional(string, null)
    max_delivery_count                      = optional(number, 10)
    enable_batched_operations               = optional(bool, true)
    requires_duplicate_detection            = optional(bool, false)
    requires_session                        = optional(bool, false)
    dead_lettering_on_message_expiration    = optional(bool, false)
    enable_partitioning                     = optional(bool, null)
    enable_express                          = optional(bool, null)
    max_message_size_in_kilobytes           = optional(number, null)
    default_message_ttl                     = optional(string, null)
    forward_to                              = optional(string, null)
    forward_dead_lettered_messages_to       = optional(string, null)
    auto_delete_on_idle                     = optional(string, null)
    max_size_in_megabytes                   = optional(number, 1024)
    lock_duration                           = optional(string, "PT1M")
    duplicate_detection_history_time_window = optional(string, "PT10M")
    status                                  = optional(string, "Active")

    authorization_rules = optional(map(object({
      name   = optional(string, null)
      send   = optional(bool, false)
      listen = optional(bool, false)
      manage = optional(bool, false)
    })), {})

    role_assignments = optional(map(object({
      role_definition_id_or_name = string
      principal_id               = string

      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      delegated_managed_identity_resource_id = optional(string, null)
    })), {})
  }))
  default     = {}
  description = <<DESCRIPTION
  Defaults to `{}`. A map of queues to create.
  The name of the queue must be unique among topics and queues within the namespace.

  - `name`                                    - (Optional) - Defaults to `null`. Specifies the name of the ServiceBus Queue resource. Changing this forces a new resource to be created. If it is null it will use the map key as the name.
  - `lock_duration`                           - (Optional) - Its minimum and default value is `PT1M` (1 minute). Maximum value is `PT5M` (5 minutes). The ISO 8601 timespan duration of a peek-lock; that is, the amount of time that the message is locked for other receivers.
  - `max_message_size_in_kilobytes`           - (Optional) - Always set to `256` for Standard and Basic by Azure. It's mininum and also defaults is `1024` with maximum value of `102400` for Premium. Integer value which controls the maximum size of a message allowed on the queue.
  - `max_size_in_megabytes`                   - (Optional) - Defaults to `1024`. Possible values are `1024`, `2048`, `3072`, `4096`, `5120`, `10240`, `20480`, `40960` and `81920`. Integer value which controls the size of memory allocated for the queue.
  - `requires_duplicate_detection`            - (Optional) - Always set to `false` for Basic by Azure. It Defaults to `false` for the rest of skus. Boolean flag which controls whether the Queue requires duplicate detection. Changing this forces a new resource to be created.
  - `requires_session`                        - (Optional) - Always set to `false` for Basic by Azure. It Defaults to `false` for the rest of skus. Boolean flag which controls whether the Queue requires sessions. This will allow ordered handling of unbounded sequences of related messages. With sessions enabled a queue can guarantee first-in-first-out delivery of messages. Changing this forces a new resource to be created.
  - `default_message_ttl`                     - (Optional) - Defaults to `null`. Mininum value of `PT5S` (5 seconds) and maximum of `P10675198D` (10675198 days). Set `null` for never. The ISO 8601 timespan duration of the TTL of messages sent to this queue. This is the default value used when TTL is not set on message itself.
  - `dead_lettering_on_message_expiration`    - (Optional) - Defaults to `false`. Boolean flag which controls whether the Queue has dead letter support when a message expires.
  - `duplicate_detection_history_time_window` - (Optional) - Defaults to `PT10M` (10 minutes). Minimun of `PT20S` (seconds) and Maximun of `P7D` (7 days). The ISO 8601 timespan duration during which duplicates can be detected.
  - `max_delivery_count`                      - (Optional) - Defaults to `10`. Minimum of `1` and Maximun of `2147483647`. Integer value which controls when a message is automatically dead lettered.
  - `status`                                  - (Optional) - Defaults to `Active`. The status of the Queue. Possible values are Active, Creating, Deleting, Disabled, ReceiveDisabled, Renaming, SendDisabled, Unknown.
  - `enable_batched_operations`               - (Optional) - Defaults to `true`. Boolean flag which controls whether server-side batched operations are enabled.
  - `auto_delete_on_idle`                     - (Optional) - Always set to `null` when Basic. It Defaults to `null` for the rest of skus. Minimum of `PT5M` (5 minutes) and maximum of `P10675198D` (10675198 days). Set `null` for never. The ISO 8601 timespan duration of the idle interval after which the Topic is automatically deleted.
  - `enable_partitioning`                     - (Optional) - Defaults to `false` for Basic and Standard. For Premium if premium_messaging_partitions is greater than `1` it will always be set to true if not it will be set to `false`. Boolean flag which controls whether to enable the queue to be partitioned across multiple message brokers. Changing this forces a new resource to be created.
  - `enable_express`                          - (Optional) - Always set to `false` for Premium and Basic by Azure. Defaults to `false` for Standard. Boolean flag which controls whether Express Entities are enabled. An express queue holds a message in memory temporarily before writing it to persistent storage. It requires requires_duplicate_detection to be set to `false`
  - `forward_to`                              - (Optional) - Always set to `false` for Basic by Azure. It Defaults to `null` for the rest of skus. The name of a Queue or Topic to automatically forward messages to. It cannot be enabled if requires_session is enabled.
  - `forward_dead_lettered_messages_to`       - (Optional) - Defaults to `null`. The name of a Queue or Topic to automatically forward dead lettered messages to

  - `authorization_rules` - (Optional) - Defaults to `{}`.
    - `name`   - (Optional) - Defaults to `null`. Specifies the name of the Authorization Rule. Changing this forces a new resource to be created. If it is null it will use the map key as the name.
    - `send`   - (Optional) - Always set to `true` when manage is `true` if not it will default to `false`. Does this Authorization Rule have Listen permissions to the ServiceBus Queue?
    - `listen` - (Optional) - Always set to `true` when manage is `true` if not it will default to `false`. Does this Authorization Rule have Send permissions to the ServiceBus Queue?
    - `manage` - (Optional) - Defaults to `false`. Does this Authorization Rule have Manage permissions to the ServiceBus Queue?
  - `role_assignments` - (Optional) - Defaults to `{}`. A map of role assignments to create. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
    - `role_definition_id_or_name`             - (Required) - The ID or name of the role definition to assign to the principal.
    - `principal_id`                           - (Required) - It's a GUID - The ID of the principal to assign the role to.
    - `description`                            - (Optional) - Defaults to `null`. The description of the role assignment.
    - `delegated_managed_identity_resource_id` - (Optional) - Defaults to `null`. The delegated Azure Resource Id which contains a Managed Identity. This field is only used in cross tenant scenario. Changing this forces a new resource to be created.
    - `skip_service_principal_aad_check`       - (Optional) - Defaults to `false`. If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag. This argument is only valid if the principal_id is a Service Principal identity.

  Example Inputs:
  ```hcl
  queues = {
    testQueue = {
      auto_delete_on_idle                     = "P7D"
      dead_lettering_on_message_expiration    = true
      default_message_ttl                     = "PT5M"
      duplicate_detection_history_time_window = "PT5M"
      enable_batched_operations               = true
      enable_express                          = true
      enable_partitioning                     = true
      lock_duration                           = "PT5M"
      requires_duplicate_detection            = true
      requires_session                        = false
      max_delivery_count                      = 10
      max_message_size_in_kilobytes           = 1024
      max_size_in_megabytes                   = 1024
      status                                  = "Active"
      forward_to                              = "forwardQueue"
      forward_dead_lettered_messages_to       = "forwardQueue"

      role_assignments = {
        "key" = {
          skip_service_principal_aad_check = false
          role_definition_id_or_name       = "Contributor"
          description                      = "This is a test role assignment"
          principal_id                     = "eb5260bd-41f3-4019-9e03-606a617aec13"
        }
      }

      authorization_rules = {
        testRule = {
          send   = true
          listen = true
          manage = true
        }
      }
    }
  }
  ```
  DESCRIPTION
  nullable    = false

  validation {
    condition = alltrue([
      for _, v in var.queues :
      v.forward_to != null && v.requires_session ? false : true
    ])
    error_message = "Forwarding to another queue or topic is not supported when requires_session is set to true."
  }
  validation {
    condition = alltrue([
      for _, v in var.queues :
      contains(["Active", "Creating", "Deleting", "Disabled", "ReceiveDisabled", "Renaming", "SendDisabled", "Unknown"], v.status)
    ])
    error_message = "The status parameter can only be `Active`, `Creating`, `Deleting`, `Disabled`, `ReceiveDisabled`, `Renaming`, `SendDisabled`, `Unknown`."
  }
  validation {
    condition = alltrue([
      for _, v in var.queues :
      contains([1024, 2048, 3072, 4096, 5120, 10240, 20480, 40960, 81920], v.max_size_in_megabytes)
    ])
    error_message = "The max_size_in_megabytes parameter must be one of `1024`, `2048`, `3072`, `4096`, `5120`, `10240`, `20480`, `40960`, `81920`."
  }
  validation {
    condition = alltrue([
      for _, v in var.queues :
      1 <= v.max_delivery_count && 2147483647 >= v.max_delivery_count
    ])
    error_message = "value of max_delivery_count must be between 1 and 2147483647."
  }
  validation {
    condition = alltrue(flatten([
      for queue_name, queue_params in var.queues :
      [
        for k, v in queue_params.role_assignments :
        v.role_definition_id_or_name != null
      ]
    ]))
    error_message = "Role definition id or name must be set"
  }
  validation {
    condition = alltrue(flatten([
      for queue_name, queue_params in var.queues :
      [
        for k, v in queue_params.role_assignments :
        can(regex("^([a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12})$", v.principal_id))
      ]
    ]))
    error_message = "principal_id must be a valid GUID"
  }
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

variable "sb_authorization_rules" {
  type = map(object({
    name   = optional(string, null),
    send   = optional(bool, false),
    listen = optional(bool, false),
    manage = optional(bool, false)
  }))
  default     = {}
  description = <<DESCRIPTION
 Defaults to `{}`.
 Manages a ServiceBus Namespace authorization Rule within a ServiceBus.
 - `name` - (Optional) - Defaults to `null`. Specifies the name of the ServiceBus Namespace Authorization Rule resource. Changing this forces a new resource to be created. If it is null it will use the map key as the name.
 - `send` - (Optional) - Always set to `true` when manage is `true` if not it will default to `false`. Does this Authorization Rule have Listen permissions to the ServiceBus Namespace?
 - `listen` - (Optional) - Always set to `true` when manage is `true` if not it will default to `false`. Does this Authorization Rule have Send permissions to the ServiceBus Namespace?
 - `manage` - (Optional) - Defaults to `false`. Does this Authorization Rule have Manage permissions to the ServiceBus Namespace?
 Example Inputs:
  ```hcl
  authorization_rules = {
    testRule = {
      send   = true
      listen = true
      manage = true
    }
  }
  ```
 DESCRIPTION
  nullable    = false
}

variable "sb_customer_managed_key" {
  type = object({
    key_name              = string,
    key_vault_resource_id = string,
    key_version           = optional(string, null),
    user_assigned_identity = optional(object({
      resource_id = string,
    }), null)
  })
  default     = null
  description = <<DESCRIPTION
  Defaults to `null`.
  Ignored for Basic and Standard.
  Defines a customer managed key to use for encryption.
  - `key_name` - (Required) - The key name for the customer managed key in the key vault.
  - `key_vault_resource_id` - (Required) - The full Azure Resource ID of the key_vault where the customer managed key will be referenced from.
  - `key_version` - (Optional) - Defaults to `null`. The version of the key to use if it is null it will use the latest version of the key. It will also auto rotate when the key in the key vault is rotated.
  - `user_assigned_identity` - (Required) - The user assigned identity to use when access the key vault
  - `resource_id` - (Required) - The full Azure Resource ID of the user assigned identity.
    > Note: Remember to assign permission to the managed identity to access the key vault key. The Key vault used must have enabled soft delete and purge protection. The minimun required permissions is "Key Vault Crypto Service Encryption User"
    > Note: If you require to control "infrastructure encryption" use the parameter `infrastructure_encryption_enabled` in the module configuration.
  Example Inputs:
  ```hcl
  sb_customer_managed_key = {
    key_name               = "sample-customer-key"
    key_version            = 03c89971825b4a0d84905c3597512260
    key_vault_resource_id  = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/vaults/{keyVaultName}"
    user_assigned_identity {
      resource_id = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{managedIdentityName}"
    }
  }
  ```
  DESCRIPTION

  validation {
    condition     = var.sb_customer_managed_key == null || can(regex("^/subscriptions/[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}/resourceGroups/.+/providers/Microsoft.ManagedIdentity/userAssignedIdentities/.+$", var.sb_customer_managed_key.user_assigned_identity.resource_id))
    error_message = "Managed identity resource IDs must be in the format /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{managedIdentityName}"
  }
  validation {
    condition     = var.sb_customer_managed_key == null || can(regex("^/subscriptions/[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}/resourceGroups/.+/providers/Microsoft.KeyVault/vaults/.+$", var.sb_customer_managed_key.key_vault_resource_id))
    error_message = "Key vault resource IDs must be in the format /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/vaults/{keyVaultName}"
  }
  validation {
    condition     = var.sb_customer_managed_key == null ? true : var.sb_customer_managed_key.key_name != null
    error_message = "key_name must have a value"
  }
}

variable "sb_diagnostic_settings" {
  type = map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    storage_account_name                     = optional(string, null)
    log_analytics_workspace_name             = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.
- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.
- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.
- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.
- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.
- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.
- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.
- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.
- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.
- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs.
DESCRIPTION
  nullable    = false

  validation {
    condition     = alltrue([for _, v in var.sb_diagnostic_settings : contains(["Dedicated", "AzureDiagnostics"], v.log_analytics_destination_type)])
    error_message = "Log analytics destination type must be one of: 'Dedicated', 'AzureDiagnostics'."
  }
  validation {
    condition = alltrue(
      [
        for _, v in var.sb_diagnostic_settings :
        v.log_analytics_workspace_name != null || v.storage_account_name != null || v.event_hub_authorization_rule_resource_id != null || v.marketplace_partner_resource_id != null
      ]
    )
    error_message = "At least one of `log_analytrics_workspace`, `storage_account`, `marketplace_partner_resource_id`, or `event_hub_authorization_rule_resource_id`, must be set."
  }
}

variable "sb_network_rule_config" {
  type = object({
    trusted_services_allowed = optional(bool, false)
    cidr_or_ip_rules         = optional(set(string), [])
    default_action           = optional(string, "Allow")

    network_rules = optional(list(object({
      subnet_name = string
      vnet_name   = string
    })), [])
  })
  default     = {}
  description = <<DESCRIPTION
  Defaults to `{}`. Ignored for Basic and Standard. Defines the network rules configuration for the resource.
  - `trusted_services_allowed` - (Optional) - Are Azure Services that are known and trusted for this resource type are allowed to bypass firewall configuration?
  - `cidr_or_ip_rules`         - (Optional) - Defaults to `[]`. One or more IP Addresses, or CIDR Blocks which should be able to access the ServiceBus Namespace.
  - `default_action`           - (Optional) - Defaults to `Allow`. Specifies the default action for the Network Rule Set when a rule (IP, CIDR or subnet) doesn't match. Possible values are `Allow` and `Deny`.
  - `network_rules` - (Optional) - Defaults to `[]`.
    - `subnet_name`                            - (Required) - The Subnet Name which should be able to access this ServiceBus Namespace.
    - `vnet_name`                              - (Required) - The Vnet Name of Where subnet is loacted.

  > Note: Remember to enable Microsoft.KeyVault service endpoint on the subnet.
  Example Inputs:
  ```hcl
  sb_network_rule_config = {
    trusted_services_allowed = true
    default_action           = "Allow"
    cidr_or_ip_rules         = ["79.0.0.0", "80.0.0.0/24"]

    network_rules = [
      {
        subnet_name    = "demo-snet"
        vnet_name      = "demo-vnet"
      }
    ]
  }
  ```
  DESCRIPTION
  nullable    = false

  validation {
    condition     = contains(["Allow", "Deny"], var.sb_network_rule_config.default_action)
    error_message = "Default action can only be Allow or Deny"
  }
  validation {
    condition = alltrue([
      for value in var.sb_network_rule_config.network_rules :
      value.subnet_name != null && value.vnet_name != null
    ])
    error_message = "Values must be set for subnet_name, vnet_name, subnet_rg_name"
  }
  validation {
    condition = alltrue([
      for value in var.sb_network_rule_config.cidr_or_ip_rules :
      value == null ? false : strcontains(value, "/") == false || can(cidrhost(value, 0))
    ])
    error_message = "Allowed Ips must be valid IPv4 CIDR."
  }
  validation {
    condition = alltrue([
      for value in var.sb_network_rule_config.cidr_or_ip_rules :
      value == null ? false : strcontains(value, "/") || can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", value))
    ])
    error_message = "Allowed IPs must be valid IPv4."
  }
}

variable "sb_private_endpoints" {
  type = map(object({
    tags = optional(map(string), null),

    lock = optional(object({
      kind = string,
      name = optional(string, null)
    }), null),

    role_assignments = optional(map(object({
      role_definition_id_or_name             = string,
      principal_id                           = string,
      description                            = optional(string, null),
      skip_service_principal_aad_check       = optional(bool, false),
      delegated_managed_identity_resource_id = optional(string, null),

      condition         = optional(string, null) # forced to be here by lint, not supported
      condition_version = optional(string, null) # forced to be here by lint, not supported
    })), {}),
    subnet_resource_id                      = string,
    name                                    = optional(string, null),
    private_dns_zone_group_name             = optional(string, "default"),
    private_dns_zone_resource_ids           = optional(set(string), []),
    application_security_group_associations = optional(map(string), {}),
    private_service_connection_name         = optional(string, null),
    network_interface_name                  = optional(string, null),
    location                                = optional(string, null),
    resource_group_name                     = optional(string, null),
    ip_configurations = optional(map(object({
      name               = string,
      private_ip_address = string
    })), {}),
  }))
  default     = {}
  description = <<DESCRIPTION
  Default to `{}`. Ignored for Basic and Standard. A map of private endpoints to create. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

  - `name` - (Optional) The name of the private endpoint. One will be generated if not set.
  - `role_assignments` - (Optional) A map of role assignments to create on the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time. See `var.role_assignments` for more information.
  - `lock` - (Optional) The lock level to apply to the private endpoint. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`.
  - `tags` - (Optional) A mapping of tags to assign to the private endpoint.
  - `subnet_resource_id` - The resource ID of the subnet to deploy the private endpoint in.
  - `private_dns_zone_group_name` - (Optional) The name of the private DNS zone group. One will be generated if not set.
  - `private_dns_zone_resource_ids` - (Optional) A set of resource IDs of private DNS zones to associate with the private endpoint. If not set, no zone groups will be created and the private endpoint will not be associated with any private DNS zones. DNS records must be managed external to this module.
  - `application_security_group_associations` - (Optional) A map of resource IDs of application security groups to associate with the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
  - `private_service_connection_name` - (Optional) The name of the private service connection. One will be generated if not set.
  - `network_interface_name` - (Optional) The name of the network interface. One will be generated if not set.
  - `location` - (Optional) The Azure location where the resources will be deployed. Defaults to the location of the resource group.
  - `resource_group_name` - (Optional) The resource group where the resources will be deployed. Defaults to the resource group of the resource.
  - `ip_configurations` - (Optional) A map of IP configurations to create on the private endpoint. If not specified the platform will create one. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
    - `name` - The name of the IP configuration.
    - `private_ip_address` - The private IP address of the IP configuration.
  DESCRIPTION
  nullable    = false
}

variable "sb_private_endpoints_manage_dns_zone_group" {
  type        = bool
  default     = false
  description = <<DESCRIPTION
  Defaults to `true`. Is public network access enabled for the Service Bus Namespace?
  DESCRIPTION
}

variable "sb_role_assignments" {
  type = map(object({
    role_definition_id_or_name = string
    principal_name             = string

    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    delegated_managed_identity_resource_id = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
  Defaults to `{}`. A map of role assignments to create. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

  - `role_definition_id_or_name`             - (Required) - The ID or name of the role definition to assign to the principal.
  - `principal_name`                           - (Required) - The Name of the principal to assign the role to.
  - `description`                            - (Optional) - Defaults to `null`. The description of the role assignment.
  - `delegated_managed_identity_resource_id` - (Optional) - Defaults to `null`. The delegated Azure Resource Id which contains a Managed Identity. This field is only used in cross tenant scenario. Changing this forces a new resource to be created.
  - `skip_service_principal_aad_check`       - (Optional) - Defaults to `false`. If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag. This argument is only valid if the principal_id is a Service Principal identity.
  > Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.

  Example Inputs:
  ```hcl
  role_assignments = {
    "key" = {
      skip_service_principal_aad_check = false
      role_definition_id_or_name       = "Contributor"
      description                      = "This is a test role assignment"
      principal_name                    = "dev-user1"
    }
  }
  ```
  DESCRIPTION
  nullable    = false

  validation {
    condition = alltrue([
      for k, v in var.sb_role_assignments :
      v.role_definition_id_or_name != null
    ])
    error_message = "Role definition id or name must be set"
  }
  validation {
    condition = alltrue([
      for k, v in var.sb_role_assignments :
      v.principal_name != null
    ])
    error_message = "Principal name must be set"
  }
}

variable "service_bus" {
  type = object({
    sku                               = optional(string, "Standard"),
    capacity                          = optional(number, null),
    enable_telemetry                  = optional(bool, false),
    infrastructure_encryption_enabled = optional(bool, false),
    local_auth_enabled                = optional(bool, true),
    managed_identities = optional(object({
      system_assigned            = optional(bool, false),
      user_assigned_resource_ids = optional(set(string), [])
    }), {}),
    minimum_tls_version           = optional(string, "1.2"),
    premium_messaging_partitions  = optional(number, null),
    public_network_access_enabled = optional(bool, false),
    resource_lock = optional(object({
      kind = string,
      name = optional(string, null)
    }), null),
    zone_redundant = optional(bool, null)
  })
  default     = {}
  description = <<DESCRIPTION
  Defaults to `{}`.
  - `sku` - (Optional) - Defaults to `Standard`. Defines which tier to use. Options are Basic, Standard or Premium. Please note that setting this field to Premium will force the creation of a new resource.
  - `capacity` - (Optional) - Defaults to `null`. Always set to `0` for Standard and Basic. Defaults to `1` for Premium. Specifies the capacity. When sku is Premium, capacity can be 1, 2, 4, 8 or 16.
  - `enable_telemetry ` - (Optional) - Defaults to `false`. This variable controls whether or not telemetry is enabled for the module. For more information see https://aka.ms/avm/telemetryinfo. If it is set to false, then no telemetry will be collected.
  - `infrastructure_encryption_enabled ` - (Optional) - Defaults to `false`. Used to specify whether enable Infrastructure Encryption (Double Encryption). Changing this forces a new resource to be created. Requires customer_managed_key.
  - `managed_identities` - (Optional) - Defaults to `{}`. Controls the Managed Identity configuration on this resource.
      The following properties can be specified:
        - `system_assigned` - (Optional) - Defaults to `false`. Specifies if the System Assigned Managed Identity should be enabled.
        - `user_assigned_resource_ids` - (Optional) - Defaults to `[]`. Specifies a set of User Assigned Managed Identity resource IDs to be assigned to this resource.
        Example Inputs:
          ```hcl
          managed_identities = {
            system_assigned            = true
            user_assigned_resource_ids = [
              "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{managedIdentityName}"
            ]
          }
          ```
  - `local_auth_enabled` - (Optional) - Defaults to `true`. Whether or not SAS authentication is enabled for the Service Bus namespace.
  - `public_network_access_enabled` - (Optional) - Defaults to `false`.  Is public network access enabled for the Service Bus Namespace?
  - `resource_lock` - (Optional) - Defaults to `null`. Controls the Resource Lock configuration for this resource. If specified, it will be inherited by child resources unless overriden when creating those child resources.
      The following properties can be specified:
        - `kind` - (Required) - The type of lock. Possible values are `CanNotDelete` and `ReadOnly`.
        - `name` - (Optional) - The name of the lock. If not specified, a name will be generated based on the `kind` value. Changing this forces the creation of a new resource. > Note: If you use `ReadOnly` kind lock, you must configure Terraform to use EntraId authentication, as the access of the namespace keys will be blocked thus terraform won't be to do its job.
         Example Inputs:
          ```hcl
          lock = {
            kind = "CanNotDelete"
            name = "This resource cannot be deleted easily"
          }
          ```
  - `zone_redundant` - (Optional) - Defaults to `null`. Always set to `false` for Standard and Basic. Defaults to `true` for Premium. Whether or not this resource is zone redundant. Changing this forces a new resource to be created.
  DESCRIPTION

  validation {
    condition     = alltrue([for v in [var.service_bus.sku] : contains(["Basic", "Standard", "Premium"], v)])
    error_message = "The sku variable must be either Basic, Standard, or Premium."
  }
  validation {
    condition     = alltrue([for v in [var.service_bus.capacity] : v == null || can(index([1, 2, 4, 8, 16], v))])
    error_message = "The capacity variable must be 1, 2, 4, 8, or 16 when sku is Premium."
  }
  validation {
    condition = alltrue(
      [
        for mi_id in var.service_bus.managed_identities.user_assigned_resource_ids :
        can(regex("^/subscriptions/[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}/resourceGroups/.+/providers/Microsoft.ManagedIdentity/userAssignedIdentities/.+$", mi_id))
      ]
    )
    error_message = "Managed identity resource IDs must be in the format /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{managedIdentityName}"
  }
  validation {
    condition     = alltrue([for v in [var.service_bus.minimum_tls_version] : v == null || can(index(["1.0", "1.1", "1.2"], v))])
    error_message = "The minimum_tls_version variable must be 1.0, 1.1 or 1.2."
  }
  validation {
    condition     = alltrue([for v in [var.service_bus.premium_messaging_partitions] : v == null || can(index([1, 2, 4], v))])
    error_message = "The premium_messaging_partitions variable must be 1, 2, or 4 when sku is Premium."
  }
}

variable "service_bus_namespace_name" {
  type        = string
  default     = null
  description = "The existing service bus namespace name"
}

variable "storage_account_as_diagnostics_destination" {
  type        = bool
  default     = false
  description = "storage account as a destination to create diaganostic settings"
}

variable "suffix" {
  type        = string
  default     = null
  description = "Suffix for naming module"
}

variable "topics" {
  type = map(object({
    name                                    = optional(string, null)
    enable_batched_operations               = optional(bool, true)
    requires_duplicate_detection            = optional(bool, false)
    enable_partitioning                     = optional(bool, null)
    enable_express                          = optional(bool, null)
    support_ordering                        = optional(bool, false)
    max_message_size_in_kilobytes           = optional(number, null)
    default_message_ttl                     = optional(string, null)
    auto_delete_on_idle                     = optional(string, null)
    max_size_in_megabytes                   = optional(number, 1024)
    duplicate_detection_history_time_window = optional(string, "PT10M")
    status                                  = optional(string, "Active")

    authorization_rules = optional(map(object({
      name   = optional(string, null)
      send   = optional(bool, false)
      listen = optional(bool, false)
      manage = optional(bool, false)
    })), {})

    subscriptions = optional(map(object({
      name                                      = optional(string, null)
      max_delivery_count                        = optional(number, 10)
      dead_lettering_on_filter_evaluation_error = optional(bool, true)
      enable_batched_operations                 = optional(bool, true)
      dead_lettering_on_message_expiration      = optional(bool, false)
      requires_session                          = optional(bool, false)
      forward_to                                = optional(string, null)
      forward_dead_lettered_messages_to         = optional(string, null)
      auto_delete_on_idle                       = optional(string, null)
      default_message_ttl                       = optional(string, null)
      lock_duration                             = optional(string, "PT1M")
      status                                    = optional(string, "Active")
    })), {})

    role_assignments = optional(map(object({
      role_definition_id_or_name = string
      principal_id               = string

      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      delegated_managed_identity_resource_id = optional(string, null)
    })), {})
  }))
  default     = {}
  description = <<DESCRIPTION
  Defaults to `{}`. Ignored for Basic. A map of topics to create.
  The name of the topic must be unique among topics and queues within the namespace.

  - `name`                                    - (Optional) - Defaults to `null`. Specifies the name of the ServiceBus Topic resource. Changing this forces a new resource to be created. If it is null it will use the map key as the name.
  - `max_message_size_in_kilobytes`           - (Optional) - Always set to `256` for Standard by Azure. It's mininum and also defaults is `1024` with maximum value of `102400` for Premium. Integer value which controls the maximum size of a message allowed on the Topic.
  - `max_size_in_megabytes`                   - (Optional) - Defaults to `1024`. Possible values are `1024`, `2048`, `3072`, `4096`, `5120`, `10240`, `20480`, `40960` and `81920`. Integer value which controls the size of memory allocated for the Topic.
  - `requires_duplicate_detection`            - (Optional) - Defaults to `false`. Boolean flag which controls whether the Topic requires duplicate detection. Changing this forces a new resource to be created.
  - `default_message_ttl`                     - (Optional) - Defaults to `null`. Mininum value of `PT5S` (5 seconds) and maximum of `P10675198D` (10675198 days). Set `null` for never. The ISO 8601 timespan duration of the TTL of messages sent to this topic. This is the default value used when TTL is not set on message itself.
  - `duplicate_detection_history_time_window` - (Optional) - Defaults to `PT10M` (10 minutes). Minimun of `PT20S` (seconds) and Maximun of `P7D` (7 days). The ISO 8601 timespan duration during which duplicates can be detected.
  - `status`                                  - (Optional) - Defaults to `Active`. The status of the Topic. Possible values are Active, Creating, Deleting, Disabled, ReceiveDisabled, Renaming, SendDisabled, Unknown.
  - `enable_batched_operations`               - (Optional) - Defaults to `true`. Boolean flag which controls whether server-side batched operations are enabled.
  - `auto_delete_on_idle`                     - (Optional) - Defaults to `null`. Minimum of `PT5M` (5 minutes) and maximum of `P10675198D` (10675198 days). Set `null` for never. The ISO 8601 timespan duration of the idle interval after which the Topic is automatically deleted.
  - `enable_partitioning`                     - (Optional) - Defaults to `false` for Standard. For Premium if premium_messaging_partitions is greater than `1` it will always be set to true if not it will be set to `false`. Boolean flag which controls whether to enable the topic to be partitioned across multiple message brokers. Changing this forces a new resource to be created.
  - `enable_express`                          - (Optional) - Defaults to `false` for Standard. Always set to `false` for Premium. Boolean flag which controls whether Express Entities are enabled. An express topic holds a message in memory temporarily before writing it to persistent storage.
  - `support_ordering`                        - (Optional) - Defaults to `false`. Boolean flag which controls whether the Topic supports ordering.

  - `authorization_rules` - (Optional) - Defaults to `{}`.
    - `name`   - (Optional) - Defaults to `null`. Specifies the name of the ServiceBus Topic Authorization Rule resource. Changing this forces a new resource to be created. If it is null it will use the map key as the name.
    - `send`   - (Optional) - Always set to `true` when manage is `true` if not it will default to `false`. Does this Authorization Rule have Listen permissions to the ServiceBus Topic?
    - `listen` - (Optional) - Always set to `true` when manage is `true` if not it will default to `false`. Does this Authorization Rule have Send permissions to the ServiceBus Topic?
    - `manage` - (Optional) - Defaults to `false`. Does this Authorization Rule have Manage permissions to the ServiceBus Topic?

  - `subscriptions - (Optional) - Defaults to `{}`.
    - `name`                                      - (Optional) - Defaults to `null`. Specifies the name of the ServiceBus Subscription resource. Changing this forces a new resource to be created. If it is null it will use the map key as the name.
    - `max_delivery_count`                        - (Optional) - Defaults to `10`. Minimum of `1` and Maximun of `2147483647`. Integer value which controls when a message is automatically dead lettered.
    - `dead_lettering_on_filter_evaluation_error` - (Optional) - Defaults to `true`. Boolean flag which controls whether the Subscription has dead letter support on filter evaluation exceptions
    - `dead_lettering_on_message_expiration`      - (Optional) - Defaults to `false`. Boolean flag which controls whether the Subscription has dead letter support when a message expires.
    - `enable_batched_operations`                 - (Optional) - Defaults to `true`. Boolean flag which controls whether the Subscription supports batched operations.
    - `requires_session`                          - (Optional) - Defaults to `false`. Boolean flag which controls whether this Subscription supports the concept of a session. Changing this forces a new resource to be created.
    - `forward_to`                                - (Optional) - Defaults to `null`. The name of a Queue or Topic to automatically forward messages to.
    - `forward_dead_lettered_messages_to`         - (Optional) - Defaults to `null`. The name of a Queue or Topic to automatically forward dead lettered messages to
    - `auto_delete_on_idle`                       - (Optional) - Defaults to `null`. Minimum of `PT5M` (5 minutes) and maximum of `P10675198D` (10675198 days). Set `null` for never. The ISO 8601 timespan duration of the idle interval after which the Topic is automatically deleted.
    - `default_message_ttl`                       - (Optional) - Defaults to `null`. Mininum value of `PT5S` (5 seconds) and maximum of `P10675198D` (10675198 days). Set `null` for never. The ISO 8601 timespan duration of the TTL of messages sent to this queue. This is the default value used when TTL is not set on message itself.
    - `lock_duration`                             - (Optional) - Its minimum and default value is `PT1M` (1 minute). Maximum value is `PT5M` (5 minutes). The ISO 8601 timespan duration of a peek-lock; that is, the amount of time that the message is locked for other receivers.
    - `status`                                    - (Optional) - Defaults to `Active`. The status of the Subscription. Possible values are Active, ReceiveDisabled, Disabled.

  - `role_assignments - (Optional) - Defaults to `{}`. A map of role assignments to create. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
    - `role_definition_id_or_name`             - (Required) - The ID or name of the role definition to assign to the principal.
    - `principal_id`                           - (Required) - It's a GUID - The ID of the principal to assign the role to.
    - `description`                            - (Optional) - Defaults to `null`. The description of the role assignment.
    - `delegated_managed_identity_resource_id` - (Optional) - Defaults to `null`. The delegated Azure Resource Id which contains a Managed Identity. This field is only used in cross tenant scenario. Changing this forces a new resource to be created.
    - `skip_service_principal_aad_check`       - (Optional) - Defaults to `false`. If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag. This argument is only valid if the principal_id is a Service Principal identity.
  Example Inputs:
  ```hcl
  topics = {
    testTopic = {
      auto_delete_on_idle                     = "P7D"
      default_message_ttl                     = "PT5M"
      duplicate_detection_history_time_window = "PT5M"
      enable_batched_operations               = true
      enable_express                          = false
      enable_partitioning                     = true
      requires_duplicate_detection            = true
      max_message_size_in_kilobytes           = 1024
      max_size_in_megabytes                   = 1024
      status                                  = "Active"
      support_ordering                        = true

      subscriptions = {
        testSubscription = {
          dead_lettering_on_filter_evaluation_error = true
          dead_lettering_on_message_expiration      = true
          default_message_ttl                       = "PT5M"
          enable_batched_operations                 = true
          lock_duration                             = "PT1M"
          max_delivery_count                        = 100
          status                                    = "Active"
          auto_delete_on_idle                       = "P7D"
          requires_session                          = false
          forward_dead_lettered_messages_to         = "forwardTopic"
          forward_to                                = "forwardTopic"
        }
      }

      role_assignments = {
        "key" = {
          skip_service_principal_aad_check = false
          role_definition_id_or_name       = "Contributor"
          description                      = "This is a test role assignment"
          principal_id                     = "eb5260bd-41f3-4019-9e03-606a617aec13"
        }
      }

      authorization_rules = {
        testRule = {
          send   = true
          listen = true
          manage = true
        }
      }
    }
  }
  ```
  DESCRIPTION
  nullable    = false

  validation {
    condition = alltrue([
      for _, v in var.topics :
      contains(["Active", "Creating", "Deleting", "Disabled", "ReceiveDisabled", "Renaming", "SendDisabled", "Unknown"], v.status)
    ])
    error_message = "The status parameter can only be `Active`, `Creating`, `Deleting`, `Disabled`, `ReceiveDisabled`, `Renaming`, `SendDisabled`, `Unknown`."
  }
  validation {
    condition = alltrue([
      for _, v in var.topics :
      contains([1024, 2048, 3072, 4096, 5120, 10240, 20480, 40960, 81920], v.max_size_in_megabytes)
    ])
    error_message = "The max_size_in_megabytes parameter must be one of `1024`, `2048`, `3072`, `4096`, `5120`, `10240`, `20480`, `40960`, `81920`."
  }
  validation {
    condition = alltrue(flatten([
      for topicName, topic in var.topics :
      [
        for subscriptionName, subscription in topic.subscriptions :
        1 <= subscription.max_delivery_count && 2147483647 >= subscription.max_delivery_count
      ]
    ]))
    error_message = "value of max_delivery_count of the topic subscription must be between 1 and 2147483647."
  }
  validation {
    condition = alltrue(flatten([
      for topicName, topic in var.topics :
      [
        for subscriptionName, subscription in topic.subscriptions :
        contains(["Active", "Disabled", "ReceiveDisabled"], subscription.status)
      ]
    ]))
    error_message = "value of max_delivery_count of the topic subscription must be between 1 and 2147483647."
  }
}
