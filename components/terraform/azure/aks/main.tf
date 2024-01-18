module "naming" {
  version = "0.4.0"
  source  = "Azure/naming/azurerm"
  suffix  = [var.component_suffix]
}

resource "azurerm_resource_group" "main" {
  count = var.create_resource_group ? 1 : 0

  location = local.resource_group.location
  name     = local.resource_group.name
  tags     = var.default_tags
}

resource "azurerm_user_assigned_identity" "aks" {
  location            = local.resource_group.location
  name                = module.naming.user_assigned_identity.name_unique
  resource_group_name = local.resource_group.name
  depends_on = [
    azurerm_resource_group.main
  ]
}

module "aks_cluster_name" {
  source  = "Azure/aks/azurerm"
  version = "7.5.0"

  prefix                               = "aks"
  resource_group_name                  = local.resource_group.name
  admin_username                       = null
  azure_policy_enabled                 = true
  cluster_log_analytics_workspace_name = module.naming.log_analytics_workspace.name_unique
  cluster_name                         = module.this.id # module.naming.kubernetes_cluster.name_unique
  disk_encryption_set_id               = azurerm_disk_encryption_set.des.id
  public_network_access_enabled        = false
  identity_ids                         = [azurerm_user_assigned_identity.aks.id]
  identity_type                        = "UserAssigned"
  log_analytics_solution = {
    id = azurerm_log_analytics_solution.main.id
  }
  log_analytics_workspace_enabled = true
  log_analytics_workspace = {
    id   = azurerm_log_analytics_workspace.main.id
    name = azurerm_log_analytics_workspace.main.name
  }
  maintenance_window = {
    allowed = [
      {
        day   = "Sunday",
        hours = [22, 23]
      },
    ]
    not_allowed = []
  }
  net_profile_pod_cidr              = "10.1.0.0/16"
  private_cluster_enabled           = true
  rbac_aad                          = true
  rbac_aad_managed                  = true
  role_based_access_control_enabled = true

  attached_acr_id_map = { example = azurerm_container_registry.container_registry.id }

  # KMS etcd encryption
  kms_enabled                  = true
  kms_key_vault_key_id         = azurerm_key_vault_key.kms.id
  kms_key_vault_network_access = "Private"

  tags = module.this.tags # var.default_tags

  depends_on = [
    azurerm_key_vault_access_policy.kms,
    azurerm_role_assignment.kms
  ]
}
