output "nsg_resource_id" {
  description = "The resource ids of Nsg's"
  value       = [for i in azurerm_network_security_group.nsg : { id = i.id }]
}

output "resource" {
  description = "The Azure Virtual Network resource.  This will be null if an existing vnet is supplied."
  value       = module.azure_vnet.resource
}

output "subnet_names" {
  description = "The names of the subnet"
  value = [for subnet in module.azure_vnet.subnets : {
    name = subnet.resource.name
    id   = subnet.resource_id
  }]
}

output "subnets" {
  description = <<DESCRIPTION
Information about the subnets created in the module.

Please refer to the subnet module documentation for details of the outputs.
DESCRIPTION
  value       = module.azure_vnet.subnets
}

output "vnet_name" {
  description = "The resource name of the virtual network."
  value       = module.azure_vnet.name
}

output "vnet_peerings" {
  description = <<DESCRIPTION
Information about the peerings created in the module.

Please refer to the peering module documentation for details of the outputs
DESCRIPTION
  value       = module.azure_vnet.peerings
}

output "vnet_resource_id" {
  description = "The resource ID of the virtual network."
  value       = module.azure_vnet.resource_id
}

output "vnet_rg_name" {
  description = "The Vnet resource group name"
  value       = data.azurerm_resource_group.vnet.name
}
