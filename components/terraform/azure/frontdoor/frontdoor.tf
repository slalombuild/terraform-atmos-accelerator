##################
# Resource Group #
##################

resource "azurerm_resource_group" "fd_rg" {
  count = var.resource_group_name == null ? 1 : 0

  location = var.location
  name     = module.naming.resource_group.name
  tags = merge(
    module.this.tags,
    {
      "Component"    = "frontdoor"
      "ExpenseClass" = "network"
    }
  )
}

#####################
# Frontdoor Profile #
#####################

resource "azurerm_cdn_frontdoor_profile" "fd_profile" {
  name                     = module.naming.frontdoor.name
  resource_group_name      = data.azurerm_resource_group.fd_rg.name
  sku_name                 = var.front_door.sku
  response_timeout_seconds = var.front_door.response_timeout_seconds
  tags = merge(
    module.this.tags,
    {
      ResourceGroup = data.azurerm_resource_group.fd_rg.name
    }
  )
}

######################
# Frontdoor Endpoint #
######################

resource "azurerm_cdn_frontdoor_endpoint" "fd_endpoint" {
  for_each = try({ for endpoint in var.front_door.fd_endpoint : endpoint.name => endpoint }, {})

  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile.id
  name                     = "${module.naming.frontdoor.name}-ep-${each.key}"
  enabled                  = each.value.enabled
  tags = merge(
    module.this.tags,
    {
      ResourceGroup = data.azurerm_resource_group.fd_rg.name
    }
  )
}

######################################
# Frontdoor origin group and origins #
######################################

resource "azurerm_cdn_frontdoor_origin_group" "fd_origin_group" {
  for_each = try({ for origin_group in var.origin_groups : origin_group.name => origin_group }, {})

  cdn_frontdoor_profile_id                                  = azurerm_cdn_frontdoor_profile.fd_profile.id
  name                                                      = "${module.naming.frontdoor.name}-og-${each.key}"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = each.value.restore_traffic_time_to_healed_or_new_endpoint_in_minutes
  session_affinity_enabled                                  = each.value.session_affinity_enabled

  load_balancing {
    additional_latency_in_milliseconds = each.value.load_balancing.additional_latency_in_milliseconds
    sample_size                        = each.value.load_balancing.sample_size
    successful_samples_required        = each.value.load_balancing.successful_samples_required
  }
  dynamic "health_probe" {
    for_each = each.value.health_probe == null ? [] : ["enabled"]

    content {
      interval_in_seconds = each.value.health_probe.interval_in_seconds
      protocol            = each.value.health_probe.protocol
      path                = each.value.health_probe.path
      request_type        = each.value.health_probe.request_type
    }
  }
}

resource "azurerm_cdn_frontdoor_origin" "fd_origin" {
  for_each = try({ for origin in var.origins : origin.name => origin }, {})

  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.fd_origin_group[each.value.origin_group_name].id
  certificate_name_check_enabled = each.value.certificate_name_check_enabled
  host_name                      = each.value.host_name
  name                           = "${module.naming.frontdoor.name}-${each.key}"
  enabled                        = each.value.enabled
  http_port                      = each.value.http_port
  https_port                     = each.value.https_port
  origin_host_header             = each.value.origin_host_header
  priority                       = each.value.priority
  weight                         = each.value.weight

  dynamic "private_link" {
    for_each = each.value.private_link == null ? [] : ["enabled"]

    content {
      location               = each.value.private_link.location
      private_link_target_id = each.value.private_link.private_link_target_id
      request_message        = each.value.private_link.request_message
      target_type            = each.value.private_link.target_type
    }
  }
}

###########################
# Frontdoor custom Domain #
###########################

resource "azurerm_cdn_frontdoor_custom_domain" "fd_custom_domain" {
  for_each = try({ for custom_domain in var.custom_domains : custom_domain.name => custom_domain }, {})

  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile.id
  host_name                = each.value.host_name
  name                     = "${module.naming.frontdoor.name}-cd-${each.key}"
  dns_zone_id              = each.value.dns_zone_id

  dynamic "tls" {
    for_each = each.value.tls == null ? [] : ["enabled"]

    content {
      cdn_frontdoor_secret_id = each.value.tls.cdn_frontdoor_secret_id
      certificate_type        = each.value.tls.certificate_type
      minimum_tls_version     = each.value.tls.minimum_tls_version
    }
  }
}
