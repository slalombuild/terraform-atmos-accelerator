#####################
# Frontdoor routes #
#####################
resource "azurerm_cdn_frontdoor_route" "fd_route" {
  for_each = try({ for route in var.routes : route.name => route }, {})

  cdn_frontdoor_endpoint_id       = azurerm_cdn_frontdoor_endpoint.fd_endpoint[each.value.endpoint_name].id
  cdn_frontdoor_origin_group_id   = azurerm_cdn_frontdoor_origin_group.fd_origin_group[each.value.origin_group_name].id
  cdn_frontdoor_origin_ids        = local.origins_names_per_route[each.key]
  name                            = "${module.naming.frontdoor.name}-rt-${each.key}"
  patterns_to_match               = each.value.patterns_to_match
  supported_protocols             = each.value.supported_protocols
  cdn_frontdoor_custom_domain_ids = try(local.custom_domains_per_route[each.key], [])
  cdn_frontdoor_origin_path       = each.value.origin_path
  cdn_frontdoor_rule_set_ids      = try(local.rule_sets_per_route[each.key], [])
  enabled                         = each.value.enabled
  forwarding_protocol             = each.value.forwarding_protocol
  https_redirect_enabled          = each.value.https_redirect_enabled
  link_to_default_domain          = each.value.link_to_default_domain

  dynamic "cache" {
    for_each = each.value.cache == null ? [] : ["enabled"]

    content {
      compression_enabled           = each.value.cache.compression_enabled
      content_types_to_compress     = each.value.cache.content_types_to_compress
      query_string_caching_behavior = each.value.cache.query_string_caching_behavior
      query_strings                 = each.value.cache.query_strings
    }
  }

  depends_on = [
    azurerm_cdn_frontdoor_custom_domain.fd_custom_domain,
    azurerm_cdn_frontdoor_rule_set.fd_rule_set
  ]
}
