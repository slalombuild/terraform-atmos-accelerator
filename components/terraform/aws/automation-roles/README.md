# Component: **automation-roles**

This code provisions the following:

- A role called like `accelerator-{environment}-automation-role` on the
  automation, dev, staging, and prod accounts
- It creates the Trust relationship for the ECS Task role used by Atlantis to
  assume each of this roles
- It creates the Trust relationship for the Users Admin roles to assume the
  automation roles to run Atmos/Terraform commands locally
- It creates a user managed PowerUser like policy

## Provisioning

This code can be applied as soon as the admin user get access to the
corresponding accounts and even before the Atlantis task role exists. Keep in
mind that the names of the roles will need to be adjusted in the tfvars file to
accommodate for the new names or account numbers.

## Note

This module expects the user to have a credential file with the following
profiles to satisfy the providers defined in `providers.tf`

- `accelerator-auto`
- `accelerator-dev`
- `accelerator-staging`
- `accelerator-prod`

If you do not have accounts one or more of these environments, their respective
profiles must still be filled out with valid credentials.

Only `SuperAdmin` or users with Root account access should run this code.

Variables in the provided `automation-roles.auto.tfvars` file need to be
uncommented and replaced with the appropriate values.

- The `auto` account in the `accounts` map must be defined as that is the core
  account to run this configuration
- Any accounts present in the `accounts` map but missing in your environment may
  be removed from the map.
  - This will disable the modules dedicated to the environment(s) in question

Once the AWS profiles have been configured with working credentials and
`automation-roles.auto.tfvars` has been filled out, these resources can be
deployed via `terraform apply`.

### Remote state

- The remote state of this module is stored in the automation account on a s3
  bucket called `accelerator-auto-ue2-tfstate-iac`

<!-- BEGIN-TERRAFORM-DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.auto"></a> [aws.auto](#provider\_aws.auto) | >= 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_automation_auto_role"></a> [automation\_auto\_role](#module\_automation\_auto\_role) | cloudposse/iam-role/aws | 0.18.0 |
| <a name="module_automation_dev_role"></a> [automation\_dev\_role](#module\_automation\_dev\_role) | cloudposse/iam-role/aws | 0.18.0 |
| <a name="module_automation_prod_role"></a> [automation\_prod\_role](#module\_automation\_prod\_role) | cloudposse/iam-role/aws | 0.18.0 |
| <a name="module_automation_staging_role"></a> [automation\_staging\_role](#module\_automation\_staging\_role) | cloudposse/iam-role/aws | 0.18.0 |
| <a name="module_terraform_state_backend"></a> [terraform\_state\_backend](#module\_terraform\_state\_backend) | cloudposse/tfstate-backend/aws | 1.1.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.allow_automation_tasks_to_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.allow_automation_tasks_to_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.AdministratorAccess](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accounts"></a> [accounts](#input\_accounts) | Map of Account IDs to be used | `map(number)` | <pre>{<br>  "auto": null,<br>  "dev": null,<br>  "prod": null,<br>  "staging": null<br>}</pre> | no |
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_iac_automation_role_arn"></a> [iac\_automation\_role\_arn](#input\_iac\_automation\_role\_arn) | Existing IaC role ARN for Automation account | `string` | n/a | yes |
| <a name="input_iac_automation_role_name"></a> [iac\_automation\_role\_name](#input\_iac\_automation\_role\_name) | Existing IaC role name for Automation account | `string` | n/a | yes |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the project into which this is being deployed | `string` | `""` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"us-east-2"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

No outputs.
<!-- END-TERRAFORM-DOCS -->
