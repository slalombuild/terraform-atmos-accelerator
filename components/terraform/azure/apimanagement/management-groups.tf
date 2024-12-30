resource "azurerm_api_management_group" "group" {
  for_each = var.create_product_group_and_relationships ? { for group in var.management_group : group.name => group } : {}

  api_management_name = azurerm_api_management.apim.name
  display_name        = "${azurerm_api_management.apim.name}-${each.key}"
  name                = "${azurerm_api_management.apim.name}-${each.key}"
  resource_group_name = data.azurerm_resource_group.apim_rg.name
  description         = each.value.description
  external_id         = each.value.external_id
  type                = each.value.type
}

resource "azurerm_api_management_product" "product" {
  for_each = var.create_product_group_and_relationships ? { for product in var.management_product : product.product_id => product } : {}

  api_management_name   = azurerm_api_management.apim.name
  display_name          = "${azurerm_api_management.apim.name}-${each.key}"
  product_id            = "${azurerm_api_management.apim.name}-${each.key}"
  published             = each.value.published
  resource_group_name   = data.azurerm_resource_group.apim_rg.name
  approval_required     = each.value.approval_required
  subscription_required = each.value.subscription_required
  subscriptions_limit   = each.value.subscription_required ? each.value.subscriptions_limit : null
  terms                 = each.value.terms
}

resource "azurerm_api_management_product_group" "product_group" {
  for_each = var.create_product_group_and_relationships ? { for product, _ in var.product_group : product => _ } : {}

  api_management_name = azurerm_api_management.apim.name
  group_name          = azurerm_api_management_group.group[each.value.group_name].name
  product_id          = azurerm_api_management_product.product[each.value.product_id].product_id
  resource_group_name = data.azurerm_resource_group.apim_rg.name
}

resource "azurerm_api_management_user" "user" {
  for_each = var.create_user_and_group_relationships ? { for user in var.management_user : user.first_name => user } : {}

  api_management_name = azurerm_api_management.apim.name
  email               = each.value.email
  first_name          = each.value.first_name
  last_name           = each.value.last_name
  resource_group_name = data.azurerm_resource_group.apim_rg.name
  user_id             = each.value.user_id
  confirmation        = each.value.confirmation
  note                = each.value.note
  password            = each.value.password
  state               = each.value.state
}

resource "azurerm_api_management_group_user" "group" {
  for_each = var.create_user_and_group_relationships ? { for group, _ in var.user_group : group => _ } : {}

  api_management_name = azurerm_api_management.apim.name
  group_name          = azurerm_api_management_group.group[each.value.group_name].name
  resource_group_name = data.azurerm_resource_group.apim_rg.name
  user_id             = azurerm_api_management_user.user[each.value.user_first_name].user_id
}
