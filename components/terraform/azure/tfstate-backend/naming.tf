module "naming" {
  version = "0.4.0"
  source  = "Azure/naming/azurerm"
  suffix  = ["tfstatebackend"]
}
