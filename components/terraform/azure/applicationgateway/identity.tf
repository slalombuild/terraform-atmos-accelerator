# Create User Assigned Managed Identity for Application Gateway
resource "azurerm_user_assigned_identity" "appgw_identity" {
  location            = var.location
  name                = var.application_gateway_managed_identity
  resource_group_name = azurerm_resource_group.appgateway[0].name
}


