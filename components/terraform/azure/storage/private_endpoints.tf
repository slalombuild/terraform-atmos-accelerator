
# resource "azurerm_private_endpoint" "this" {
#   for_each = var.private_endpoints

#   location                      = each.value.location != null ? each.value.location : local.location
#   name                          = each.value.name != null ? each.value.name : "pe-${var.name}"
#   resource_group_name           = each.value.resource_group_name != null ? each.value.resource_group_name : local.resource_group_name
#   subnet_id                     = each.value.subnet_resource_id
#   custom_network_interface_name = each.value.network_interface_name
#   tags                          = each.value.inherit_tags ? merge(each.value.tags, var.tags) : each.value.tags

#   private_service_connection {
#     is_manual_connection           = false
#     name                           = each.value.private_service_connection_name != null ? each.value.private_service_connection_name : "pse-${var.name}"
#     private_connection_resource_id = azurerm_storage_account.this.id
#     subresource_names              = each.value.subresource_name
#   }
#   dynamic "ip_configuration" {
#     for_each = each.value.ip_configurations

#     content {
#       name               = ip_configuration.value.name
#       private_ip_address = ip_configuration.value.private_ip_address
#       member_name        = each.value.subresource_name
#       subresource_name   = each.value.subresource_name
#     }
#   }
#   dynamic "private_dns_zone_group" {
#     for_each = length(each.value.private_dns_zone_resource_ids) > 0 ? ["this"] : []

#     content {
#       name                 = each.value.private_dns_zone_group_name
#       private_dns_zone_ids = each.value.private_dns_zone_resource_ids
#     }
#   }
# }

# resource "azurerm_private_endpoint_application_security_group_association" "this" {
#   for_each = local.private_endpoint_application_security_group_associations

#   application_security_group_id = each.value.asg_resource_id
#   private_endpoint_id           = azurerm_private_endpoint.this[each.value.pe_key].id
# }

# resource "azurerm_role_assignment" "private_endpoint" {
#   for_each = local.pe_role_assignments

#   principal_id                           = each.value.role_assignment.principal_id
#   scope                                  = azurerm_private_endpoint.this[each.value.private_endpoint_key].id
#   condition                              = each.value.role_assignment.condition
#   condition_version                      = each.value.role_assignment.condition_version
#   delegated_managed_identity_resource_id = each.value.role_assignment.delegated_managed_identity_resource_id
#   role_definition_id                     = strcontains(lower(each.value.role_assignment.role_definition_id_or_name), lower(local.role_definition_resource_substring)) ? each.value.role_assignment.role_definition_id_or_name : null
#   role_definition_name                   = strcontains(lower(each.value.role_assignment.role_definition_id_or_name), lower(local.role_definition_resource_substring)) ? null : each.value.role_assignment.role_definition_id_or_name
#   skip_service_principal_aad_check       = each.value.role_assignment.skip_service_principal_aad_check
# }
