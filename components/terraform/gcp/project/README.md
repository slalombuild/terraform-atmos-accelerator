<!-- BEGIN-TERRAFORM-DOCS -->
## Description

Allows creation and management of a Google Cloud Platform project.

Projects created with this resource must be associated with an Organization.

IAM permissions at project level can be implemented while creating a project (if applicable).

Allows management of API services to enable/disable for a Google Cloud Platform project (if applicable).

## Reference to pass variable values from atmos stacks

<p>components: <br>&emsp;terraform:<br>&emsp;&emsp;project:<br>&emsp;&emsp;&emsp;metadata:<br>&emsp;&emsp;&emsp;&emsp;component: gcp/project <br>&emsp;&emsp;&emsp;vars:<br>&emsp;&emsp;&emsp;&emsp;enabled: true <br>&emsp;&emsp;&emsp;&emsp;namespace: "test" <br>&emsp;&emsp;&emsp;&emsp;environment: "project" <br>&emsp;&emsp;&emsp;&emsp;stage: "uw2" <br>&emsp;&emsp;&emsp;&emsp;label_key_case: "lower" <br>&emsp;&emsp;&emsp;&emsp;project_id: "test-project-id" <br>&emsp;&emsp;&emsp;&emsp;billing_account_id: "123456789" <br>&emsp;&emsp;&emsp;&emsp;org_id: null <br>&emsp;&emsp;&emsp;&emsp;folder_id: null <br>&emsp;&emsp;&emsp;&emsp;name: "test-project" <br>&emsp;&emsp;&emsp;&emsp;iam_bindings: [] <br>&emsp;&emsp;&emsp;&emsp;apis: [] <br>&emsp;&emsp;&emsp;&emsp;tags: {} <br></p>

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |
| [google_project_iam_binding.iam_bindings](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_service.apis](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_apis"></a> [apis](#input\_apis) | Google APIs to enable on the new GCP project. | `list(string)` | <pre>[<br>  "cloudkms.googleapis.com",<br>  "cloudresourcemanager.googleapis.com",<br>  "iam.googleapis.com",<br>  "logging.googleapis.com",<br>  "monitoring.googleapis.com",<br>  "servicenetworking.googleapis.com",<br>  "serviceusage.googleapis.com",<br>  "compute.googleapis.com",<br>  "container.googleapis.com",<br>  "iam.googleapis.com",<br>  "dns.googleapis.com",<br>  "secretmanager.googleapis.com",<br>  "iap.googleapis.com"<br>]</pre> | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_auto_create_network"></a> [auto\_create\_network](#input\_auto\_create\_network) | To create the network automatically when project is getting created | `bool` | `false` | no |
| <a name="input_billing_account_id"></a> [billing\_account\_id](#input\_billing\_account\_id) | The alphanumeric ID of the billing account the project will belong to. The user or service account performing this operation with Terraform must have Billing Account Administrator privileges (roles/billing.admin) on the GCP organization or folder the project will be deployed to. | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_disable_dependent_services"></a> [disable\_dependent\_services](#input\_disable\_dependent\_services) | If true, services that are enabled and which depend on this service should also be disabled when this service is destroyed | `bool` | `true` | no |
| <a name="input_disable_on_destroy"></a> [disable\_on\_destroy](#input\_disable\_on\_destroy) | If true, disable the service when the Terraform resource is destroyed | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The numeric ID of the folder the project will belong to. Only one of org\_id or folder\_id may be specified. If the folder\_id is specified, then the project is created under the specified folder. Changing this forces the project to be migrated to the newly specified folder. | `string` | `null` | no |
| <a name="input_iam_bindings"></a> [iam\_bindings](#input\_iam\_bindings) | One or more objects containing IAM members (users, groups, service accounts, etc.) and their respective roles that will be assigned to the project. Note: these are project-wise permissions. | <pre>list(object({<br>    members = list(string),<br>    role    = string<br>  }))</pre> | `[]` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to apply to the GCP project and its resources. | `map(string)` | `{}` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The numeric ID of the organization the project will belong to. Changing this forces a new project to be created. Only one of org\_id or folder\_id may be specified. If the org\_id is specified then the project is created at the top level. Changing this forces the project to be migrated to the newly specified organization. | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | An ID for the new GCP project. Once this value is set it can't be changed. | `string` | n/a | yes |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_skip_delete"></a> [skip\_delete](#input\_skip\_delete) | If true, the Terraform resource can be deleted without deleting the Project via the Google API | `bool` | `false` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apis"></a> [apis](#output\_apis) | APIs enabled on the project. |
| <a name="output_id"></a> [id](#output\_id) | The identifier of the project with format projects/{project}. |
| <a name="output_number"></a> [number](#output\_number) | The numeric identifier of the project. |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | The identifier of the project. |
<!-- END-TERRAFORM-DOCS -->