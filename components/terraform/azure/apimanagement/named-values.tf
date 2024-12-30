resource "azurerm_api_management_named_value" "named_values" {
  for_each = { for named_value in var.named_values : named_value.name => named_value }

  api_management_name = azurerm_api_management.apim.name
  display_name        = "${azurerm_api_management.apim.name}-${each.key}"
  name                = "${azurerm_api_management.apim.name}-${each.key}"
  resource_group_name = data.azurerm_resource_group.apim_rg.name
  secret              = each.value.secret
  value               = each.value.value
}
