resource "azurerm_network_security_rule" "management_apim" {
  count = var.create_management_rule ? 1 : 0

  access                      = "Allow"
  direction                   = "Inbound"
  name                        = "${azurerm_api_management.apim.name}-network-rule"
  network_security_group_name = var.nsg_name
  priority                    = var.management_nsg_rule_priority
  protocol                    = "Tcp"
  resource_group_name         = var.nsg_rg_name
  destination_address_prefix  = "VirtualNetwork"
  destination_port_range      = var.destination_port_range
  source_address_prefix       = "ApiManagement"
  source_port_range           = var.source_port_range
}
