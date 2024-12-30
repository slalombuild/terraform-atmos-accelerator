########
# Apim #
########
resource "azurerm_api_management_policy" "policy" {
  for_each = { for policy in var.apim_management_policy : policy.name => policy }

  api_management_id = azurerm_api_management.apim.id
  xml_content       = each.value.xml_content
  xml_link          = each.value.xml_link
}

#######
# API #
#######
resource "azurerm_api_management_api_policy" "policy" {
  for_each = { for policy in var.api_management_policy : policy.name => policy }

  api_management_name = azurerm_api_management.apim.name
  api_name            = azurerm_api_management_api.api[each.value.api_name].name
  resource_group_name = data.azurerm_resource_group.apim_rg.name
  xml_content         = each.value.xml_content
  xml_link            = each.value.xml_link
}
