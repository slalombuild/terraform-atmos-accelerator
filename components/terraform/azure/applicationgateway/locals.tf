locals {
  resource_group_name = var.resource_group_name != null ? var.resource_group_name : module.naming.resource_group.name
}
