resource "azurerm_api_management_subscription" "sub" {
  for_each = var.create_apim_subscription_keys ? { for sub, _ in var.apim_subscriptions : sub => _ } : {}

  api_management_name = azurerm_api_management.apim.name
  display_name        = each.value.display_name
  resource_group_name = data.azurerm_resource_group.apim_rg.name
  allow_tracing       = each.value.allow_tracing
  api_id              = each.value.assign_to_api ? azurerm_api_management_api.api[each.value.api_name].id : null
  primary_key         = each.value.primary_key
  product_id          = each.value.assign_to_product ? azurerm_api_management_product.product[each.value.product_id].id : null
  secondary_key       = each.value.secondary_key
  state               = each.value.state
  subscription_id     = each.value.subscription_id
  user_id             = each.value.assign_to_user ? azurerm_api_management_user.user[each.value.user_first_name].id : null
}
