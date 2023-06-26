## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.39 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.39 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_naming"></a> [naming](#module\_naming) | Azure/naming/azurerm | 0.3.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.admin_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.readers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_role_assignment.rbac_keyvault_administrator](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.rbac_keyvault_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.rbac_keyvault_secrets_users](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_objects_ids"></a> [admin\_objects\_ids](#input\_admin\_objects\_ids) | IDs of the objects that can do all operations on all keys, secrets and certificates. | `list(string)` | `[]` | no |
| <a name="input_enabled_for_deployment"></a> [enabled\_for\_deployment](#input\_enabled\_for\_deployment) | Whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the Key Vault. | `bool` | `false` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | Whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | `bool` | `false` | no |
| <a name="input_enabled_for_template_deployment"></a> [enabled\_for\_template\_deployment](#input\_enabled\_for\_template\_deployment) | Whether Azure Resource Manager is permitted to retrieve secrets from the Key Vault. | `bool` | `false` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add. | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location for Key Vault. | `string` | n/a | yes |
| <a name="input_network_acls"></a> [network\_acls](#input\_network\_acls) | Object with attributes: `bypass`, `default_action`, `ip_rules`, `virtual_network_subnet_ids`. Set to `null` to disable. See https://www.terraform.io/docs/providers/azurerm/r/key_vault.html#bypass for more information. | <pre>object({<br>    bypass                     = optional(string, "None"),<br>    default_action             = optional(string, "Deny"),<br>    ip_rules                   = optional(list(string)),<br>    virtual_network_subnet_ids = optional(list(string)),<br>  })</pre> | `{}` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether the Key Vault is available from public network. | `bool` | `false` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | Whether to activate purge protection. | `bool` | `true` | no |
| <a name="input_rbac_authorization_enabled"></a> [rbac\_authorization\_enabled](#input\_rbac\_authorization\_enabled) | Whether the Key Vault uses Role Based Access Control (RBAC) for authorization of data actions instead of access policies. | `bool` | `false` | no |
| <a name="input_reader_objects_ids"></a> [reader\_objects\_ids](#input\_reader\_objects\_ids) | IDs of the objects that can read all keys, secrets and certificates. | `list(string)` | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the azure resource group to contain the keyvault | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The Name of the SKU used for this Key Vault. Possible values are "standard" and "premium". | `string` | `"standard"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | The number of days that items should be retained for once soft-deleted. This value can be between `7` and `90` days. | `number` | `7` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Suffix for the name of the key Vault | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | ID of the Key Vault. |
| <a name="output_key_vault_name"></a> [key\_vault\_name](#output\_key\_vault\_name) | Name of the Key Vault. |
| <a name="output_key_vault_uri"></a> [key\_vault\_uri](#output\_key\_vault\_uri) | URI of the Key Vault |
