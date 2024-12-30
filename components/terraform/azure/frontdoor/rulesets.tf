resource "azurerm_cdn_frontdoor_rule_set" "fd_rule_set" {
  for_each = try({ for rule_set in var.rule_sets : rule_set.name => rule_set }, {})

  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile.id
  name                     = replace("${module.naming.frontdoor.name}-rs-${each.key}", "-", "")
}

resource "azurerm_cdn_frontdoor_rule" "fd_rules" {
  for_each = try({ for rule in var.rules : rule.name => rule }, {})

  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.fd_rule_set[each.value.rule_set_name].id
  name                      = replace("${module.naming.frontdoor.name}-${each.key}", "-", "")
  order                     = each.value.order
  behavior_on_match         = each.value.behavior_on_match

  actions {
    dynamic "request_header_action" {
      for_each = each.value.actions.request_header_actions
      iterator = action

      content {
        header_action = action.value.header_action
        header_name   = action.value.header_name
        value         = action.value.value
      }
    }
    dynamic "response_header_action" {
      for_each = each.value.actions.response_header_actions
      iterator = action

      content {
        header_action = action.value.header_action
        header_name   = action.value.header_name
        value         = action.value.value
      }
    }
    dynamic "route_configuration_override_action" {
      for_each = each.value.actions.route_configuration_override_actions
      iterator = action

      content {
        cache_behavior                = action.value.cache_behavior
        cache_duration                = action.value.cache_duration
        cdn_frontdoor_origin_group_id = try(azurerm_cdn_frontdoor_origin_group.fd_origin_group[action.value.cdn_frontdoor_origin_group_name].id, null)
        compression_enabled           = action.value.compression_enabled
        forwarding_protocol           = action.value.forwarding_protocol
        query_string_caching_behavior = action.value.query_string_caching_behavior
        query_string_parameters       = action.value.query_string_parameters
      }
    }
    dynamic "url_redirect_action" {
      for_each = each.value.actions.url_redirect_actions
      iterator = action

      content {
        destination_hostname = action.value.destination_hostname
        redirect_type        = action.value.redirect_type
        destination_fragment = action.value.destination_fragment
        destination_path     = action.value.destination_path
        query_string         = action.value.query_string
        redirect_protocol    = action.value.redirect_protocol
      }
    }
    dynamic "url_rewrite_action" {
      for_each = each.value.actions.url_rewrite_actions
      iterator = action

      content {
        destination             = action.value.destination
        source_pattern          = action.value.source_pattern
        preserve_unmatched_path = action.value.preserve_unmatched_path
      }
    }
  }
  dynamic "conditions" {
    for_each = each.value.conditions[*]

    content {
      dynamic "client_port_condition" {
        for_each = each.value.conditions.client_port_conditions
        iterator = condition

        content {
          operator         = condition.value.operator
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
        }
      }
      dynamic "cookies_condition" {
        for_each = each.value.conditions.cookies_conditions
        iterator = condition

        content {
          cookie_name      = condition.value.cookie_name
          operator         = condition.value.operator
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
          transforms       = condition.value.transforms
        }
      }
      dynamic "host_name_condition" {
        for_each = each.value.conditions.host_name_conditions
        iterator = condition

        content {
          operator     = condition.value.operator
          match_values = condition.value.match_values
          transforms   = condition.value.transforms
        }
      }
      dynamic "http_version_condition" {
        for_each = each.value.conditions.http_version_conditions
        iterator = condition

        content {
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
          operator         = condition.value.operator
        }
      }
      dynamic "is_device_condition" {
        for_each = each.value.conditions.is_device_conditions
        iterator = condition

        content {
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
          operator         = condition.value.operator
        }
      }
      dynamic "post_args_condition" {
        for_each = each.value.conditions.post_args_conditions
        iterator = condition

        content {
          operator         = condition.value.operator
          post_args_name   = condition.value.post_args_name
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
          transforms       = condition.value.transforms
        }
      }
      dynamic "query_string_condition" {
        for_each = each.value.conditions.query_string_conditions
        iterator = condition

        content {
          operator         = condition.value.operator
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
          transforms       = condition.value.transforms
        }
      }
      dynamic "remote_address_condition" {
        for_each = each.value.conditions.remote_address_conditions
        iterator = condition

        content {
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
          operator         = condition.value.operator
        }
      }
      dynamic "request_body_condition" {
        for_each = each.value.conditions.request_body_conditions
        iterator = condition

        content {
          match_values     = condition.value.match_values
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
          transforms       = condition.value.transforms
        }
      }
      dynamic "request_header_condition" {
        for_each = each.value.conditions.request_header_conditions
        iterator = condition

        content {
          header_name      = condition.value.header_name
          operator         = condition.value.operator
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
          transforms       = condition.value.transforms
        }
      }
      dynamic "request_method_condition" {
        for_each = each.value.conditions.request_method_conditions
        iterator = condition

        content {
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
          operator         = condition.value.operator
        }
      }
      dynamic "request_scheme_condition" {
        for_each = each.value.conditions.request_scheme_conditions
        iterator = condition

        content {
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
          operator         = condition.value.operator
        }
      }
      dynamic "request_uri_condition" {
        for_each = each.value.conditions.request_uri_conditions
        iterator = condition

        content {
          operator         = condition.value.operator
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
          transforms       = condition.value.transforms
        }
      }
      dynamic "server_port_condition" {
        for_each = each.value.conditions.server_port_conditions
        iterator = condition

        content {
          match_values     = condition.value.match_values
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
        }
      }
      dynamic "socket_address_condition" {
        for_each = each.value.conditions.socket_address_conditions
        iterator = condition

        content {
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
          operator         = condition.value.operator
        }
      }
      dynamic "ssl_protocol_condition" {
        for_each = each.value.conditions.ssl_protocol_conditions
        iterator = condition

        content {
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
          operator         = condition.value.operator
        }
      }
      dynamic "url_file_extension_condition" {
        for_each = each.value.conditions.url_file_extension_conditions
        iterator = condition

        content {
          match_values     = condition.value.match_values
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
          transforms       = condition.value.transforms
        }
      }
      dynamic "url_filename_condition" {
        for_each = each.value.conditions.url_filename_conditions
        iterator = condition

        content {
          operator         = condition.value.operator
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
          transforms       = condition.value.transforms
        }
      }
      dynamic "url_path_condition" {
        for_each = each.value.conditions.url_path_conditions
        iterator = condition

        content {
          operator         = condition.value.operator
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
          transforms       = condition.value.transforms
        }
      }
    }
  }

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.fd_origin_group,
    azurerm_cdn_frontdoor_origin.fd_origin,
  ]
}
