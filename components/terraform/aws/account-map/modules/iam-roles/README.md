# Submodule `iam-roles`

This submodule is used by other modules to determine which IAM Roles
or AWS CLI Config Profiles to use for various tasks, most commonly
for applying Terraform plans.

## Special Configuration Needed

In order to avoid having to pass customization information through every module
that uses this submodule, if the default configuration does not suit your needs,
you are expected to add `variables_override.tf` to override the variables with
the defaults you want to use in your project. For example, if you are not using
"core" as the `tenant` portion of your "root" account (your Organization Management Account),
then you should include the `variable "overridable_global_tenant_name"` declaration
in your `variables_override.tf` so that `overridable_global_tenant_name` defaults
to the value you are using (or the empty string if you are not using `tenant` at all).

<!-- BEGIN-TERRAFORM-DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_awsutils"></a> [awsutils](#requirement\_awsutils) | >= 0.16.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_awsutils.iam-roles"></a> [awsutils.iam-roles](#provider\_awsutils.iam-roles) | >= 0.16.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_account_map"></a> [account\_map](#module\_account\_map) | cloudposse/stack-config/yaml//modules/remote-state | 1.5.0 |
| <a name="module_always"></a> [always](#module\_always) | cloudposse/label/null | 0.25.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [awsutils_caller_identity.current](https://registry.terraform.io/providers/cloudposse/awsutils/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_overridable_global_environment_name"></a> [overridable\_global\_environment\_name](#input\_overridable\_global\_environment\_name) | Global environment name | `string` | `"global"` | no |
| <a name="input_overridable_global_stage_name"></a> [overridable\_global\_stage\_name](#input\_overridable\_global\_stage\_name) | The stage name for the organization management account (where the `account-map` state is stored) | `string` | `"root"` | no |
| <a name="input_overridable_global_tenant_name"></a> [overridable\_global\_tenant\_name](#input\_overridable\_global\_tenant\_name) | The tenant name used for organization-wide resources | `string` | `""` | no |
| <a name="input_privileged"></a> [privileged](#input\_privileged) | True if the Terraform user already has access to the backend | `bool` | `false` | no |
| <a name="input_profiles_enabled"></a> [profiles\_enabled](#input\_profiles\_enabled) | Whether or not to use profiles instead of roles for Terraform. Default (null) means to use global settings. | `bool` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_audit_terraform_profile_name"></a> [audit\_terraform\_profile\_name](#output\_audit\_terraform\_profile\_name) | The AWS config profile name for Terraform to use to provision resources in the "audit" role account, when profiles are in use |
| <a name="output_audit_terraform_role_arn"></a> [audit\_terraform\_role\_arn](#output\_audit\_terraform\_role\_arn) | The AWS Role ARN for Terraform to use to provision resources in the "audit" role account, when Role ARNs are in use |
| <a name="output_aws_partition"></a> [aws\_partition](#output\_aws\_partition) | The AWS "partition" to use when constructing resource ARNs |
| <a name="output_current_account_account_name"></a> [current\_account\_account\_name](#output\_current\_account\_account\_name) | The account name (usually `<tenant>-<stage>`) for the account configured by this module's inputs.<br>Roughly analogous to `data "aws_caller_identity"`, but returning the name of the caller account as used in our configuration. |
| <a name="output_dns_terraform_profile_name"></a> [dns\_terraform\_profile\_name](#output\_dns\_terraform\_profile\_name) | The AWS config profile name for Terraform to use to provision DNS Zone delegations, when profiles are in use |
| <a name="output_dns_terraform_role_arn"></a> [dns\_terraform\_role\_arn](#output\_dns\_terraform\_role\_arn) | The AWS Role ARN for Terraform to use to provision DNS Zone delegations, when Role ARNs are in use |
| <a name="output_global_environment_name"></a> [global\_environment\_name](#output\_global\_environment\_name) | The `null-label` `environment` value used for regionless (global) resources |
| <a name="output_global_stage_name"></a> [global\_stage\_name](#output\_global\_stage\_name) | The `null-label` `stage` value for the organization management account (where the `account-map` state is stored) |
| <a name="output_global_tenant_name"></a> [global\_tenant\_name](#output\_global\_tenant\_name) | The `null-label` `tenant` value used for organization-wide resources |
| <a name="output_identity_account_account_name"></a> [identity\_account\_account\_name](#output\_identity\_account\_account\_name) | The account name (usually `<tenant>-<stage>`) for the account holding primary IAM roles |
| <a name="output_identity_terraform_profile_name"></a> [identity\_terraform\_profile\_name](#output\_identity\_terraform\_profile\_name) | The AWS config profile name for Terraform to use to provision resources in the "identity" role account, when profiles are in use |
| <a name="output_identity_terraform_role_arn"></a> [identity\_terraform\_role\_arn](#output\_identity\_terraform\_role\_arn) | The AWS Role ARN for Terraform to use to provision resources in the "identity" role account, when Role ARNs are in use |
| <a name="output_local_account_map_terraform_roles"></a> [local\_account\_map\_terraform\_roles](#output\_local\_account\_map\_terraform\_roles) | n/a |
| <a name="output_local_account_name"></a> [local\_account\_name](#output\_local\_account\_name) | n/a |
| <a name="output_org_role_arn"></a> [org\_role\_arn](#output\_org\_role\_arn) | The AWS Role ARN for Terraform to use when SuperAdmin is provisioning resources in the account |
| <a name="output_profiles_enabled"></a> [profiles\_enabled](#output\_profiles\_enabled) | When true, use AWS config profiles in Terraform AWS provider configurations. When false, use Role ARNs. |
| <a name="output_terraform_profile_name"></a> [terraform\_profile\_name](#output\_terraform\_profile\_name) | The AWS config profile name for Terraform to use when provisioning resources in the account, when profiles are in use |
| <a name="output_terraform_role_arn"></a> [terraform\_role\_arn](#output\_terraform\_role\_arn) | The AWS Role ARN for Terraform to use when provisioning resources in the account, when Role ARNs are in use |
| <a name="output_terraform_role_arns"></a> [terraform\_role\_arns](#output\_terraform\_role\_arns) | All of the terraform role arns |
<!-- END-TERRAFORM-DOCS -->