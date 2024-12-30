resource "azurerm_resource_group" "vnet" {
  count = var.resource_group_name == null ? 1 : 0

  location = var.location
  name     = module.naming.resource_group.name
  tags = merge(module.this.tags,
    {
      Component    = "vnet"
      ExpenseClass = "network"
    }
  )
}

resource "azurerm_network_security_group" "nsg" {
  for_each = var.create_network_security_group ? { for nsg in var.network_security_groups : nsg.name => nsg } : {}

  location            = var.location
  name                = replace(module.naming.network_security_group.name, module.this.name, each.key)
  resource_group_name = data.azurerm_resource_group.vnet.name
  security_rule       = each.value.security_rules
  tags = merge(
    module.this.tags,
    {
      ResourceGroupName = data.azurerm_resource_group.vnet.name
    }
  )
}

module "azure_vnet" {
  source               = "github.com/azure/terraform-azurerm-avm-res-network-virtualnetwork?ref=v0.7.1"
  name                 = module.naming.virtual_network.name
  location             = var.location
  resource_group_name  = data.azurerm_resource_group.vnet.name
  address_space        = var.virtual_network_address_space
  diagnostic_settings  = local.diagnostic_settings
  enable_telemetry     = var.enable_telemetry
  lock                 = var.lock
  role_assignments     = var.role_assignments
  subnets              = local.subnets
  tags                 = merge(module.this.tags, { ResourceGroupName = data.azurerm_resource_group.vnet.name })
  ddos_protection_plan = var.virtual_network_ddos_protection_plan
  dns_servers          = var.virtual_network_dns_servers
  peerings             = var.peerings
}

