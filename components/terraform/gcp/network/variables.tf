variable "project_id" {
  type        = string
  description = "The ID of the existing GCP project where the network will be created"
}

variable "region" {
  type        = string
  description = "The GCP region to create resources in project"
}

variable "routing_mode" {
  type        = string
  description = "The network routing mode (default 'GLOBAL')"
  default     = "GLOBAL"
}

variable "shared_vpc_host" {
  type        = bool
  description = "Makes this project a Shared VPC host if 'true'"
  default     = false
}

variable "vpc_description" {
  description = "An optional description of this resource. The resource must be recreated to modify this field."
  type        = string
  default     = null
}

variable "vpc_mtu" {
  description = "The network MTU (If set to 0, meaning MTU is unset - defaults to '1460'). Recommended values: 1460 (default for historic reasons), 1500 (Internet default), or 8896 (for Jumbo packets). Allowed are all values in the range 1300 to 8896, inclusively."
  type        = number
  default     = 0
}

variable "service_project_names" {
  description = "list of service projects to connect with host vpc to share the network"
  type        = list(string)
  default     = []
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range."
  default     = false
}

variable "delete_default_internet_gateway_routes" {
  type        = bool
  description = "if set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted"
  default     = true
}

variable "subnets" {
  type = list(object({
    subnet_name           = string,
    description           = optional(string, null),
    cidr                  = string,
    private_google_access = optional(bool, false),
    flow_logs = optional(object({
      aggregation_interval = optional(string, "INTERVAL_5_SEC"),
      flow_sampling        = optional(number, 0.5),
      metadata             = optional(string, "INCLUDE_ALL_METADATA")
    }), null),
    secondary_cidrs = optional(list(object({
      name = string,
      cidr = string
    })), [])
  }))
  description = "List of subnets to be created in the network. See the main module documentation for possible values."
  default     = []
}

variable "routes" {
  description = "List of custom routes to be created in the network. Leave empty if you won't need custom routes. See the main module documentation for possible values."
  type = list(object({
    name                   = string,
    description            = optional(string, null),
    destination_range      = string,
    tags                   = string,                   #This is a list in string format. Eg. "tag-01,tag-02"
    next_hop_internet      = optional(string, "true"), #Use "false" to disable this as next hop
    priority               = optional(string, "1000"),
    next_hop_ip            = optional(string, null),
    next_hop_instance      = optional(string, null),
    next_hop_instance_zone = optional(string, null),
    next_hop_vpn_tunnel    = optional(string, null),
    next_hop_ilb           = optional(string, null),
    # more variables can be added directly here
  }))
  default = []
}

variable "cloud_nat" {
  description = "Configurations for Cloud NAT. Leave empty if you won't need a NAT gateway. See the main module documentation for possible values."
  type = object({
    nat_ips                            = optional(list(string), []),
    source_subnetwork_ip_ranges_to_nat = optional(string, "LIST_OF_SUBNETWORKS")
    subnetworks = list(object({
      name                     = string,
      source_ip_ranges_to_nat  = optional(list(string), ["ALL_IP_RANGES"])
      secondary_ip_range_names = optional(list(string), []),
    })), ## must need to pass name of the subnet like {namespace}-{environment-{stage}-{subnet_name}
    enable_dynamic_port_allocation      = optional(bool, false),
    enable_endpoint_independent_mapping = optional(bool, null),
    icmp_idle_timeout_sec               = optional(string, "30"),
    log_config_enable                   = optional(bool, false),
    log_config_filter                   = optional(string, "ERRORS_ONLY"),
    min_ports_per_vm                    = optional(string, "64"),
    tcp_established_idle_timeout_sec    = optional(string, "1200"),
    tcp_transitory_idle_timeout_sec     = optional(string, "30"),
    tcp_time_wait_timeout_sec           = optional(string, "120"),
    udp_idle_timeout_sec                = optional(string, "30"),
  })
  default = null
}

variable "firewall_rules" {
  description = "value"
  type = list(object({
    name                    = string,
    description             = optional(string, null),
    direction               = string, # The input Value must be uppercase
    priority                = optional(number, 1000),
    ranges                  = list(string),
    source_tags             = optional(list(string), null),
    source_service_accounts = optional(list(string), null),
    target_tags             = optional(list(string), null),
    target_service_accounts = optional(list(string), null),
    allow = optional(list(object({
      protocol = string # The input Value must be uppercase
      ports    = optional(list(string), [])
    })), []),
    deny = optional(list(object({
      protocol = string # The input Value must be uppercase
      ports    = optional(list(string), [])
    })), []),
    log_config = optional(object({
      metadata = string
    }), null)
  }))
  default = []
}

variable "peers" {
  type = list(object({
    name      = string,
    self_link = string
  }))
  description = "List of networks to establish a peering connection with. Leave empty if you won't need peered VPC connections."
  default     = []
}

variable "private_connections" {
  type = list(object({
    name          = string,
    description   = optional(string, null),
    purpose       = optional(string, "VPC_PEERING"),
    address_type  = optional(string, "INTERNAL"),
    ip_version    = optional(string, "IPV4"),
    prefix_start  = string,
    prefix_length = optional(number, 16)
  }))
  description = "List of private connections to establish a one-to-one relationship between the VPC network and the GCP Networking API ('servicenetworking.googleapis.com'). Leave empty if you won't need private VPC connections. See the main module documentation for possible values."
  default     = []
}
