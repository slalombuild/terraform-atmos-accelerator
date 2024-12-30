variable "location" {
  type        = string
  description = <<DESCRIPTION
The location/region where the virtual network is created. Changing this forces a new resource to be created.
DESCRIPTION
}

variable "virtual_network_address_space" {
  type        = list(string)
  description = " (Required) The address space that is used the virtual network. You can supply more than one address space."
  nullable    = false

  validation {
    condition     = length(var.virtual_network_address_space) > 0
    error_message = "Please provide at least one cidr as address space."
  }
}

variable "create_network_security_group" {
  default     = false
  description = "Whether to create a NSG to asscoiate with a subnet or not"
}

variable "diagnostic_settings" {
  type = map(object({
    name                                     = optional(string, null)
    log_categories_and_groups                = optional(set(string), ["VMProtectionAlerts"])
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
  Map of diagnostic setting configurations
  DESCRIPTION
  nullable    = false

  validation {
    condition     = alltrue([for _, v in var.diagnostic_settings : contains(["Dedicated", "AzureDiagnostics"], v.log_analytics_destination_type)])
    error_message = "Log analytics destination type must be one of: 'Dedicated', 'AzureDiagnostics'."
  }
}

variable "enable_telemetry" {
  type        = bool
  default     = false
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see https://aka.ms/avm/telemetry.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
}

variable "lock" {
  type = object({
    name = optional(string, null)
    kind = optional(string, null)
  })
  default     = null
  description = <<DESCRIPTION
  (Optional) Controls the Resource Lock configuration for this resource. The following properties can be specified:

  - `kind` - (Required) The type of lock. Possible values are `\"CanNotDelete\"` and `\"ReadOnly\"`.
  - `name` - (Optional) The name of the lock. If not specified, a name will be generated based on the `kind` value. Changing this forces the creation of a new resource.
  DESCRIPTION

  validation {
    condition     = var.lock != null ? contains(["CanNotDelete", "ReadOnly"], var.lock.kind) : true
    error_message = "Lock kind must be either `\"CanNotDelete\"` or `\"ReadOnly\"`."
  }
}

variable "log_analytics_as_diagnostics_destination" {
  type        = bool
  default     = true
  description = "Log Analytics workspace as a destination to create diaganostic settings"
}

variable "network_security_groups" {
  type = list(object({
    name = string,
    security_rules = optional(list(object({
      name                                       = string,
      description                                = optional(string, null),
      access                                     = string,
      direction                                  = string,
      priority                                   = number,
      protocol                                   = string,
      source_port_range                          = optional(string, null),
      source_port_ranges                         = optional(list(string), []),
      source_address_prefix                      = optional(string, null),
      source_address_prefixes                    = optional(list(string), []),
      source_application_security_group_ids      = optional(list(string), []),
      destination_port_range                     = optional(string, null),
      destination_port_ranges                    = optional(list(string), []),
      destination_address_prefix                 = optional(string, null),
      destination_address_prefixes               = optional(list(string), []),
      destination_application_security_group_ids = optional(list(string), []),
    })), [])
  }))
  default     = []
  description = <<DESCRIPTION
  'name' - (Required) Specifies the name of the network security group. Changing this forces a new resource to be created.
  'resource_group_name' - (Required) The name of the resource group in which to create the network security group. Changing this forces a new resource to be created.
  'location' - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
  'security_rule' - (Optional) List of security_rule objects representing security rules, as defined below.
  'tags' - (Optional) A mapping of tags to assign to the resource.
  A security_rule block support:
    'name' - (Required) The name of the security rule.
    'description' - (Optional) A description for this rule. Restricted to 140 characters.
    'protocol' - (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
    'source_port_range' - (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified.
    'source_port_ranges' - (Optional) List of source ports or port ranges. This is required if source_port_range is not specified.
    'destination_port_range' - (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
    'destination_port_ranges' - (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified.
    'source_address_prefix' - (Optional) CIDR or source IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used. This is required if source_address_prefixes is not specified.
    'source_address_prefixes' - (Optional) List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified.
    'source_application_security_group_ids' - (Optional) A List of source Application Security Group IDs
    'destination_address_prefix' - (Optional) CIDR or destination IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used. This is required if destination_address_prefixes is not specified.
    'destination_address_prefixes' - (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified.
    'destination_application_security_group_ids' - (Optional) A List of destination Application Security Group IDs
    'access' - (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
    'priority' - (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
    'direction' - (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.
  DESCRIPTION
}

variable "peerings" {
  type = map(object({
    name                               = string
    remote_virtual_network_resource_id = string
    allow_forwarded_traffic            = optional(bool, false)
    allow_gateway_transit              = optional(bool, false)
    allow_virtual_network_access       = optional(bool, true)
    do_not_verify_remote_gateways      = optional(bool, false)
    enable_only_ipv6_peering           = optional(bool, false)
    peer_complete_vnets                = optional(bool, true)
    local_peered_address_spaces = optional(list(object({
      address_prefix = string
    })))
    remote_peered_address_spaces = optional(list(object({
      address_prefix = string
    })))
    local_peered_subnets = optional(list(object({
      subnet_name = string
    })))
    remote_peered_subnets = optional(list(object({
      subnet_name = string
    })))
    use_remote_gateways                   = optional(bool, false)
    create_reverse_peering                = optional(bool, false)
    reverse_name                          = optional(string)
    reverse_allow_forwarded_traffic       = optional(bool, false)
    reverse_allow_gateway_transit         = optional(bool, false)
    reverse_allow_virtual_network_access  = optional(bool, true)
    reverse_do_not_verify_remote_gateways = optional(bool, false)
    reverse_enable_only_ipv6_peering      = optional(bool, false)
    reverse_peer_complete_vnets           = optional(bool, true)
    reverse_local_peered_address_spaces = optional(list(object({
      address_prefix = string
    })))
    reverse_remote_peered_address_spaces = optional(list(object({
      address_prefix = string
    })))
    reverse_local_peered_subnets = optional(list(object({
      subnet_name = string
    })))
    reverse_remote_peered_subnets = optional(list(object({
      subnet_name = string
    })))
    reverse_use_remote_gateways = optional(bool, false)
  }))
  default     = {}
  description = <<DESCRIPTION
(Optional) A map of virtual network peering configurations. Each entry specifies a remote virtual network by ID and includes settings for traffic forwarding, gateway transit, and remote gateways usage.

- `name`: The name of the virtual network peering configuration.
- `remote_virtual_network_resource_id`: The resource ID of the remote virtual network.
- `allow_forwarded_traffic`: (Optional) Enables forwarded traffic between the virtual networks. Defaults to false.
- `allow_gateway_transit`: (Optional) Enables gateway transit for the virtual networks. Defaults to false.
- `allow_virtual_network_access`: (Optional) Enables access from the local virtual network to the remote virtual network. Defaults to true.
- `do_not_verify_remote_gateways`: (Optional) Disables the verification of remote gateways for the virtual networks. Defaults to false.
- `enable_only_ipv6_peering`: (Optional) Enables only IPv6 peering for the virtual networks. Defaults to false.
- `peer_complete_vnets`: (Optional) Enables the peering of complete virtual networks for the virtual networks. Defaults to false.
- `local_peered_address_spaces`: (Optional) The address spaces to peer with the remote virtual network. Only used when `peer_complete_vnets` is set to true.
- `remote_peered_address_spaces`: (Optional) The address spaces to peer from the remote virtual network. Only used when `peer_complete_vnets` is set to true.
- `local_peered_subnets`: (Optional) The subnets to peer with the remote virtual network. Only used when `peer_complete_vnets` is set to true.
- `remote_peered_subnets`: (Optional) The subnets to peer from the remote virtual network. Only used when `peer_complete_vnets` is set to true.
- `use_remote_gateways`: (Optional) Enables the use of remote gateways for the virtual networks. Defaults to false.
- `create_reverse_peering`: (Optional) Creates the reverse peering to form a complete peering.
- `reverse_name`: (Optional) If you have selected `create_reverse_peering`, then this name will be used for the reverse peer.
- `reverse_allow_forwarded_traffic`: (Optional) If you have selected `create_reverse_peering`, enables forwarded traffic between the virtual networks. Defaults to false.
- `reverse_allow_gateway_transit`: (Optional) If you have selected `create_reverse_peering`, enables gateway transit for the virtual networks. Defaults to false.
- `reverse_allow_virtual_network_access`: (Optional) If you have selected `create_reverse_peering`, enables access from the local virtual network to the remote virtual network. Defaults to true.
- `reverse_do_not_verify_remote_gateways`: (Optional) If you have selected `create_reverse_peering`, disables the verification of remote gateways for the virtual networks. Defaults to false.
- `reverse_enable_only_ipv6_peering`: (Optional) If you have selected `create_reverse_peering`, enables only IPv6 peering for the virtual networks. Defaults to false.
- `reverse_peer_complete_vnets`: (Optional) If you have selected `create_reverse_peering`, enables the peering of complete virtual networks for the virtual networks. Defaults to false.
- `reverse_local_peered_address_spaces`: (Optional) If you have selected `create_reverse_peering`, the address spaces to peer with the remote virtual network. Only used when `reverse_peer_complete_vnets` is set to true.
- `reverse_remote_peered_address_spaces`: (Optional) If you have selected `create_reverse_peering`, the address spaces to peer from the remote virtual network. Only used when `reverse_peer_complete_vnets` is set to true.
- `reverse_local_peered_subnets`: (Optional) If you have selected `create_reverse_peering`, the subnets to peer with the remote virtual network. Only used when `reverse_peer_complete_vnets` is set to true.
- `reverse_remote_peered_subnets`: (Optional) If you have selected `create_reverse_peering`, the subnets to peer from the remote virtual network. Only used when `reverse_peer_complete_vnets` is set to true.
- `reverse_use_remote_gateways`: (Optional) If you have selected `create_reverse_peering`, enables the use of remote gateways for the virtual networks. Defaults to false.

DESCRIPTION
  nullable    = false
}

variable "resource_group_name" {
  type        = string
  default     = null
  description = <<DESCRIPTION
The name of the resource group resources should be created within.
If no resource group name is specified, the component will create a new one.
DESCRIPTION
}

variable "role_assignments" {
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
  Map of configurations required to configure RBAC
  DESCRIPTION
}

variable "storage_account_as_diagnostics_destination" {
  type        = bool
  default     = false
  description = "storage account as a destination to create diaganostic settings"
}

variable "subnets" {
  type = map(object(
    {
      address_prefixes = list(string) # (Required) The address prefixes to use for the subnet.
      nat_gateway = optional(object({
        id = string # (Required) The ID of the NAT Gateway which should be associated with the Subnet. Changing this forces a new resource to be created.
      }))
      network_security_group_name                   = optional(string, null) # (Optional) Name of the Network Security Group to associate with Subnet. should enable create_network_security_group = true.
      private_endpoint_network_policies_enabled     = optional(bool, true)   # (Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to `true` will **Enable** the policy and setting this to `false` will **Disable** the policy. Defaults to `true`.
      private_link_service_network_policies_enabled = optional(bool, true)   # (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to `true` will **Enable** the policy and setting this to `false` will **Disable** the policy. Defaults to `true`.
      route_table = optional(object({
        id = string # (Required) The ID of the Route Table which should be associated with the Subnet. Changing this forces a new association to be created.
      }))
      service_endpoints           = optional(set(string)) # (Optional) The list of Service endpoints to associate with the subnet. Possible values include: `Microsoft.AzureActiveDirectory`, `Microsoft.AzureCosmosDB`, `Microsoft.ContainerRegistry`, `Microsoft.EventHub`, `Microsoft.KeyVault`, `Microsoft.ServiceBus`, `Microsoft.Sql`, `Microsoft.Storage` and `Microsoft.Web`.
      service_endpoint_policy_ids = optional(set(string)) # (Optional) The list of IDs of Service Endpoint Policies to associate with the subnet.
      delegation = optional(list(
        object(
          {
            name = string # (Required) A name for this delegation.
            service_delegation = object({
              name    = string                 # (Required) The name of service to delegate to. Possible values include `Microsoft.ApiManagement/service`, `Microsoft.AzureCosmosDB/clusters`, `Microsoft.BareMetal/AzureVMware`, `Microsoft.BareMetal/CrayServers`, `Microsoft.Batch/batchAccounts`, `Microsoft.ContainerInstance/containerGroups`, `Microsoft.ContainerService/managedClusters`, `Microsoft.Databricks/workspaces`, `Microsoft.DBforMySQL/flexibleServers`, `Microsoft.DBforMySQL/serversv2`, `Microsoft.DBforPostgreSQL/flexibleServers`, `Microsoft.DBforPostgreSQL/serversv2`, `Microsoft.DBforPostgreSQL/singleServers`, `Microsoft.HardwareSecurityModules/dedicatedHSMs`, `Microsoft.Kusto/clusters`, `Microsoft.Logic/integrationServiceEnvironments`, `Microsoft.MachineLearningServices/workspaces`, `Microsoft.Netapp/volumes`, `Microsoft.Network/managedResolvers`, `Microsoft.Orbital/orbitalGateways`, `Microsoft.PowerPlatform/vnetaccesslinks`, `Microsoft.ServiceFabricMesh/networks`, `Microsoft.Sql/managedInstances`, `Microsoft.Sql/servers`, `Microsoft.StoragePool/diskPools`, `Microsoft.StreamAnalytics/streamingJobs`, `Microsoft.Synapse/workspaces`, `Microsoft.Web/hostingEnvironments`, `Microsoft.Web/serverFarms`, `NGINX.NGINXPLUS/nginxDeployments` and `PaloAltoNetworks.Cloudngfw/firewalls`.
              actions = optional(list(string)) # (Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include `Microsoft.Network/networkinterfaces/*`, `Microsoft.Network/virtualNetworks/subnets/action`, `Microsoft.Network/virtualNetworks/subnets/join/action`, `Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action` and `Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action`.
            })
          }
        )
      ))
    }
  ))
  default     = {} # Set the default value to an empty map
  description = <<DESCRIPTION
The subnets to create
DESCRIPTION
}

variable "suffix" {
  type        = string
  default     = null
  description = "Suffix for naming module"
}

variable "tracing_tags_enabled" {
  type        = bool
  default     = false
  description = <<DESCRIPTION
Whether enable tracing tags that generated by BridgeCrew Yor.
DESCRIPTION
  nullable    = false
}

variable "tracing_tags_prefix" {
  type        = string
  default     = "avm_"
  description = <<DESCRIPTION
Default prefix for generated tracing tags.
DESCRIPTION
  nullable    = false
}

variable "virtual_network_ddos_protection_plan" {
  type = object({
    id     = string #  (Required) The ID of DDoS Protection Plan.
    enable = bool   # (Required) Enable/disable DDoS Protection Plan on Virtual Network.
  })
  default     = null
  description = "AzureNetwork DDoS Protection Plan."
}

variable "virtual_network_dns_servers" {
  type = object({
    dns_servers = list(string)
  })
  default     = null
  description = "(Optional) List of IP addresses of DNS servers"
}
