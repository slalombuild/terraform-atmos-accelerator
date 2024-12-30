resource "azurerm_cdn_frontdoor_firewall_policy" "fd_firewall_policy" {
  for_each = try({ for firewall_policy in var.firewall_policies : firewall_policy.name => firewall_policy }, {})

  mode                              = each.value.mode
  name                              = replace("${module.naming.frontdoor.name}-fp-${each.key}", "-", "")
  resource_group_name               = data.azurerm_resource_group.fd_rg.name
  sku_name                          = azurerm_cdn_frontdoor_profile.fd_profile.sku_name
  custom_block_response_body        = each.value.custom_block_response_body
  custom_block_response_status_code = each.value.custom_block_response_status_code
  enabled                           = each.value.enabled
  redirect_url                      = each.value.redirect_url
  tags = merge(
    module.this.tags,
    {
      ResourceGroup = data.azurerm_resource_group.fd_rg.name
    }
  )

  dynamic "custom_rule" {
    for_each = try(each.value.custom_rules, {})

    content {
      action                         = custom_rule.value.action
      name                           = custom_rule.value.name
      type                           = custom_rule.value.type
      enabled                        = custom_rule.value.enabled
      priority                       = custom_rule.value.priority
      rate_limit_duration_in_minutes = custom_rule.value.rate_limit_duration_in_minutes
      rate_limit_threshold           = custom_rule.value.rate_limit_threshold

      dynamic "match_condition" {
        for_each = try(custom_rule.value.match_conditions, {})

        content {
          match_values       = match_condition.value.match_values
          match_variable     = match_condition.value.match_variable
          operator           = match_condition.value.operator
          negation_condition = match_condition.value.negate_condition
          selector           = match_condition.value.selector
          transforms         = match_condition.value.transforms
        }
      }
    }
  }
  dynamic "managed_rule" {
    for_each = azurerm_cdn_frontdoor_profile.fd_profile.sku_name == "Premium_AzureFrontDoor" ? try(each.value.managed_rules, {}) : []

    content {
      action  = managed_rule.value.action
      type    = managed_rule.value.type
      version = managed_rule.value.version

      dynamic "exclusion" {
        for_each = try(managed_rule.value.exclusions, {})

        content {
          match_variable = exclusion.value.match_variable
          operator       = exclusion.value.operator
          selector       = exclusion.value.selector
        }
      }
      dynamic "override" {
        for_each = try(managed_rule.value.overrides, {})

        content {
          rule_group_name = override.value.rule_group_name

          dynamic "exclusion" {
            for_each = try(override.value.exclusions, {})

            content {
              match_variable = exclusion.value.match_variable
              operator       = exclusion.value.operator
              selector       = exclusion.value.selector
            }
          }
          dynamic "rule" {
            for_each = try(override.value.rules, {})

            content {
              action  = rule.value.action
              rule_id = rule.value.rule_id
              enabled = rule.value.enabled

              dynamic "exclusion" {
                for_each = try(rule.value.exclusions, {})

                content {
                  match_variable = exclusion.value.match_variable
                  operator       = exclusion.value.operator
                  selector       = exclusion.value.selector
                }
              }
            }
          }
        }
      }
    }
  }
}

resource "azurerm_cdn_frontdoor_security_policy" "cdn_frontdoor_security_policy" {
  for_each = try({ for security_policy in var.security_policies : security_policy.name => security_policy }, {})

  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile.id
  name                     = "${module.naming.frontdoor.name}-sp-${each.key}"

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = azurerm_cdn_frontdoor_firewall_policy.fd_firewall_policy[each.value.firewall_policy_name].id

      association {
        patterns_to_match = each.value.patterns_to_match

        dynamic "domain" {
          for_each = try(each.value.custom_domain_names, [])

          content {
            cdn_frontdoor_domain_id = azurerm_cdn_frontdoor_custom_domain.fd_custom_domain[domain.value].id
          }
        }
        dynamic "domain" {
          for_each = try(each.value.endpoint_names, [])

          content {
            cdn_frontdoor_domain_id = azurerm_cdn_frontdoor_endpoint.fd_endpoint[domain.value].id
          }
        }
      }
    }
  }
}
