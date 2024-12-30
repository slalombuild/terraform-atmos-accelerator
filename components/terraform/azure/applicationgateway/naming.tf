module "naming" {
  version = "0.4.2"
  source  = "Azure/naming/azurerm"
  prefix  = [module.this.namespace, module.this.environment, module.this.name]
}


module "vnet_naming" {
  count   = var.subnet_name != null && var.vnet_name != null ? 1 : 0
  version = "0.4.2"
  source  = "Azure/naming/azurerm"
  prefix  = [module.this.namespace, module.this.environment, var.vnet_name]
}



module "kv_naming" {
  version = "0.4.2"
  source  = "Azure/naming/azurerm"
  prefix  = [module.this.namespace, module.this.environment, var.kv_naming_prefix_tail]
}
