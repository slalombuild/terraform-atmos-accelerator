variable "access_tier" {
  type        = string
  default     = "Hot"
  description = "(Optional) Defines the access tier for `BlobStorage`, `FileStorage` and `StorageV2` accounts. Valid options are `Hot` and `Cool`, defaults to `Hot`."

  validation {
    condition     = contains(["Hot", "Cool"], var.access_tier)
    error_message = "Invalid value for access tier. Valid options are 'Hot' or 'Cool'."
  }
}

variable "account_kind" {
  type        = string
  default     = "StorageV2"
  description = "(Optional) Defines the Kind of account. Valid options are `BlobStorage`, `BlockBlobStorage`, `FileStorage`, `Storage` and `StorageV2`. Defaults to `StorageV2`."

  validation {
    condition     = contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2"], var.account_kind)
    error_message = "Invalid value for account kind. Valid options are `BlobStorage`, `BlockBlobStorage`, `FileStorage`, `Storage` and `StorageV2`. Defaults to `StorageV2`."
  }
}

variable "account_replication_type" {
  type        = string
  description = "(Required) Defines the type of replication to use for this storage account. Valid options are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`.  Defaults to `ZRS`"
  nullable    = false
  default     = "ZRS"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.account_replication_type)
    error_message = "Invalid value for replication type. Valid options are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`."
  }
}

variable "account_tier" {
  type        = string
  description = "(Required) Defines the Tier to use for this storage account. Valid options are `Standard` and `Premium`. For `BlockBlobStorage` and `FileStorage` accounts only `Premium` is valid. Changing this forces a new resource to be created."
  default     = "Standard"
  nullable    = false

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Invalid value for account tier. Valid options are `Standard` and `Premium`. For `BlockBlobStorage` and `FileStorage` accounts only `Premium` is valid. Changing this forces a new resource to be created."
  }
}

variable "allow_nested_items_to_be_public" {
  type        = bool
  default     = false
  description = "(Optional) Allow or disallow nested items within this Account to opt into being public. Defaults to `false`."
}

variable "allowed_copy_scope" {
  type        = string
  default     = null
  description = "(Optional) Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are `AAD` and `PrivateLink`."
}

variable "cross_tenant_replication_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should cross Tenant replication be enabled? Defaults to `false`."
}

variable "custom_domain" {
  type = object({
    name          = string
    use_subdomain = optional(bool)
  })
  default     = null
  description = <<-EOT
 - `name` - (Required) The Custom Domain Name to use for the Storage Account, which will be validated by Azure.
 - `use_subdomain` - (Optional) Should the Custom Domain Name be validated by using indirect CNAME validation?
EOT
}

variable "default_to_oauth_authentication" {
  type        = bool
  default     = null
  description = "(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is `false`"
}

variable "edge_zone" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created."
}

variable "https_traffic_only_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Boolean flag which forces HTTPS if enabled, see [here](https://docs.microsoft.com/azure/storage/storage-require-secure-transfer/) for more information. Defaults to `true`."
}

variable "infrastructure_encryption_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to `false`."
}

variable "local_user" {
  type = map(object({
    home_directory       = optional(string)
    name                 = string
    ssh_key_enabled      = optional(bool)
    ssh_password_enabled = optional(bool)
    permission_scope = optional(list(object({
      resource_name = string
      service       = string
      permissions = object({
        create = optional(bool)
        delete = optional(bool)
        list   = optional(bool)
        read   = optional(bool)
        write  = optional(bool)
      })
    })))
    ssh_authorized_key = optional(list(object({
      description = optional(string)
      key         = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  default     = {}
  description = <<-EOT
 - `home_directory` - (Optional) The home directory of the Storage Account Local User.
 - `name` - (Required) The name which should be used for this Storage Account Local User. Changing this forces a new Storage Account Local User to be created.
 - `ssh_key_enabled` - (Optional) Specifies whether SSH Key Authentication is enabled. Defaults to `false`.
 - `ssh_password_enabled` - (Optional) Specifies whether SSH Password Authentication is enabled. Defaults to `false`.

 ---
 `permission_scope` block supports the following:
 - `resource_name` - (Required) The container name (when `service` is set to `blob`) or the file share name (when `service` is set to `file`), used by the Storage Account Local User.
 - `service` - (Required) The storage service used by this Storage Account Local User. Possible values are `blob` and `file`.

 ---
 `permissions` block supports the following:
 - `create` - (Optional) Specifies if the Local User has the create permission for this scope. Defaults to `false`.
 - `delete` - (Optional) Specifies if the Local User has the delete permission for this scope. Defaults to `false`.
 - `list` - (Optional) Specifies if the Local User has the list permission for this scope. Defaults to `false`.
 - `read` - (Optional) Specifies if the Local User has the read permission for this scope. Defaults to `false`.
 - `write` - (Optional) Specifies if the Local User has the write permission for this scope. Defaults to `false`.

 ---
 `ssh_authorized_key` block supports the following:
 - `description` - (Optional) The description of this SSH authorized key.
 - `key` - (Required) The public key value of this SSH authorized key.

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 30 minutes) Used when creating the Storage Account Local User.
 - `delete` - (Defaults to 30 minutes) Used when deleting the Storage Account Local User.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Storage Account Local User.
 - `update` - (Defaults to 30 minutes) Used when updating the Storage Account Local User.
EOT
  nullable    = false
}

variable "min_tls_version" {
  type        = string
  default     = "TLS1_2"
  description = "(Optional) The minimum supported TLS version for the storage account. Possible values are `TLS1_0`, `TLS1_1`, and `TLS1_2`. Defaults to `TLS1_2` for new storage accounts."
}

variable "network_rules" {
  type = object({
    bypass         = optional(set(string), ["AzureServices"])
    default_action = optional(string, "Deny")
    ip_rules       = optional(set(string), [])
    virtual_network_subnets = optional(list(object({
      subnet_name = string
      vnet_name   = string
    })), [])
    private_link_access = optional(list(object({
      endpoint_resource_id = string
      endpoint_tenant_id   = optional(string)
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  })
  default = {}

  description = <<-EOT
 > Note the default value for this variable will block all public access to the storage account. If you want to disable all network rules, set this value to `null`.

 - `bypass` - (Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of `Logging`, `Metrics`, `AzureServices`, or `None`.
 - `default_action` - (Required) Specifies the default action of allow or deny when no other rules match. Valid options are `Deny` or `Allow`.
 - `ip_rules` - (Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in [RFC 1918](https://tools.ietf.org/html/rfc1918#section-3)) are not allowed.
 - `storage_account_id` - (Required) Specifies the ID of the storage account. Changing this forces a new resource to be created.
 - `virtual_network_subnet_ids` - (Optional) A list of virtual network subnet ids to secure the storage account.

 ---
 `private_link_access` block supports the following:
 - `endpoint_resource_id` - (Required) The resource id of the resource access rule to be granted access.
 - `endpoint_tenant_id` - (Optional) The tenant id of the resource of the resource access rule to be granted access. Defaults to the current tenant id.

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 60 minutes) Used when creating the  Network Rules for this Storage Account.
 - `delete` - (Defaults to 60 minutes) Used when deleting the Network Rules for this Storage Account.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Network Rules for this Storage Account.
 - `update` - (Defaults to 60 minutes) Used when updating the Network Rules for this Storage Account.
EOT
}

variable "nfsv3_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Is NFSv3 protocol enabled? Changing this forces a new resource to be created. Defaults to `false`."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Whether the public network access is enabled? Defaults to `true`."
}

variable "routing" {
  type = object({
    choice                      = optional(string, "MicrosoftRouting")
    publish_internet_endpoints  = optional(bool, false)
    publish_microsoft_endpoints = optional(bool, false)
  })
  default     = null
  description = <<-EOT
 - `choice` - (Optional) Specifies the kind of network routing opted by the user. Possible values are `InternetRouting` and `MicrosoftRouting`. Defaults to `MicrosoftRouting`.
 - `publish_internet_endpoints` - (Optional) Should internet routing storage endpoints be published? Defaults to `false`.
 - `publish_microsoft_endpoints` - (Optional) Should Microsoft routing storage endpoints be published? Defaults to `false`.
EOT
}

variable "sas_policy" {
  type = object({
    expiration_action = optional(string, "Log")
    expiration_period = string
  })
  default     = null
  description = <<-EOT
 - `expiration_action` - (Optional) The SAS expiration action. The only possible value is `Log` at this moment. Defaults to `Log`.
 - `expiration_period` - (Required) The SAS expiration period in format of `DD.HH:MM:SS`.
EOT
}

variable "sftp_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Boolean, enable SFTP for the storage account.  Defaults to `false`."
}

variable "shared_access_key_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is `false`."
}

variable "static_website" {
  type = object({
    error_404_document = optional(string)
    index_document     = optional(string)
  })
  default     = null
  description = <<-EOT
 - `error_404_document` - (Optional) The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.
 - `index_document` - (Optional) The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive.
EOT
}

variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  default     = null
  description = <<-EOT
 - `create` - (Defaults to 60 minutes) Used when creating the Storage Account.
 - `delete` - (Defaults to 60 minutes) Used when deleting the Storage Account.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Storage Account.
 - `update` - (Defaults to 60 minutes) Used when updating the Storage Account.
EOT
}
