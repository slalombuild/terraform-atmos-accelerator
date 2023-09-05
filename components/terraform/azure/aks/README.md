# Component: **aks**

## About 

This module creates the required resources for Azure Kubernetes Service (AKS), including:
+ Resource Group (optional)
+ Standardized naming
+ AKS
+ VNet
+ Subnet
+ NACLs 
+ Keyvault
+ Container Registry
+ Log Analytics workspace
 
***

## Usage

```yaml
terraform:
    aks:
      vars:
        create_resource_group: true
        location: WestUS2
```

<!-- BEGIN-TERRAFORM-DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.51.0, < 4.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | > 3.2.0, < 4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.3.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.51.0, < 4.0 |
| <a name="provider_http"></a> [http](#provider\_http) | > 3.2.0, < 4.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.3.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks_cluster_name"></a> [aks\_cluster\_name](#module\_aks\_cluster\_name) | Azure/aks/azurerm | 7.1.0 |
| <a name="module_naming"></a> [naming](#module\_naming) | Azure/naming/azurerm | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_disk_encryption_set.des](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set) | resource |
| [azurerm_key_vault.des_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.current_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.des](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.kms](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_key.des_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_key_vault_key.kms](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_log_analytics_solution.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_solution) | resource |
| [azurerm_log_analytics_workspace.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.kms](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_subnet.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_user_assigned_identity.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_virtual_network.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [random_string.key_vault_prefix](https://registry.terraform.io/providers/hashicorp/random/3.3.2/docs/resources/string) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [http_http.public_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_component_suffix"></a> [component\_suffix](#input\_component\_suffix) | This component uses a naming module. The component\_suffix will be suffixed to all resource names. Lowercase alphabet only. | `string` | `"aks"` | no |
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | If true, a new resource group will be created using resource\_group\_name. If false, resource\_group\_name must be an existing resource group. | `bool` | `true` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags to apply to resources created by this component. | `map(string)` | `{}` | no |
| <a name="input_key_vault_firewall_bypass_ip_cidr"></a> [key\_vault\_firewall\_bypass\_ip\_cidr](#input\_key\_vault\_firewall\_bypass\_ip\_cidr) | IP range to allow access to Keyvault. If null, the requesting IP address will be added to enable resource provisioning. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure location to create resources in. | `string` | n/a | yes |
| <a name="input_managed_identity_principal_id"></a> [managed\_identity\_principal\_id](#input\_managed\_identity\_principal\_id) | Managed identity principal id to use to enable keyvault access for a specific user or service principal. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group to use when creating resources. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_named_id"></a> [aks\_named\_id](#output\_aks\_named\_id) | n/a |
| <a name="output_aks_named_identity"></a> [aks\_named\_identity](#output\_aks\_named\_identity) | n/a |
<!-- END-TERRAFORM-DOCS -->
