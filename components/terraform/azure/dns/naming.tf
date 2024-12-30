module "naming" {
  version = "0.4.2"
  source  = "Azure/naming/azurerm"
  prefix  = [module.this.namespace, module.this.environment, module.this.name]
}

module "domain_naming" {
  for_each = { for domain in var.dns_zones : domain.domain_name => domain }
  version  = "0.4.2"
  source   = "Azure/naming/azurerm"
  prefix   = [module.this.namespace, module.this.environment, each.value.domain_name]
}
