variable "location" {
  type        = string
  description = <<DESCRIPTION
The location/region where the Front door is created. Changing this forces a new resource to be created.
DESCRIPTION
}

##################
# Custom Domains #
##################
variable "custom_domains" {
  type = list(object({
    name        = string
    host_name   = string
    dns_zone_id = optional(string)
    tls = optional(object({
      certificate_type         = optional(string, "ManagedCertificate")
      minimum_tls_version      = optional(string, "TLS12")
      cdn_frontdoor_secret_id  = optional(string)
      key_vault_certificate_id = optional(string)
    }), {})
  }))
  default     = []
  description = "CDN FrontDoor Custom Domains configurations."
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

variable "firewall_policies" {
  type = list(object({
    name                              = string
    enabled                           = optional(bool, true)
    mode                              = optional(string, "Prevention")
    redirect_url                      = optional(string)
    custom_block_response_status_code = optional(number)
    custom_block_response_body        = optional(string)
    custom_rules = optional(list(object({
      name                           = string
      action                         = string
      enabled                        = optional(bool, true)
      priority                       = number
      type                           = string
      rate_limit_duration_in_minutes = optional(number, 1)
      rate_limit_threshold           = optional(number, 10)
      match_conditions = list(object({
        match_variable   = string
        match_values     = list(string)
        operator         = string
        selector         = optional(string)
        negate_condition = optional(bool)
        transforms       = optional(list(string), [])
      }))
    })), [])
    managed_rules = optional(list(object({
      type    = string
      version = optional(string, "1.0")
      action  = string
      exclusions = optional(list(object({
        match_variable = string
        operator       = string
        selector       = string
      })), [])
      overrides = optional(list(object({
        rule_group_name = string
        exclusions = optional(list(object({
          match_variable = string
          operator       = string
          selector       = string
        })), [])
        rules = optional(list(object({
          rule_id = string
          action  = string
          enabled = optional(bool, true)
          exclusions = optional(list(object({
            match_variable = string
            operator       = string
            selector       = string
        })), []) })), [])
      })), [])
    })), [])
  }))
  default     = []
  description = "CDN Frontdoor Firewall Policies configurations."
}

variable "front_door" {
  type = object({
    sku                      = optional(string, "Standard_AzureFrontDoor"),
    response_timeout_seconds = optional(number, 120),
    fd_endpoint = optional(list(object({
      name    = string,
      enabled = optional(bool, true)
    })), [])
  })
  default     = {}
  description = "The variables required to create Azure front door"
}

variable "origin_groups" {
  type = list(object({
    name                                                      = string,
    session_affinity_enabled                                  = optional(bool, true),
    restore_traffic_time_to_healed_or_new_endpoint_in_minutes = optional(number, 10),
    health_probe = optional(object({
      interval_in_seconds = number,
      path                = optional(string, "/"),
      protocol            = string,
      request_type        = optional(string, "HEAD")
    }), null)
    load_balancing = optional(object({
      additional_latency_in_milliseconds = optional(number, 50),
      sample_size                        = optional(number, 4),
      successful_samples_required        = optional(number, 3)
    }), {})
  }))
  default     = []
  description = "CDN FrontDoor Origin Groups configurations."
}

variable "origins" {
  type = list(object({
    name                           = string,
    enabled                        = optional(bool, true),
    origin_group_name              = string,
    certificate_name_check_enabled = optional(bool, true),
    host_name                      = string,
    http_port                      = optional(number, 80),
    https_port                     = optional(number, 443),
    origin_host_header             = optional(string),
    priority                       = optional(number, 1),
    weight                         = optional(number, 1),
    private_link = optional(object({
      request_message        = optional(string),
      target_type            = optional(string),
      location               = string,
      private_link_target_id = string,
    }), null)
  }))
  default     = []
  description = "CDN FrontDoor Origins configurations."
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

variable "routes" {
  type = list(object({
    name    = string
    enabled = optional(bool, true)

    endpoint_name     = string
    origin_group_name = string
    origins_names     = list(string)

    forwarding_protocol = optional(string, "HttpsOnly")
    patterns_to_match   = optional(list(string), ["/*"])
    supported_protocols = optional(list(string), ["Http", "Https"])
    cache = optional(object({
      query_string_caching_behavior = optional(string, "IgnoreQueryString")
      query_strings                 = optional(list(string))
      compression_enabled           = optional(bool, false)
      content_types_to_compress     = optional(list(string))
    }), null)

    custom_domains_names = optional(list(string), [])
    origin_path          = optional(string, "/")
    rule_sets_names      = optional(list(string), [])

    https_redirect_enabled = optional(bool, true)
    link_to_default_domain = optional(bool, true)
  }))
  default     = []
  description = "CDN FrontDoor Routes configurations."
}

variable "rule_sets" {
  type = list(object({
    name = string
  }))
  default     = []
  description = "CDN FrontDoor Rule Sets and associated Rules configurations."
}

variable "rules" {
  type = list(object({
    name              = string
    order             = number
    behavior_on_match = optional(string, "Continue")
    rule_set_name     = string

    actions = object({
      url_rewrite_actions = optional(list(object({
        source_pattern          = optional(string)
        destination             = optional(string)
        preserve_unmatched_path = optional(bool, false)
      })), [])
      url_redirect_actions = optional(list(object({
        redirect_type        = string
        destination_hostname = string
        redirect_protocol    = optional(string, "MatchRequest")
        destination_path     = optional(string, "")
        query_string         = optional(string, "")
        destination_fragment = optional(string, "")
      })), [])
      route_configuration_override_actions = optional(list(object({
        cache_duration                  = optional(string, "1.12:00:00")
        cdn_frontdoor_origin_group_name = optional(string)
        forwarding_protocol             = optional(string, "MatchRequest")
        query_string_caching_behavior   = optional(string, "IgnoreQueryString")
        query_string_parameters         = optional(list(string))
        compression_enabled             = optional(bool, false)
        cache_behavior                  = optional(string, "HonorOrigin")
      })), [])
      request_header_actions = optional(list(object({
        header_action = string
        header_name   = string
        value         = optional(string)
      })), [])
      response_header_actions = optional(list(object({
        header_action = string
        header_name   = string
        value         = optional(string)
      })), [])
    })

    conditions = optional(object({
      remote_address_conditions = optional(list(object({
        operator         = string
        negate_condition = optional(bool, false)
        match_values     = optional(list(string))
      })), [])
      request_method_conditions = optional(list(object({
        match_values     = list(string)
        operator         = optional(string, "Equal")
        negate_condition = optional(bool, false)
      })), [])
      query_string_conditions = optional(list(object({
        operator         = string
        negate_condition = optional(bool, false)
        match_values     = optional(list(string))
        transforms       = optional(list(string), ["Lowercase"])
      })), [])
      post_args_conditions = optional(list(object({
        post_args_name   = string
        operator         = string
        negate_condition = optional(bool, false)
        match_values     = optional(list(string))
        transforms       = optional(list(string), ["Lowercase"])
      })), [])
      request_uri_conditions = optional(list(object({
        operator         = string
        negate_condition = optional(bool, false)
        match_values     = optional(list(string))
        transforms       = optional(list(string), ["Lowercase"])
      })), [])
      request_header_conditions = optional(list(object({
        header_name      = string
        operator         = string
        negate_condition = optional(bool, false)
        match_values     = optional(list(string))
        transforms       = optional(list(string), ["Lowercase"])
      })), [])
      request_body_conditions = optional(list(object({
        operator         = string
        match_values     = list(string)
        negate_condition = optional(bool, false)
        transforms       = optional(list(string), ["Lowercase"])
      })), [])
      request_scheme_conditions = optional(list(object({
        operator         = optional(string, "Equal")
        negate_condition = optional(bool, false)
        match_values     = optional(string, "HTTP")
      })), [])
      url_path_conditions = optional(list(object({
        operator         = string
        negate_condition = optional(bool, false)
        match_values     = optional(list(string))
        transforms       = optional(list(string), ["Lowercase"])
      })), [])
      url_file_extension_conditions = optional(list(object({
        operator         = string
        negate_condition = optional(bool, false)
        match_values     = list(string)
        transforms       = optional(list(string), ["Lowercase"])
      })), [])
      url_filename_conditions = optional(list(object({
        operator         = string
        match_values     = list(string)
        negate_condition = optional(bool, false)
        transforms       = optional(list(string), ["Lowercase"])
      })), [])
      http_version_conditions = optional(list(object({
        match_values     = list(string)
        operator         = optional(string, "Equal")
        negate_condition = optional(bool, false)
      })), [])
      cookies_conditions = optional(list(object({
        cookie_name      = string
        operator         = string
        negate_condition = optional(bool, false)
        match_values     = optional(list(string))
        transforms       = optional(list(string), ["Lowercase"])
      })), [])
      is_device_conditions = optional(list(object({
        operator         = optional(string, "Equal")
        negate_condition = optional(bool, false)
        match_values     = optional(list(string), ["Mobile"])
      })), [])
      socket_address_conditions = optional(list(object({
        operator         = string
        negate_condition = optional(bool, false)
        match_values     = optional(list(string))
      })), [])
      client_port_conditions = optional(list(object({
        operator         = string
        negate_condition = optional(bool, false)
        match_values     = optional(list(string))
      })), [])
      server_port_conditions = optional(list(object({
        operator         = string
        match_values     = list(string)
        negate_condition = optional(bool, false)
      })), [])
      host_name_conditions = optional(list(object({
        operator     = string
        match_values = optional(list(string))
        transforms   = optional(list(string), ["Lowercase"])
      })), [])
      ssl_protocol_conditions = optional(list(object({
        match_values     = list(string)
        operator         = optional(string, "Equal")
        negate_condition = optional(bool, false)
      })), [])
    }), null)
  }))
  default     = []
  description = "CDN FrontDoor Rule Sets and associated Rules configurations."
}

variable "security_policies" {
  type = list(object({
    name                 = string
    firewall_policy_name = string
    patterns_to_match    = optional(list(string), ["/*"])
    custom_domain_names  = optional(list(string), [])
    endpoint_names       = optional(list(string), [])
  }))
  default     = []
  description = "CDN FrontDoor Security policies configurations."

  validation {
    condition = alltrue([
      for security_policy in var.security_policies :
      security_policy.custom_domain_names != null ||
      security_policy.endpoint_names != null
    ])
    error_message = "At least one custom domain name or endpoint name must be provided for all the security policies."
  }
}

variable "suffix" {
  type        = string
  default     = null
  description = "Suffix for naming module"
}
