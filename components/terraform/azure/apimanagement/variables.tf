variable "location" {
  type        = string
  description = "The location/region where the appInsights resource is created. Changing this forces a new resource to be created."
}

variable "publisher_email" {
  type        = string
  description = "The email of publisher/company."
}

########
# Apim #
########
variable "publisher_name" {
  type        = string
  description = "The name of publisher/company."
}

variable "additional_location" {
  type = list(object({
    location             = string
    capacity             = optional(number)
    zones                = optional(list(number), [1, 2, 3])
    public_ip_address_id = optional(string)
    subnet_id            = optional(string)
  }))
  default     = []
  description = "List of the Azure Region in which the API Management Service should be expanded to."
  nullable    = false
}

variable "api" {
  type = list(object({
    name      = string,
    revision  = optional(number, "1"),
    api_type  = optional(string, "http"),
    path      = optional(string),
    protocols = optional(list(string), ["http", "https"]),
    contact = optional(object({
      email = optional(string),
      name  = optional(string),
      url   = optional(string)
    }))
    description = optional(string),
    import = optional(object({
      content_format = optional(string),
      content_value  = optional(string),
      wsdl_selector = optional(object({
        service_name  = optional(string),
        endpoint_name = optional(string)
      }))
    })),
    license = optional(object({
      name = optional(string),
      url  = optional(string)
    })),
    oauth2_authorization = optional(object({
      authorization_server_name = string,
      scope                     = optional(string)
    })),
    openid_authentication = optional(object({
      openid_provider_name         = string,
      bearer_token_sending_methods = optional(string)
    })),
    service_url       = optional(string),
    soap_pass_through = optional(bool),
    subscription_key_parameter_names = optional(object({
      header = string,
      query  = string,
    })),
    subscription_required = optional(bool, true),
    terms_of_service_url  = optional(string),
    version               = optional(string),
    version_set_id        = optional(string),
    revision_description  = optional(string),
    version_description   = optional(string),
    source_api_id         = optional(string)
  }))
  default     = []
  description = "Manages an API within an API Management Service."
}

variable "api_management_policy" {
  type = list(object({
    name        = optional(string, "default")
    api_name    = string
    xml_content = optional(string)
    xml_link    = optional(string)
  }))
  default     = []
  description = "Api Policies configurations."
  nullable    = false
}

variable "api_operation" {
  type = list(object({
    operation_id = string,
    api_name     = string,
    method       = string,
    url_template = string,
    description  = optional(string),
    request = optional(object({
      description = optional(string)
      headers = optional(list(object({
        name          = string,
        required      = bool,
        type          = string,
        description   = optional(string),
        default_value = optional(string),
        values        = optional(list(string), []),
        schema_id     = optional(string),
        type_name     = optional(string),
        examples = optional(list(object({
          name           = string,
          summary        = optional(string),
          description    = optional(string),
          value          = optional(string),
          external_value = optional(string)
        })), [])
      })), [])
      query_parameters = optional(list(object({
        name          = string,
        required      = bool,
        type          = string,
        description   = optional(string),
        default_value = optional(string),
        values        = optional(list(string), []),
        schema_id     = optional(string),
        type_name     = optional(string),
        examples = optional(list(object({
          name           = string,
          summary        = optional(string),
          description    = optional(string),
          value          = optional(string),
          external_value = optional(string)
        })), [])
      })), [])
      representations = optional(list(object({
        content_type = string,
        form_parameters = optional(list(object({
          name          = string,
          required      = bool,
          type          = string,
          description   = optional(string),
          default_value = optional(string),
          values        = optional(list(string), []),
          schema_id     = optional(string),
          type_name     = optional(string),
          examples = optional(list(object({
            name           = string,
            summary        = optional(string),
            description    = optional(string),
            value          = optional(string),
            external_value = optional(string)
          })), [])
        })), [])
        examples = optional(list(object({
          name           = string,
          summary        = optional(string),
          description    = optional(string),
          value          = optional(string),
          external_value = optional(string)
        })), [])
        schema_id = optional(string),
        type_name = optional(string)
      })), [])
    }))
    response = optional(list(object({
      status_code = number,
      description = optional(string),
      headers = optional(list(object({
        name          = string,
        required      = bool,
        type          = string,
        description   = optional(string),
        default_value = optional(string),
        values        = optional(list(string), []),
        schema_id     = optional(string),
        type_name     = optional(string),
        examples = optional(list(object({
          name           = string,
          summary        = optional(string),
          description    = optional(string),
          value          = optional(string),
          external_value = optional(string)
        })), [])
      })), [])
      representations = optional(list(object({
        content_type = string,
        form_parameters = optional(list(object({
          name          = string,
          required      = bool,
          type          = string,
          description   = optional(string),
          default_value = optional(string),
          values        = optional(list(string), []),
          schema_id     = optional(string),
          type_name     = optional(string),
          examples = optional(list(object({
            name           = string,
            summary        = optional(string),
            description    = optional(string),
            value          = optional(string),
            external_value = optional(string)
          })), [])
        })), [])
        examples = optional(list(object({
          name           = string,
          summary        = optional(string),
          description    = optional(string),
          value          = optional(string),
          external_value = optional(string)
        })), [])
        schema_id = optional(string),
        type_name = optional(string)
      })), [])
    })), [])
    template_parameters = optional(list(object({
      name          = string,
      required      = bool,
      type          = string,
      description   = optional(string),
      default_value = optional(string),
      values        = optional(list(string), []),
      schema_id     = optional(string),
      type_name     = optional(string),
      examples = optional(list(object({
        name           = string,
        summary        = optional(string),
        description    = optional(string),
        value          = optional(string),
        external_value = optional(string)
      })), [])
    })), [])
  }))
  default     = []
  description = "Manages an API Management API Operation."
}

variable "api_operation_policy" {
  type = list(object({
    api_name     = string,
    operation_id = string,
    xml_content  = optional(string),
    xml_link     = optional(string)
  }))
  default     = []
  description = "Manages an API Management API Operation Policy"
}

variable "apim_backend" {
  type = list(object({
    name        = string,
    protocol    = string,
    backend_url = string,
    credentials = optional(object({
      authorization = optional(object({
        parameter = optional(string),
        scheme    = optional(string),
      }))
      certificate = optional(list(string), []),
      header      = optional(map(string)),
      query       = optional(map(string))
    }))
    description = optional(string),
    proxy = optional(object({
      password = optional(string),
      url      = optional(string),
      username = optional(string)
    }))
    resource_id = optional(string),
    service_fabric_cluster = optional(object({
      client_certificate_thumbprint    = optional(string),
      client_certificate_id            = optional(string),
      management_endpoints             = list(string),
      max_partition_resolution_retries = number,
      server_certificate_thumbprints   = optional(string),
      server_x509_name = optional(object({
        issuer_certificate_thumbprint = string,
        name                          = string
      }))
      title = optional(string),
      tls = optional(object({
        validate_certificate_chain = optional(string),
        validate_certificate_name  = optional(string)
      }))
    })),
  }))
  default     = []
  description = ""
}

variable "apim_management_policy" {
  type = list(object({
    name        = optional(string, "default")
    xml_content = optional(string)
    xml_link    = optional(string)
  }))
  default     = []
  description = "Apim Policies configurations."
  nullable    = false
}

variable "apim_subscriptions" {
  type = list(object({
    display_name      = optional(string, "default"),
    assign_to_user    = optional(bool, false),
    user_first_name   = optional(string),
    assign_to_product = optional(bool, false),
    product_id        = optional(string),
    assign_to_api     = optional(bool, false),
    api_name          = optional(string),
    primary_key       = optional(string),
    secondary_key     = optional(string),
    state             = optional(string, "submitted")
    subscription_id   = optional(string)
    allow_tracing     = optional(bool, true)
  }))
  default     = []
  description = <<DESCRIPTION
  Manages a Subscription within a API Management Service.
  * Only one of product_id and api_id can be set. If both are missing all_apis scope is used for the subscription.
  DESCRIPTION
}

variable "certificate_configuration" {
  type = list(object({
    encoded_certificate  = string
    certificate_password = optional(string)
    store_name           = string
  }))
  default     = []
  description = "List of certificate configurations."
  nullable    = false

  validation {
    condition     = alltrue([for cert in var.certificate_configuration : contains(["Root", "CertificateAuthority"], cert.store_name)])
    error_message = "Possible values are `CertificateAuthority` and `Root` for 'store_name' attribute."
  }
}

variable "client_certificate_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is `Consumption`."
}

variable "create_apim_subscription_keys" {
  type        = bool
  default     = false
  description = "Whether to create a Management Subscription Keys or not"
}

###########################
# Management Network rule #
###########################
variable "create_management_rule" {
  type        = bool
  default     = false
  description = "Whether to create the NSG rule for the management port of the APIM. If true, nsg_name variable must be set"
}

variable "create_product_group_and_relationships" {
  type        = bool
  default     = false
  description = "Create local APIM groups with name identical to products and create a relationship between groups and products."
}

variable "create_user_and_group_relationships" {
  type        = bool
  default     = false
  description = "Create local APIM users and create a relationship between groups and users."
}

variable "delegation" {
  type = object({
    subscriptions_enabled     = optional(bool, false),
    user_registration_enabled = optional(bool, false),
    url                       = optional(string),
    validation_key            = optional(string),
  })
  default     = null
  description = "Delegation of Apim"
}

variable "destination_port_range" {
  type        = string
  default     = "3443"
  description = "The Range of Destination port to allow"
}

variable "developer_portal_hostname_configuration" {
  type = list(object({
    host_name                    = string
    key_vault_id                 = optional(string)
    certificate                  = optional(string)
    certificate_password         = optional(string)
    negotiate_client_certificate = optional(bool, false)
  }))
  default     = []
  description = "Developer Portal hostname configurations."
  nullable    = false
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

variable "enable_http2" {
  type        = bool
  default     = false
  description = "Should HTTP/2 be supported by the API Management Service?"
}

variable "gateway_disabled" {
  type        = bool
  default     = false
  description = "(Optional) Disable the gateway in main region? This is only supported when `additional_location` is set."
}

variable "identity_ids" {
  type        = list(string)
  default     = []
  description = "A list of IDs for User Assigned Managed Identity resources to be assigned. This is required when type is set to `UserAssigned` or `SystemAssigned, UserAssigned`."
}

variable "identity_type" {
  type        = string
  default     = "SystemAssigned"
  description = "Type of Managed Service Identity that should be configured on this API Management Service."
}

variable "management_group" {
  type = list(object({
    name        = string,
    description = optional(string),
    external_id = optional(string),
    type        = optional(string, "custom")
  }))
  default     = []
  description = "List of groups to create."
}

variable "management_hostname_configuration" {
  type = list(object({
    host_name                    = string
    key_vault_id                 = optional(string)
    certificate                  = optional(string)
    certificate_password         = optional(string)
    negotiate_client_certificate = optional(bool, false)
  }))
  default     = []
  description = "List of management hostname configurations."
  nullable    = false
}

variable "management_nsg_rule_priority" {
  type        = number
  default     = 101
  description = "Priority of the NSG rule created for the management port of the APIM"
}

variable "management_product" {
  type = list(object({
    product_id            = string,
    subscription_required = optional(bool, false)
    approval_required     = optional(bool, false)
    published             = optional(bool, false)
    subscriptions_limit   = optional(string, "1")
    terms                 = optional(string)
  }))
  default     = []
  description = "List of Products to create"
}

variable "management_user" {
  type = list(object({
    user_id      = string,
    first_name   = string,
    last_name    = string,
    email        = string,
    state        = optional(string),
    confirmation = optional(string),
    note         = optional(string),
    password     = optional(string),
  }))
  default     = []
  description = "Manages an API Management User."
}

variable "min_api_version" {
  type        = string
  default     = null
  description = "(Optional) The version which the control plane API calls to API Management service are limited with version equal to or newer than."
}

variable "named_values" {
  type = list(object({
    name         = string
    display_name = optional(string)
    value        = string
    secret       = optional(bool, false)
  }))
  default     = []
  description = "Named values configurations."
  nullable    = false
}

variable "notification_sender_email" {
  type        = string
  default     = null
  description = "Email address from which the notification will be sent."
}

variable "nsg_name" {
  type        = string
  default     = null
  description = "NSG name of the subnet hosting the APIM to add the rule to allow management if the APIM is private"
}

variable "nsg_rg_name" {
  type        = string
  default     = null
  description = "Name of the RG hosting the NSG if it's different from the one hosting the APIM"
}

variable "portal_hostname_configuration" {
  type = list(object({
    host_name                    = string
    key_vault_id                 = optional(string)
    certificate                  = optional(string)
    certificate_password         = optional(string)
    negotiate_client_certificate = optional(bool, false)
  }))
  default     = []
  description = "Legacy Portal hostname configurations."
  nullable    = false
}

variable "product_group" {
  type = list(object({
    product_id = string,
    group_name = string
  }))
  default     = []
  description = "Binding the Products and Groups"
}

variable "proxy_hostname_configuration" {
  type = list(object({
    host_name                    = string
    key_vault_id                 = optional(string)
    certificate                  = optional(string)
    certificate_password         = optional(string)
    negotiate_client_certificate = optional(bool, false)
  }))
  default     = []
  description = "List of proxy hostname configurations."
  nullable    = false
}

variable "public_ip_address_id" {
  type        = string
  default     = null
  description = " ID of a standard SKU IPv4 Public IP"
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Is public access to the service allowed? "
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

variable "scm_hostname_configuration" {
  type = list(object({
    host_name                    = string
    key_vault_id                 = optional(string)
    certificate                  = optional(string)
    certificate_password         = optional(string)
    negotiate_client_certificate = optional(bool, false)
  }))
  default     = []
  description = "List of SCM hostname configurations."
  nullable    = false
}

variable "security_configuration" {
  type = object({
    enable_backend_ssl30  = optional(bool, false)
    enable_backend_tls10  = optional(bool, false)
    enable_backend_tls11  = optional(bool, false)
    enable_frontend_ssl30 = optional(bool, false)
    enable_frontend_tls10 = optional(bool, false)
    enable_frontend_tls11 = optional(bool, false)

    tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = optional(bool, false)
    tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = optional(bool, false)
    tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = optional(bool, false)
    tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = optional(bool, false)
    tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = optional(bool, false)
    tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = optional(bool, false)
    tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = optional(bool, false)
    tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = optional(bool, false)
    tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = optional(bool, false)

    triple_des_ciphers_enabled = optional(bool, false)
  })
  default     = {}
  description = "Security configuration block."
}

variable "sign_in_enabled" {
  type        = bool
  default     = false
  description = "Should anonymous users be redirected to the sign in page?"
}

variable "sign_up_enabled" {
  type        = bool
  default     = false
  description = "Can users sign up on the development portal?"
}

variable "sku_capacity" {
  type        = number
  default     = 1
  description = <<DESCRIPTION
  APIM SKU capacity. which must be a positive integer.
  Premium SKU's are limited to a default maximum of 12 (i.e. Premium_12), this can, however, be increased via support request.
  Consumption SKU capacity should be 0 (e.g. Consumption_0) as this tier includes automatic scaling.
  DESCRIPTION
}

variable "sku_tier" {
  type        = string
  default     = "Basic"
  description = "APIM SKU. Valid values include: Developer, Basic, Standard, StandardV2 and Premium."

  validation {
    condition     = contains(["Developer", "Basic", "Standard", "Premium"], var.sku_tier)
    error_message = "Invalid SKU tier. Valid values include: Developer, Basic, Standard and Premium."
  }
}

variable "source_port_range" {
  type        = string
  default     = "*"
  description = "The Range of source port to allow"
}

variable "suffix" {
  type        = string
  default     = null
  description = "Suffix for naming module"
}

variable "tenant_access_enabled" {
  type        = bool
  default     = false
  description = "Should the access to the management API be enabled?"
}

variable "terms_of_service_configuration" {
  type = list(object({
    consent_required = optional(bool, false)
    enabled          = optional(bool, false)
    text             = optional(string, "")
  }))
  default     = []
  description = "Terms of service configurations."
  nullable    = false
}

variable "user_group" {
  type = list(object({
    user_first_name = string,
    group_name      = string
  }))
  default     = []
  description = "Manages an API Management User Assignment to a Group."
}

variable "virtual_network_configuration" {
  type = list(object({
    vnet_name   = string
    subnet_name = string
  }))
  default     = []
  description = "The id(s) of the subnet(s) that will be used for the API Management. Required when virtual_network_type is External or Internal"
}

variable "virtual_network_type" {
  type        = string
  default     = null
  description = "The type of virtual network you want to use, valid values include: None, External, Internal."
}

variable "zones" {
  type        = list(number)
  default     = [1, 2, 3]
  description = "(Optional) Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created. Supported in Premium Tier."
}
