module "naming" {
  version = "0.4.1"
  source  = "Azure/naming/azurerm"
  suffix  = ["tfstatebackend"]
}
