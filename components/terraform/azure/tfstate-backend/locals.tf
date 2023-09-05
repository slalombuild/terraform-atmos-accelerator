locals {
  resource_group = {
    name     = var.resource_group_name == null ? module.naming.resource_group.name : var.resource_group_name
    location = var.location
  }
}

