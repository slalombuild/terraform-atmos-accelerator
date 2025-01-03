resource "azurerm_resource_group" "storage" {
  count = var.resource_group_name == null ? 1 : 0

  location = var.location
  name     = module.naming.resource_group.name
  tags = merge(module.this.tags,
    {
      "Component" : "storage",
      "ExpenseClass" : "storage"
    }
  )
}

resource "time_sleep" "wait_for_creation" {
  create_duration = "60s"
}

module "avm-res-storage-storageaccount" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.4.0"

  name                                = module.storage_naming.storage_account.name
  resource_group_name                 = local.resource_group_name
  location                            = var.location
  account_kind                        = var.account_kind
  account_tier                        = var.account_tier
  account_replication_type            = var.account_replication_type
  access_tier                         = var.access_tier
  allow_nested_items_to_be_public     = var.allow_nested_items_to_be_public
  allowed_copy_scope                  = var.allowed_copy_scope
  azure_files_authentication          = var.azure_files_authentication
  blob_properties                     = var.blob_properties
  containers                          = var.containers
  cross_tenant_replication_enabled    = var.cross_tenant_replication_enabled
  custom_domain                       = var.custom_domain
  customer_managed_key                = var.customer_managed_key
  default_to_oauth_authentication     = var.default_to_oauth_authentication
  diagnostic_settings_storage_account = local.diagnostic_settings_storage_account
  diagnostic_settings_blob            = local.diagnostic_settings_blob
  diagnostic_settings_file            = local.diagnostic_settings_file
  diagnostic_settings_table           = local.diagnostic_settings_table
  diagnostic_settings_queue           = local.diagnostic_settings_queue
  edge_zone                           = var.edge_zone
  infrastructure_encryption_enabled   = var.infrastructure_encryption_enabled
  is_hns_enabled                      = var.is_hns_enabled
  large_file_share_enabled            = var.large_file_share_enabled
  lock                                = var.lock
  managed_identities                  = var.managed_identities
  min_tls_version                     = var.min_tls_version
  network_rules                       = local.network_rules
  nfsv3_enabled                       = var.nfsv3_enabled
  private_endpoints                   = var.private_endpoints
  public_network_access_enabled       = var.public_network_access_enabled
  queue_encryption_key_type           = var.queue_encryption_key_type
  queue_properties                    = var.queue_properties
  queues                              = var.queues
  role_assignments                    = var.role_assignments
  routing                             = var.routing
  sas_policy                          = var.sas_policy
  sftp_enabled                        = var.sftp_enabled
  share_properties                    = var.share_properties
  shared_access_key_enabled           = var.shared_access_key_enabled
  shares                              = var.shares
  static_website                      = var.static_website
  storage_data_lake_gen2_filesystem   = var.storage_data_lake_gen2_filesystem
  storage_management_policy_rule      = var.storage_management_policy_rule
  storage_management_policy_timeouts  = var.storage_management_policy_timeouts
  table_encryption_key_type           = var.table_encryption_key_type
  tables                              = var.tables
  timeouts                            = var.timeouts

  tags = merge(module.this.tags,
    {
      "ResourceGroup" = local.resource_group_name
  })

  # This depends_on waits for the resource group to be created before the storage account
  depends_on = [time_sleep.wait_for_creation]
}

