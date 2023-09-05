module "naming" {
  version = "0.3.0"
  source  = "Azure/naming/azurerm"
  suffix  = ["tfstatebackend"]
}
