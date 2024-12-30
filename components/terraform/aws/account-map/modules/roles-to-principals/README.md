# Submodule `roles-to-principals`

This submodule is used by other modules to map short role names and AWS
SSO Permission Set names in accounts designated by short account names
(for example, `terraform` in the `dev` account) to full IAM Role ARNs and
other related tasks.

## Special Configuration Needed

As with `iam-roles`, in order to avoid having to pass customization information through every module
that uses this submodule, if the default configuration does not suit your needs,
you are expected to add `variables_override.tf` to override the variables with
the defaults you want to use in your project. For example, if you are not using
"core" as the `tenant` portion of your "root" account (your Organization Management Account),
then you should include the `variable "overridable_global_tenant_name"` declaration
in your `variables_override.tf` so that `overridable_global_tenant_name` defaults
to the value you are using (or the empty string if you are not using `tenant` at all).

<!-- BEGIN-TERRAFORM-DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_account_map"></a> [account\_map](#module\_account\_map) | cloudposse/stack-config/yaml//modules/remote-state | 1.5.0 |
| <a name="module_always"></a> [always](#module\_always) | cloudposse/label/null | 0.25.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

No resources.

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
| <a name="input_overridable_team_permission_set_name_pattern"></a> [overridable\_team\_permission\_set\_name\_pattern](#input\_overridable\_team\_permission\_set\_name\_pattern) | The pattern used to generate the AWS SSO PermissionSet name for each team | `string` | `"Identity%sTeamAccess"` | no |
| <a name="input_overridable_team_permission_sets_enabled"></a> [overridable\_team\_permission\_sets\_enabled](#input\_overridable\_team\_permission\_sets\_enabled) | When true, any roles (teams or team-roles) in the identity account references in `role_map`<br>will cause corresponding AWS SSO PermissionSets to be included in the `permission_set_arn_like` output.<br>This has the effect of treating those PermissionSets as if they were teams.<br>The main reason to set this `false` is if IAM trust policies are exceeding size limits and you are not using AWS SSO. | `bool` | `true` | no |
| <a name="input_permission_set_map"></a> [permission\_set\_map](#input\_permission\_set\_map) | Map of account:[PermissionSet, PermissionSet...] specifying AWS SSO PermissionSets when accessed from specified accounts | `map(list(string))` | `{}` | no |
| <a name="input_privileged"></a> [privileged](#input\_privileged) | True if the default provider already has access to the backend | `bool` | `false` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_role_map"></a> [role\_map](#input\_role\_map) | Map of account:[role, role...]. Use `*` as role for entire account | `map(list(string))` | `{}` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_teams"></a> [teams](#input\_teams) | List of team names to translate to AWS SSO PermissionSet names | `list(string)` | `[]` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_partition"></a> [aws\_partition](#output\_aws\_partition) | The AWS "partition" to use when constructing resource ARNs |
| <a name="output_full_account_map"></a> [full\_account\_map](#output\_full\_account\_map) | Map of account names to account IDs |
| <a name="output_permission_set_arn_like"></a> [permission\_set\_arn\_like](#output\_permission\_set\_arn\_like) | List of Role ARN regexes suitable for IAM Condition `ArnLike` corresponding to given input `permission_set_map` |
| <a name="output_principals"></a> [principals](#output\_principals) | Consolidated list of AWS principals corresponding to given input `role_map` |
| <a name="output_principals_map"></a> [principals\_map](#output\_principals\_map) | Map of AWS principals corresponding to given input `role_map` |
| <a name="output_team_permission_set_name_map"></a> [team\_permission\_set\_name\_map](#output\_team\_permission\_set\_name\_map) | Map of team names (from `var.teams` and `role_map["identity"]) to permission set names` |
<!-- END-TERRAFORM-DOCS -->