data "azurerm_client_config" "current" {}

data "http" "public_ip" {
  count = var.key_vault_firewall_bypass_ip_cidr == null ? 1 : 0

  url = "http://ipv4.icanhazip.com"
}
