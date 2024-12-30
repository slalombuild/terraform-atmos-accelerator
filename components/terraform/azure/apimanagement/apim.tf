##################
# Resource Group #
##################

resource "azurerm_resource_group" "apim_rg" {
  count = var.resource_group_name == null ? 1 : 0

  location = var.location
  name     = module.naming.resource_group.name
  tags = merge(
    module.this.tags,
    {
      "Component"    = "apim"
      "ExpenseClass" = "network"
    }
  )
}

########
# Apim #
########

resource "azurerm_api_management" "apim" {
  location                      = var.location
  name                          = replace(replace(module.naming.api_management.name, module.this.environment, "-${module.this.environment}-"), module.this.name, "${module.this.name}-")
  publisher_email               = var.publisher_email
  publisher_name                = var.publisher_name
  resource_group_name           = data.azurerm_resource_group.apim_rg.name
  sku_name                      = "${var.sku_tier}_${var.sku_capacity}"
  client_certificate_enabled    = var.client_certificate_enabled
  gateway_disabled              = var.gateway_disabled
  min_api_version               = var.min_api_version
  notification_sender_email     = var.notification_sender_email
  public_ip_address_id          = var.public_ip_address_id
  public_network_access_enabled = var.public_network_access_enabled
  tags = merge(
    module.this.tags,
    {
      Resource_Group = data.azurerm_resource_group.apim_rg.name
    }
  )
  virtual_network_type = var.virtual_network_type
  zones                = var.sku_tier == "Premium" ? var.zones : null

  dynamic "additional_location" {
    for_each = var.additional_location

    content {
      location             = additional_location.value.location
      capacity             = additional_location.value.capacity
      public_ip_address_id = additional_location.value.public_ip_address_id
      zones                = additional_location.value.zones

      dynamic "virtual_network_configuration" {
        for_each = additional_location.value.subnet_id[*]

        content {
          subnet_id = additional_location.value.subnet_id
        }
      }
    }
  }
  dynamic "certificate" {
    for_each = var.certificate_configuration

    content {
      encoded_certificate  = certificate.value.encoded_certificate
      store_name           = certificate.value.store_name
      certificate_password = certificate.value.certificate_password
    }
  }
  dynamic "delegation" {
    for_each = var.delegation != null ? [var.delegation] : []

    content {
      subscriptions_enabled     = each.value.subscriptions_enabled
      url                       = each.value.url
      user_registration_enabled = each.value.user_registration_enabled
      validation_key            = each.value.validation_key
    }
  }
  dynamic "hostname_configuration" {
    for_each = length(concat(
      var.management_hostname_configuration,
      var.portal_hostname_configuration,
      var.developer_portal_hostname_configuration,
      var.proxy_hostname_configuration,
    )) == 0 ? [] : ["enabled"]

    content {
      dynamic "developer_portal" {
        for_each = var.developer_portal_hostname_configuration

        content {
          host_name                    = developer_portal.value.host_name
          certificate                  = developer_portal.value.certificate
          certificate_password         = developer_portal.value.certificate_password
          key_vault_id                 = developer_portal.value.key_vault_id
          negotiate_client_certificate = developer_portal.value.negotiate_client_certificate
        }
      }
      dynamic "management" {
        for_each = var.management_hostname_configuration

        content {
          host_name                    = management.value.host_name
          certificate                  = management.value.certificate
          certificate_password         = management.value.certificate_password
          key_vault_id                 = management.value.key_vault_id
          negotiate_client_certificate = management.value.negotiate_client_certificate
        }
      }
      dynamic "portal" {
        for_each = var.portal_hostname_configuration

        content {
          host_name                    = portal.value.host_name
          certificate                  = portal.value.certificate
          certificate_password         = portal.value.certificate_password
          key_vault_id                 = portal.value.key_vault_id
          negotiate_client_certificate = portal.value.negotiate_client_certificate
        }
      }
      dynamic "proxy" {
        for_each = var.proxy_hostname_configuration

        content {
          host_name                    = proxy.value.host_name
          certificate                  = proxy.value.certificate
          certificate_password         = proxy.value.certificate_password
          default_ssl_binding          = proxy.value.default_ssl_binding
          key_vault_id                 = proxy.value.key_vault_id
          negotiate_client_certificate = proxy.value.negotiate_client_certificate
        }
      }
      dynamic "scm" {
        for_each = var.scm_hostname_configuration

        content {
          host_name                    = scm.value.host_name
          certificate                  = scm.value.certificate
          certificate_password         = scm.value.certificate_password
          key_vault_id                 = scm.value.key_vault_id
          negotiate_client_certificate = scm.value.negotiate_client_certificate
        }
      }
    }
  }
  dynamic "identity" {
    for_each = var.identity_type != null ? ["enabled"] : []

    content {
      type         = var.identity_type
      identity_ids = endswith(var.identity_type, "UserAssigned") ? var.identity_ids : null
    }
  }
  protocols {
    enable_http2 = var.enable_http2
  }
  dynamic "security" {
    for_each = var.security_configuration[*]

    content {
      enable_backend_ssl30                                = security.value.enable_backend_ssl30
      enable_backend_tls10                                = security.value.enable_backend_tls10
      enable_backend_tls11                                = security.value.enable_backend_tls11
      enable_frontend_ssl30                               = security.value.enable_frontend_ssl30
      enable_frontend_tls10                               = security.value.enable_frontend_tls10
      enable_frontend_tls11                               = security.value.enable_frontend_tls11
      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = security.value.tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = security.value.tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = security.value.tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = security.value.tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = security.value.tls_rsa_with_aes128_cbc_sha256_ciphers_enabled
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = security.value.tls_rsa_with_aes128_cbc_sha_ciphers_enabled
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = security.value.tls_rsa_with_aes128_gcm_sha256_ciphers_enabled
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = security.value.tls_rsa_with_aes256_cbc_sha256_ciphers_enabled
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = security.value.tls_rsa_with_aes256_cbc_sha_ciphers_enabled
      triple_des_ciphers_enabled                          = security.value.triple_des_ciphers_enabled
    }
  }
  dynamic "sign_in" {
    for_each = var.sign_in_enabled ? [var.sign_in_enabled] : []

    content {
      enabled = var.sign_in_enabled
    }
  }
  dynamic "sign_up" {
    for_each = var.sign_up_enabled ? [var.sign_up_enabled] : []

    content {
      enabled = var.sign_up_enabled

      dynamic "terms_of_service" {
        for_each = var.terms_of_service_configuration

        content {
          consent_required = terms_of_service.value.consent_required
          enabled          = terms_of_service.value.enabled
          text             = terms_of_service.value.text
        }
      }
    }
  }
  tenant_access {
    enabled = var.tenant_access_enabled
  }
  timeouts {
    create = "2h"
    delete = "2h"
    update = "2h"
  }
  dynamic "virtual_network_configuration" {
    for_each = toset(local.virtual_network_configuration)

    content {
      subnet_id = virtual_network_configuration.value
    }
  }

  lifecycle {
    precondition {
      condition     = var.sku_tier != "Premium" || (var.sku_tier == "Premium" && anytrue([for l in var.additional_location : l.zones != null || l.public_ip_address_id != null]))
      error_message = "Zones and custom public IPs are only supported in the Premium SKU tier."
    }
  }
}
