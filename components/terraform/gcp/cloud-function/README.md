<!-- BEGIN-TERRAFORM-DOCS -->
## Description:

The Terraform module handles the deployment of Cloud Functions (Gen 2) on GCP.

The resources/services/activations/deletions that this module will create/trigger are:

   * Deploy Cloud Functions (2nd Gen) with provided source code and trigger

   * Provide Cloud Functions Invoker or Developer roles to the users and service accounts

It also creates a new bucket in Google cloud storage service (GCS) with an option to enable or disable kms, when user didn't pass the name of existing bucket. Once a bucket has been created, its location can't be changed. It acts as a source to the Google Cloud-Function

Note: If the project id is not set on the resource or in the provider block it will be dynamically determined which will require enabling the compute api.

## Reference to pass variable values from atmos stack

<p>components: <br>&emsp;terraform:<br>&emsp;&emsp;cloud-function:<br>&emsp;&emsp;&emsp;metadata:<br>&emsp;&emsp;&emsp;&emsp;component: gcp/cloud-function <br>&emsp;&emsp;&emsp;vars:<br>&emsp;&emsp;&emsp;&emsp;enabled: true <br>&emsp;&emsp;&emsp;&emsp;namespace: "test" <br>&emsp;&emsp;&emsp;&emsp;environment: "cloud-function" <br>&emsp;&emsp;&emsp;&emsp;stage: "uw2" <br>&emsp;&emsp;&emsp;&emsp;label_key_case: "lower" <br>&emsp;&emsp;&emsp;&emsp;project_id: "gcp-project-id" <br>&emsp;&emsp;&emsp;&emsp;attributes: [] <br>&emsp;&emsp;&emsp;&emsp;kms_encryption_enabled: false <br>&emsp;&emsp;&emsp;&emsp;gcs_bucket: {} <br>&emsp;&emsp;&emsp;&emsp;kms: {} <br>&emsp;&emsp;&emsp;&emsp;bucket_iam: [] <br>&emsp;&emsp;&emsp;&emsp;tags: {} <br>&emsp;&emsp;&emsp;&emsp;function_location: "US"<br>&emsp;&emsp;&emsp;&emsp;entrypoint: "entrypoint.test" <br>&emsp;&emsp;&emsp;&emsp;runtime: "python3" <br>&emsp;&emsp;&emsp;&emsp;bucket_source_enabled: true <br>&emsp;&emsp;&emsp;&emsp;bucket_name: null <br>&emsp;&emsp;&emsp;&emsp;bucket: <br>&emsp;&emsp;&emsp;&emsp;&emsp;object_path: "/" <br>&emsp;&emsp;&emsp;&emsp;&emsp;generation: null <br>&emsp;&emsp;&emsp;&emsp;repo_source_enabled: false <br>&emsp;&emsp;&emsp;&emsp;repo_source: <br>&emsp;&emsp;&emsp;&emsp;&emsp;branch_name: "test" <br>&emsp;&emsp;&emsp;&emsp;&emsp;repo_name: "test" <br></p>

* Must needs to pass either one of the repo_source or bucket_source to the cloud funtion or it throws an error.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.72 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 4.72 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_function"></a> [cloud\_function](#module\_cloud\_function) | GoogleCloudPlatform/cloud-functions/google | 0.3.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [google_kms_crypto_key.crypto_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_crypto_key_iam_member.crypto_key_iam_member_gcs_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |
| [google_kms_key_ring.key_ring](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [google_storage_bucket.bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_binding.bucket_iam_bindings](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |
| [google_storage_project_service_account.gcs_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_project_service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | Get the source from this location in Google Cloud Storage | <pre>object({<br>    object_path = string,<br>    generation  = optional(string, null)<br>  })</pre> | `null` | no |
| <a name="input_bucket_iam"></a> [bucket\_iam](#input\_bucket\_iam) | IAM roles and members to grant authoritative permissions on the new GCS bucket. Your IAM service accounts will need at least 'roles/storage.objectViewer' to read objects and 'roles/storage.objectAdmin' for full object control. | <pre>list(object({<br>    role    = string,<br>    members = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | name of the bucket. defaults to null and it's automattically creates one for you unless the bucket name is passed | `string` | `null` | no |
| <a name="input_bucket_source_enabled"></a> [bucket\_source\_enabled](#input\_bucket\_source\_enabled) | whether to use cloud storage bucket as the sorce to cloud function | `bool` | `true` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Short description of the function | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_docker_repository"></a> [docker\_repository](#input\_docker\_repository) | User managed repository created in Artifact Registry optionally with a customer managed encryption key. | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `false` | no |
| <a name="input_entrypoint"></a> [entrypoint](#input\_entrypoint) | The name of the function (as defined in source code) that will be executed. Defaults to the resource name suffix, if not specified | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_event_trigger"></a> [event\_trigger](#input\_event\_trigger) | Event triggers for the function | <pre>object({<br>    trigger_region        = optional(string, null),<br>    event_type            = string,<br>    service_account_email = string,<br>    pubsub_topic          = optional(string, null),<br>    retry_policy          = string,<br>    event_filters = optional(set(object({<br>      attribute       = string<br>      attribute_value = string<br>      operator        = optional(string)<br>    })), null)<br>  })</pre> | `null` | no |
| <a name="input_function_location"></a> [function\_location](#input\_function\_location) | The location of this cloud function | `string` | n/a | yes |
| <a name="input_gcs_bucket"></a> [gcs\_bucket](#input\_gcs\_bucket) | The values needed for creation of bucket | <pre>object({<br>    location                    = optional(string, "US"),<br>    force_destroy               = optional(bool, false),<br>    storage_class               = optional(string, "STANDARD"),<br>    public_access_prevention    = optional(string, "inherited"),<br>    uniform_bucket_level_access = optional(bool, true),<br><br>    retention_policy = optional(object({<br>      is_locked        = optional(bool, false),<br>      retention_period = string,<br>    }), null),<br><br>    versioning_enabled = optional(bool, false),<br>    autoclass_enabled  = optional(bool, false),<br><br>    website = optional(list(object({<br>      main_page_suffix = optional(string, null),<br>      not_found_page   = optional(string, null),<br>    })), []),<br><br>    cors = optional(list(object({<br>      origin          = optional(list(string), []),<br>      method          = optional(list(string), []),<br>      response_header = optional(list(string), []),<br>      max_age_seconds = optional(number, null)<br>    })), []),<br><br>    lifecycle_rules = optional(list(object({<br>      type                       = string,<br>      storage_class              = optional(string, null),<br>      age                        = optional(number, null),<br>      created_before             = optional(string, null),<br>      with_state                 = optional(string, null),<br>      matches_storage_class      = optional(list(string), []),<br>      matches_prefix             = optional(list(string), []),<br>      matches_suffix             = optional(list(string), []),<br>      num_newer_versions         = optional(number, null),<br>      custom_time_before         = optional(string, null),<br>      days_since_custom_time     = optional(number, null),<br>      days_since_noncurrent_time = optional(number, null),<br>      noncurrent_time_before     = optional(string, null),<br>    })), []),<br><br>    requester_pays = optional(bool, false),<br><br>    custom_placement_config = optional(object({<br>      data_locations = list(string),<br>    }), null),<br><br>    logging = optional(object({<br>      log_bucket        = string,<br>      log_object_prefix = optional(string, ""),<br>    }), null),<br>  })</pre> | `{}` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_kms"></a> [kms](#input\_kms) | The values required for Kms creation | <pre>object({<br>    location             = optional(string, "US"),<br>    key_algorithm        = optional(string, "GOOGLE_SYMMETRIC_ENCRYPTION"),<br>    key_protection_level = optional(string, "SOFTWARE"),<br>    key_rotation_period  = optional(string, "100000s"),<br>    purpose              = optional(string, "ENCRYPT_DECRYPT"), # Possible values are ENCRYPT_DECRYPT, ASYMMETRIC_SIGN, and ASYMMETRIC_DECRYPT.<br>  })</pre> | `{}` | no |
| <a name="input_kms_encryption_enabled"></a> [kms\_encryption\_enabled](#input\_kms\_encryption\_enabled) | weather to enable Kms encryption on GCS Bucket or not | `bool` | `false` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_members"></a> [members](#input\_members) | Cloud Function Invoker and Developer roles for Users/SAs. Key names must be developers and/or invokers | `map(list(string))` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the existing GCP project where the GCS bucket will be deployed. | `string` | n/a | yes |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_repo_source"></a> [repo\_source](#input\_repo\_source) | Get the source from this location in a Cloud Source Repository | <pre>object({<br>    project_id   = optional(string, null),<br>    repo_name    = string,<br>    branch_name  = string,<br>    dir          = optional(string, null),<br>    tag_name     = optional(string, null),<br>    commit_sha   = optional(string, null),<br>    invert_regex = optional(bool, false)<br>  })</pre> | `null` | no |
| <a name="input_repo_source_enabled"></a> [repo\_source\_enabled](#input\_repo\_source\_enabled) | whether to use SCM or repository as the sorce to cloud function | `bool` | `false` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | The runtime in which to run the function. | `string` | n/a | yes |
| <a name="input_service_config"></a> [service\_config](#input\_service\_config) | Details of the service | <pre>object({<br>    max_instance_count    = optional(string, 100),<br>    min_instance_count    = optional(string, 1),<br>    available_memory      = optional(string, "256M"),<br>    timeout_seconds       = optional(string, 60),<br>    runtime_env_variables = optional(map(string), null),<br>    runtime_secret_env_variables = optional(set(object({<br>      key_name   = string,<br>      project_id = optional(string, null),<br>      secret     = string,<br>      version    = string<br>    })), null),<br>    secret_volumes = optional(set(object({<br>      mount_path = string,<br>      project_id = optional(string, null),<br>      secret     = string,<br>      versions = set(object({<br>        version = string,<br>        path    = string<br>      }))<br>    })), null),<br>    vpc_connector                  = optional(string, null),<br>    vpc_connector_egress_settings  = optional(string, null),<br>    ingress_settings               = optional(string, null),<br>    service_account_email          = optional(string, null),<br>    all_traffic_on_latest_revision = optional(bool, true)<br>  })</pre> | `{}` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_worker_pool"></a> [worker\_pool](#input\_worker\_pool) | Name of the Cloud Build Custom Worker Pool that should be used to build the function. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | n/a |
| <a name="output_bucket_self_link"></a> [bucket\_self\_link](#output\_bucket\_self\_link) | n/a |
| <a name="output_bucket_url"></a> [bucket\_url](#output\_bucket\_url) | n/a |
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | n/a |
| <a name="output_function_uri"></a> [function\_uri](#output\_function\_uri) | n/a |
| <a name="output_kms_id"></a> [kms\_id](#output\_kms\_id) | n/a |
| <a name="output_kms_name"></a> [kms\_name](#output\_kms\_name) | n/a |
<!-- END-TERRAFORM-DOCS -->
