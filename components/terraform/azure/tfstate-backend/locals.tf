locals {
  resource_group = {
    name     = var.resource_group_name == null ? module.naming.resource_group.name : var.resource_group_name
    location = var.location
  }

  public_ip = var.key_vault_firewall_bypass_ip_cidr == null ? replace(data.http.public_ip[0].response_body, "\n", "") : var.key_vault_firewall_bypass_ip_cidr
}

