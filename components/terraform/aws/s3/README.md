<!-- BEGIN-TERRAFORM-DOCS -->
# Component: terraform-aws-s3-bucket

# Description: |-
  This module creates an S3 bucket with support for versioning, lifecycles, object locks, replication, encryption, ACL,
  bucket object policies, and static website hosting.

  If `user_enabled` variable is set to `true`, the module will provision a basic IAM user with permissions to access the bucket.
  This basic IAM system user is suitable for CI/CD systems (_e.g._ TravisCI, CircleCI) or systems which are *external* to AWS that cannot leverage
  [AWS IAM Instance Profiles](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html)
  or [AWS OIDC](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html) to authenticate and
  do not already have IAM credentials. Users or systems that have IAM credentials should either be granted access directly based on
  their IAM identity via `privileged_principal_arns` or be allowed to assume an IAM role with access.

  We do not recommend creating IAM users this way for any other purpose.

  This module blocks public access to the bucket by default. See `block_public_acls`, `block_public_policy`,
  `ignore_public_acls`, and `restrict_public_buckets` to change the settings. See [AWS documentation](https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html)
  for more details.

  If an IAM user is created, the IAM user name is constructed using [terraform-null-label](https://github.com/cloudposse/terraform-null-label)
  and some input is required. The simplest input is `name`. By default the name will be converted to lower case
  and all non-alphanumeric characters except for hyphen will be removed. See the documentation for `terraform-null-label`
  to learn how to override these defaults if desired.

  If an AWS Access Key is created, it is stored either in SSM Parameter Store or is provided as a module output,
  but not both. Using SSM Parameter Store is recommended because module outputs are stored in plaintext in
  the Terraform state file.
# Usage of atmos stack
Components:
    terraform:
      s3:
       metadata:
        component: aws/s3
       vars:
        bucket_name: null
        kms_master_key_id: null
        enabled: true
        namespace: "accelerator"
        environment: "dev"
        account_map: {
          dev: 123456789
          staging: 123456789
          prod: 123456789
        }
        region: "us-west-2"
        stage: "uw2"

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | < 5.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | cloudposse/s3-bucket/aws | 3.1.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_kms_key.s3_customer_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key_enabled"></a> [access\_key\_enabled](#input\_access\_key\_enabled) | Set to true to create an IAM Access Key for the created IAM user | `bool` | `true` | no |
| <a name="input_account_map"></a> [account\_map](#input\_account\_map) | Account map of all the available accounts | `map(any)` | `{}` | no |
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_allow_encrypted_uploads_only"></a> [allow\_encrypted\_uploads\_only](#input\_allow\_encrypted\_uploads\_only) | Set to true to prevent uploads of unencrypted objects to S3 bucket | `bool` | `false` | no |
| <a name="input_allowed_bucket_actions"></a> [allowed\_bucket\_actions](#input\_allowed\_bucket\_actions) | Set to true to prevent uploads of unencrypted objects to S3 bucket | `list(string)` | <pre>[<br>  "s3:PutObject",<br>  "s3:PutObjectAcl",<br>  "s3:GetObject",<br>  "s3:ListBucket",<br>  "s3:ListBucketMultipartUploads",<br>  "s3:GetBucketLocation"<br>]</pre> | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | Set to `false` to disable the blocking of new public access lists on the bucket | `bool` | `true` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | Set to `false` to disable the blocking of new public policies on the bucket | `bool` | `true` | no |
| <a name="input_bucket_key_enabled"></a> [bucket\_key\_enabled](#input\_bucket\_key\_enabled) | Set this to true to use Amazon S3 Bucket Keys for SSE-KMS, which reduce the cost of AWS KMS requests.<br><br>For more information, see: https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-key.html | `bool` | `false` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Bucket name. If provided, the bucket will be created with this name instead of generating the name from the context | `string` | `null` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_cors_configuration"></a> [cors\_configuration](#input\_cors\_configuration) | Specifies the allowed headers, methods, origins and exposed headers when using CORS on this bucket | <pre>list(object({<br>    allowed_headers = list(string)<br>    allowed_methods = list(string)<br>    allowed_origins = list(string)<br>    expose_headers  = list(string)<br>    max_age_seconds = number<br>  }))</pre> | `[]` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_ignore_public_acls"></a> [ignore\_public\_acls](#input\_ignore\_public\_acls) | Set to `false` to disable the ignoring of public access lists on the bucket | `bool` | `true` | no |
| <a name="input_kms_master_key_id"></a> [kms\_master\_key\_id](#input\_kms\_master\_key\_id) | The AWS KMS master key id used for the `SSE-KMS` encryption. This can only be used when you set the value of `sse_algorithm` as `aws:kms`. The default aws/s3 AWS KMS master key is used if this element is absent while the `sse_algorithm` is `aws:kms` | `string` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_lifecycle_configuration_rules"></a> [lifecycle\_configuration\_rules](#input\_lifecycle\_configuration\_rules) | A list of lifecycle V2 rules | <pre>list(object({<br>    enabled = bool<br>    id      = string<br><br>    abort_incomplete_multipart_upload_days = number<br><br>    # filter_and is the and configuration block inside the filter configuration.<br>    # This is the only place you should specify a prefix.<br>    filter_and = any<br>    expiration = any<br>    transition = list(any)<br><br>    noncurrent_version_expiration = any<br>    noncurrent_version_transition = list(any)<br>  }))</pre> | `[]` | no |
| <a name="input_logging"></a> [logging](#input\_logging) | Bucket access logging configuration. | <pre>object({<br>    bucket_name = string<br>    prefix      = string<br>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_object_lock_configuration"></a> [object\_lock\_configuration](#input\_object\_lock\_configuration) | A configuration for S3 object locking. With S3 Object Lock, you can store objects using a write once, read many (WORM) model. Object Lock can help prevent objects from being deleted or overwritten for a fixed amount of time or indefinitely. | <pre>object({<br>    mode  = string # Valid values are GOVERNANCE and COMPLIANCE.<br>    days  = number<br>    years = number<br>  })</pre> | `null` | no |
| <a name="input_privileged_principal_actions"></a> [privileged\_principal\_actions](#input\_privileged\_principal\_actions) | List of actions to permit privileged\_principal\_arns to perform on bucket and bucket prefixes (see privileged\_principal\_arns) | `list(string)` | `[]` | no |
| <a name="input_privileged_principal_arns"></a> [privileged\_principal\_arns](#input\_privileged\_principal\_arns) | List of maps. Each map has a key, an IAM Principal ARN, whose associated value is a list of S3 path prefixes to grant privileged\_principal\_actions permissions for that principal,in addition to the bucket itself, which is automatically included. Prefixes should not begin with '/'. | `list(map(list(string)))` | `[]` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | Set to `false` to disable the restricting of making the bucket public | `bool` | `true` | no |
| <a name="input_s3_object_ownership"></a> [s3\_object\_ownership](#input\_s3\_object\_ownership) | Specifies the S3 object ownership control. Valid values are ObjectWriter, BucketOwnerPreferred, and 'BucketOwnerEnforced'. Defaults to 'ObjectWriter' for backwards compatibility, but we recommend setting 'BucketOwnerEnforced' instead. | `string` | `"ObjectWriter"` | no |
| <a name="input_s3_replica_bucket_arn"></a> [s3\_replica\_bucket\_arn](#input\_s3\_replica\_bucket\_arn) | A single S3 bucket ARN to use for all replication rules.Note: The destination bucket can be specified in the replication rule itself(which allows for multiple destinations), in which case it will take precedence over this variable. | `string` | `""` | no |
| <a name="input_s3_replication_enabled"></a> [s3\_replication\_enabled](#input\_s3\_replication\_enabled) | Set this to true and specify s3\_replication\_rules to enable replication. versioning\_enabled must also be true. | `bool` | `false` | no |
| <a name="input_s3_replication_permissions_boundary_arn"></a> [s3\_replication\_permissions\_boundary\_arn](#input\_s3\_replication\_permissions\_boundary\_arn) | Permissions boundary ARN for the created IAM replication role. | `string` | `null` | no |
| <a name="input_s3_replication_rules"></a> [s3\_replication\_rules](#input\_s3\_replication\_rules) | Specifies the replication rules for S3 bucket replication if enabled. You must also set s3\_replication\_enabled to true. | `list(any)` | `null` | no |
| <a name="input_s3_replication_source_roles"></a> [s3\_replication\_source\_roles](#input\_s3\_replication\_source\_roles) | Cross-account IAM Role ARNs that will be allowed to perform S3 replication to this bucket (for replication within the same AWS account, it's not necessary to adjust the bucket policy). | `list(string)` | `[]` | no |
| <a name="input_source_policy_documents"></a> [source\_policy\_documents](#input\_source\_policy\_documents) | List of IAM policy documents that are merged together into the exported document.Statements defined in source\_policy\_documents or source\_json must have unique SIDs.Statement having SIDs that match policy SIDs generated by this module will override them. | `list(string)` | `[]` | no |
| <a name="input_sse_algorithm"></a> [sse\_algorithm](#input\_sse\_algorithm) | The server-side encryption algorithm. | `string` | `"AES256"` | no |
| <a name="input_ssm_base_path"></a> [ssm\_base\_path](#input\_ssm\_base\_path) | The base path for SSM parameters where created IAM user's access key is stored | `string` | `"/s3_user/"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_store_access_key_in_ssm"></a> [store\_access\_key\_in\_ssm](#input\_store\_access\_key\_in\_ssm) | Set to true to store the created IAM user's access key in SSM Parameter Store,false to store them in Terraform state as outputs.Since Terraform state would contain the secrets in plaintext,use of SSM Parameter Store is recommended. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_user_permissions_boundary_arn"></a> [user\_permissions\_boundary\_arn](#input\_user\_permissions\_boundary\_arn) | Permission boundary ARN for the IAM user created to access the bucket. | `string` | `null` | no |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | A state of versioning. Versioning is a means of keeping multiple variants of an object in the same bucket | `bool` | `false` | no |
| <a name="input_website_configuration"></a> [website\_configuration](#input\_website\_configuration) | Specifies the static website hosting configuration object | <pre>list(object({<br>    index_document = string<br>    error_document = string<br>    routing_rules = list(object({<br>      condition = object({<br>        http_error_code_returned_equals = string<br>        key_prefix_equals               = string<br>      })<br>      redirect = object({<br>        host_name               = string<br>        http_redirect_code      = string<br>        protocol                = string<br>        replace_key_prefix_with = string<br>        replace_key_with        = string<br>      })<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3"></a> [s3](#output\_s3) | output for s3 bucket |
<!-- END-TERRAFORM-DOCS -->
