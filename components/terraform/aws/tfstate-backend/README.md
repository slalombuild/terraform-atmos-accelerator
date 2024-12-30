# Component: **tfstate-backend**

This component is responsible for provisioning an S3 Bucket and DynamoDB table
that follow security best practices for usage as a Terraform backend. It also
creates IAM roles for access to the Terraform backend.

Once the initial S3 backend is configured, this component can create additional
backends, allowing you to segregate them and control access to each backend
separately. This may be desirable because any secret or sensitive information
(such as generated passwords) that Terraform has access to gets stored in the
Terraform state backend S3 bucket, so you may wish to restrict who can read the
production Terraform state backend S3 bucket.

## Usage

**Stack Level**: Regional (because DynamoDB is region-specific), but only in a
single region and only in the `root` account **Deployment**: Must be deployed by
SuperAdmin using `atmos` CLI

This component configures the shared Terraform backend, and as such is the first
component that must be deployed, since all other components depend on it. In
fact, this component even depends on itself, so special deployment procedures
are needed for the initial deployment (documented in the "Cold Start"
procedures).

Here's an example snippet for how to use this component.

```yaml
  terraform:
    tfstate-backend:
      backend:
        s3:
          role_arn: null
      settings:
        spacelift:
          workspace_enabled: false
      vars:
        enable_server_side_encryption: true
        enabled: true
        force_destroy: false
        name: tfstate
        prevent_unencrypted_uploads: true
        # allowed roles & permission sets config for read/write (default) and read-only (ro) may vary based on your use case
        access_roles:
          default: &tfstate-access-template
            write_enabled: true
            allowed_roles:
              identity: ["admin", "cicd", "poweruser", "spacelift", "terraform"]
            denied_roles: {}
            allowed_permission_sets:
              identity: ["AdministratorAccess"]
            denied_permission_sets: {}
            allowed_principal_arns: []
            denied_principal_arns: []
          ro:
            <<: *tfstate-access-template
            write_enabled: false
            allowed_roles:
              identity: ["admin", "cicd", "poweruser", "spacelift", "terraform", "reader", "observer", "support"]

```

### Cold start process of terraform remote state backend.

#### This procedure needs to be done just once per aws account.

We need to get our `tfstate-backend` component deployed using local state before
we can actually utilize any terraform remote state backend. This is a good
example of the "chicken or the egg problem", so it’s a bit funky but luckily we
only need to do this initial set of steps once for all components per
`environment/aws account`. To get started we need
`to add tfstate-backend component`:

##### **1.** [**`Create terraform component for tfstate-backend`**:](https://github.com/cloudposse/terraform-aws-tfstate-backend/tree/master/examples/complete)

<div>
<img src="../../../../docs/images/stacks.png" width="300"/>
</div>

#### **2.** Terraform plan and apply the `tfstate-backend` component.

```bash
atmos terraform plan tfstate-backend -s {namespace}-{environment}
atmos terraform apply tfstate-backend -s {namespace}-{environment}
```

<div>
<img src="../../../../docs/images/tfstate-plan.png" width="600"/>
</div>
<div>
<img src="../../../../docs/images/tfstate-apply.png" width="600"/>
</div>

This will provision our S3 bucket + Dynamo DB table for usage as our backend.

<details>
<summary>Output of this command:</summary>
<br>

```bash

Variables for the component 'tfstate-backend' in the stack 'accelerator-test-uw2':

enable_server_side_encryption: true
enabled: true
environment: uw2
force_destroy: false
name: tfstate
namespace: accelerator-test
prevent_unencrypted_uploads: true
region: us-west-2

Writing the variables to file:
components/terraform/tfstate-backend/accelerator-test-uw2-tfstate-backend.terraform.tfvars.json

Executing command:
/opt/homebrew/bin/terraform init -reconfigure
Initializing modules...

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/local from the dependency lock file
- Reusing previous version of hashicorp/time from the dependency lock file
- Using previously-installed hashicorp/aws v4.35.0
- Using previously-installed hashicorp/local v2.2.3
- Using previously-installed hashicorp/time v0.9.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

Command info:
Terraform binary: terraform
Terraform command: apply
Arguments and flags: []
Component: tfstate-backend
Stack: accelerator-test-uw2
Working dir: components/terraform/tfstate-backend

Executing command:
/opt/homebrew/bin/terraform workspace select accelerator-test-uw2

Executing command:
/opt/homebrew/bin/terraform apply -var-file accelerator-test-uw2-tfstate-backend.terraform.tfvars.json
module.tfstate_backend.module.log_storage.data.aws_partition.current: Reading...
module.tfstate_backend.data.aws_region.current: Reading...
module.tfstate_backend.module.log_storage.data.aws_caller_identity.current: Reading...
module.tfstate_backend.module.log_storage.data.aws_partition.current: Read complete after 0s [id=aws]
module.tfstate_backend.data.aws_region.current: Read complete after 0s [id=us-west-2]
module.tfstate_backend.data.aws_iam_policy_document.prevent_unencrypted_uploads[0]: Reading...
module.tfstate_backend.data.aws_iam_policy_document.prevent_unencrypted_uploads[0]: Read complete after 0s [id=554604176]
module.tfstate_backend.module.log_storage.data.aws_caller_identity.current: Read complete after 0s [id=222222222222]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.tfstate_backend.aws_dynamodb_table.with_server_side_encryption[0] will be created
  + resource "aws_dynamodb_table" "with_server_side_encryption" {
      + arn              = (known after apply)
      + billing_mode     = "PROVISIONED"
      + hash_key         = "LockID"
      + id               = (known after apply)
      + name             = "accelerator-test-uw2-tfstate-lock"
      + read_capacity    = 5
      + stream_arn       = (known after apply)
      + stream_label     = (known after apply)
      + stream_view_type = (known after apply)
      + tags             = {
          + "Attributes"  = "lock"
          + "Environment" = "uw2"
          + "Name"        = "accelerator-test-uw2-tfstate-lock"
          + "Namespace"   = "accelerator-test"
        }
      + tags_all         = {
          + "Attributes"  = "lock"
          + "Environment" = "uw2"
          + "Name"        = "accelerator-test-uw2-tfstate-lock"
          + "Namespace"   = "accelerator-test"
        }
      + write_capacity   = 5

      + attribute {
          + name = "LockID"
          + type = "S"
        }

      + point_in_time_recovery {
          + enabled = false
        }

      + server_side_encryption {
          + enabled     = true
          + kms_key_arn = (known after apply)
        }

      + ttl {
          + attribute_name = (known after apply)
          + enabled        = (known after apply)
        }
    }

  # module.tfstate_backend.aws_s3_bucket.default[0] will be created
  + resource "aws_s3_bucket" "default" {
      + acceleration_status         = (known after apply)
      + acl                         = "private"
      + arn                         = (known after apply)
      + bucket                      = "accelerator-test-uw2-tfstate"
      + bucket_domain_name          = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "s3:PutObject"
                      + Condition = {
                          + StringNotEquals = {
                              + "s3:x-amz-server-side-encryption" = [
                                  + "AES256",
                                  + "aws:kms",
                                ]
                            }
                        }
                      + Effect    = "Deny"
                      + Principal = {
                          + AWS = "*"
                        }
                      + Resource  = "arn:aws:s3:::accelerator-test-uw2-tfstate/*"
                      + Sid       = "DenyIncorrectEncryptionHeader"
                    },
                  + {
                      + Action    = "s3:PutObject"
                      + Condition = {
                          + Null = {
                              + "s3:x-amz-server-side-encryption" = "true"
                            }
                        }
                      + Effect    = "Deny"
                      + Principal = {
                          + AWS = "*"
                        }
                      + Resource  = "arn:aws:s3:::accelerator-test-uw2-tfstate/*"
                      + Sid       = "DenyUnEncryptedObjectUploads"
                    },
                  + {
                      + Action    = "s3:*"
                      + Condition = {
                          + Bool = {
                              + "aws:SecureTransport" = "false"
                            }
                        }
                      + Effect    = "Deny"
                      + Principal = {
                          + AWS = "*"
                        }
                      + Resource  = [
                          + "arn:aws:s3:::accelerator-test-uw2-tfstate/*",
                          + "arn:aws:s3:::accelerator-test-uw2-tfstate",
                        ]
                      + Sid       = "EnforceTlsRequestsOnly"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags                        = {
          + "Environment" = "uw2"
          + "Name"        = "accelerator-test-uw2-tfstate"
          + "Namespace"   = "accelerator-test"
        }
      + tags_all                    = {
          + "Environment" = "uw2"
          + "Name"        = "accelerator-test-uw2-tfstate"
          + "Namespace"   = "accelerator-test"
        }
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + cors_rule {
          + allowed_headers = (known after apply)
          + allowed_methods = (known after apply)
          + allowed_origins = (known after apply)
          + expose_headers  = (known after apply)
          + max_age_seconds = (known after apply)
        }

      + grant {
          + id          = (known after apply)
          + permissions = (known after apply)
          + type        = (known after apply)
          + uri         = (known after apply)
        }

      + lifecycle_rule {
          + abort_incomplete_multipart_upload_days = (known after apply)
          + enabled                                = (known after apply)
          + id                                     = (known after apply)
          + prefix                                 = (known after apply)
          + tags                                   = (known after apply)

          + expiration {
              + date                         = (known after apply)
              + days                         = (known after apply)
              + expired_object_delete_marker = (known after apply)
            }

          + noncurrent_version_expiration {
              + days = (known after apply)
            }

          + noncurrent_version_transition {
              + days          = (known after apply)
              + storage_class = (known after apply)
            }

          + transition {
              + date          = (known after apply)
              + days          = (known after apply)
              + storage_class = (known after apply)
            }
        }

      + logging {
          + target_bucket = (known after apply)
          + target_prefix = (known after apply)
        }

      + object_lock_configuration {
          + object_lock_enabled = (known after apply)

          + rule {
              + default_retention {
                  + days  = (known after apply)
                  + mode  = (known after apply)
                  + years = (known after apply)
                }
            }
        }

      + replication_configuration {
          + role = (known after apply)

          + rules {
              + delete_marker_replication_status = (known after apply)
              + id                               = (known after apply)
              + prefix                           = (known after apply)
              + priority                         = (known after apply)
              + status                           = (known after apply)

              + destination {
                  + account_id         = (known after apply)
                  + bucket             = (known after apply)
                  + replica_kms_key_id = (known after apply)
                  + storage_class      = (known after apply)

                  + access_control_translation {
                      + owner = (known after apply)
                    }

                  + metrics {
                      + minutes = (known after apply)
                      + status  = (known after apply)
                    }

                  + replication_time {
                      + minutes = (known after apply)
                      + status  = (known after apply)
                    }
                }

              + filter {
                  + prefix = (known after apply)
                  + tags   = (known after apply)
                }

              + source_selection_criteria {
                  + sse_kms_encrypted_objects {
                      + enabled = (known after apply)
                    }
                }
            }
        }

      + server_side_encryption_configuration {
          + rule {
              + apply_server_side_encryption_by_default {
                  + sse_algorithm = "AES256"
                }
            }
        }

      + versioning {
          + enabled    = true
          + mfa_delete = false
        }

      + website {
          + error_document           = (known after apply)
          + index_document           = (known after apply)
          + redirect_all_requests_to = (known after apply)
          + routing_rules            = (known after apply)
        }
    }

  # module.tfstate_backend.aws_s3_bucket_public_access_block.default[0] will be created
  + resource "aws_s3_bucket_public_access_block" "default" {
      + block_public_acls       = true
      + block_public_policy     = true
      + bucket                  = (known after apply)
      + id                      = (known after apply)
      + ignore_public_acls      = true
      + restrict_public_buckets = true
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + tfstate_backend_dynamodb_table_arn    = (known after apply)
  + tfstate_backend_dynamodb_table_id     = (known after apply)
  + tfstate_backend_dynamodb_table_name   = "accelerator-test-uw2-tfstate-lock"
  + tfstate_backend_s3_bucket_arn         = (known after apply)
  + tfstate_backend_s3_bucket_domain_name = (known after apply)
  + tfstate_backend_s3_bucket_id          = (known after apply)
╷
│ Warning: Argument is deprecated
│
│   with module.tfstate_backend.aws_s3_bucket.default,
│   on .terraform/modules/tfstate_backend/main.tf line 156, in resource "aws_s3_bucket" "default":
│  156: resource "aws_s3_bucket" "default" {
│
│ Use the aws_s3_bucket_server_side_encryption_configuration resource instead
│
│ (and 4 more similar warnings elsewhere)
╵

Do you want to perform these actions in workspace "accelerator-test-uw2"?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.tfstate_backend.aws_dynamodb_table.with_server_side_encryption[0]: Creating...
module.tfstate_backend.aws_s3_bucket.default[0]: Creating...
module.tfstate_backend.aws_s3_bucket.default[0]: Creation complete after 4s [id=accelerator-test-uw2-tfstate]
module.tfstate_backend.aws_s3_bucket_public_access_block.default[0]: Creating...
module.tfstate_backend.aws_s3_bucket_public_access_block.default[0]: Creation complete after 0s [id=accelerator-test-uw2-tfstate]
module.tfstate_backend.aws_dynamodb_table.with_server_side_encryption[0]: Creation complete after 8s [id=accelerator-test-uw2-tfstate-lock]
╷
│ Warning: Argument is deprecated
│
│   with module.tfstate_backend.aws_s3_bucket.default[0],
│   on .terraform/modules/tfstate_backend/main.tf line 156, in resource "aws_s3_bucket" "default":
│  156: resource "aws_s3_bucket" "default" {
│
│ Use the aws_s3_bucket_server_side_encryption_configuration resource instead
│
│ (and 3 more similar warnings elsewhere)
╵

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

tfstate_backend_dynamodb_table_arn = "arn:aws:dynamodb:us-west-2:222222222222:table/accelerator-test-uw2-tfstate-lock"
tfstate_backend_dynamodb_table_id = "accelerator-test-uw2-tfstate-lock"
tfstate_backend_dynamodb_table_name = "accelerator-test-uw2-tfstate-lock"
tfstate_backend_s3_bucket_arn = "arn:aws:s3:::accelerator-test-uw2-tfstate"
tfstate_backend_s3_bucket_domain_name = "accelerator-test-uw2-tfstate.s3.amazonaws.com"
tfstate_backend_s3_bucket_id = "accelerator-test-uw2-tfstate"

```

</details>

#### **3.** Based on the output of `tfstate-backend apply` add this block in \_defaults.yaml file and modify it:

- https://github.com/cloudposse/atmos/blob/master/examples/complete/stacks/orgs/cp/\_defaults.yaml

<details>
<summary>Add this block</summary>
<br>

```
backend_type: s3
backend:
  s3:
    encrypt: true
    bucket: "accelerator-test-uw2-tfstate"
    key: "terraform.tfstate"
    dynamodb_table: "accelerator-test-uw2-tfstate-lock"
    acl: "bucket-owner-full-control"
    region: "us-west-2"
    role_arn: null

remote_state_backend:
  s3:
    role_arn: null

```

</details>

#### **4.** Next, let's configure atmos to `auto-generate` backend  configuration for our components:

Set the `auto_generate_backend_file` argument to `true` in atmos.yaml file:

![](../../../../docs/images/atmos.yaml.png)

Run the atmos command to create a `backend.tf.json` file and migrate the state
file to `S3`.

```bash
atmos terraform plan tfstate-backend -s {namespace}-{environment}
```

<div>
<img src="../../../../docs/images/tfstate-plan.png" width="600"/>
</div>

#### This will prompt you with the following:

```
Do you want to migrate all workspaces to "s3"?
Both the existing "local" backend and the newly configured "s3" backend
support workspaces. When migrating between backends, Terraform will copy
all workspaces (with the same names). THIS WILL OVERWRITE any conflicting
states in the destination.

Terraform initialization doesn't currently migrate only select workspaces.
If you want to migrate a select number of workspaces, you must manually
pull and push those states.

If you answer "yes", Terraform will migrate all states. If you answer
"no", Terraform will abort.

Enter a value:

```

Enter **`yes`** and this will migrate our local state to our S3 backend.
Success!

This will look at our stack, find the imported `terraform.backend.s3`
configuration and build a valid `backend.tf.json` file and put it in our
component directory. Then going forward, whenver we `plan` or `apply` against
any component it will be properly configured to use that S3 backend.

<div>
<img src="../../../../docs/images/backend-json.png" width="600"/>
</div>
<br/>

<!-- BEGIN-TERRAFORM-DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9.0 |
| <a name="requirement_awsutils"></a> [awsutils](#requirement\_awsutils) | >= 0.16.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.9.0 |
| <a name="provider_awsutils"></a> [awsutils](#provider\_awsutils) | >= 0.16.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_assume_role"></a> [assume\_role](#module\_assume\_role) | ../account-map/modules/team-assume-role-policy | n/a |
| <a name="module_label"></a> [label](#module\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_tfstate_backend"></a> [tfstate\_backend](#module\_tfstate\_backend) | cloudposse/tfstate-backend/aws | 1.1.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_policy_document.tfstate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [awsutils_caller_identity.current](https://registry.terraform.io/providers/cloudposse/awsutils/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_roles"></a> [access\_roles](#input\_access\_roles) | Map of access roles to create (key is role name, use "default" for same as component). See iam-assume-role-policy module for details. | <pre>map(object({<br>    write_enabled           = bool<br>    allowed_roles           = map(list(string))<br>    denied_roles            = map(list(string))<br>    allowed_principal_arns  = list(string)<br>    denied_principal_arns   = list(string)<br>    allowed_permission_sets = map(list(string))<br>    denied_permission_sets  = map(list(string))<br>  }))</pre> | `{}` | no |
| <a name="input_access_roles_enabled"></a> [access\_roles\_enabled](#input\_access\_roles\_enabled) | Enable creation of access roles. Set false for cold start (before account-map has been created). | `bool` | `true` | no |
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enable_point_in_time_recovery"></a> [enable\_point\_in\_time\_recovery](#input\_enable\_point\_in\_time\_recovery) | Enable DynamoDB point-in-time recovery | `bool` | `true` | no |
| <a name="input_enable_server_side_encryption"></a> [enable\_server\_side\_encryption](#input\_enable\_server\_side\_encryption) | Enable DynamoDB and S3 server-side encryption | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | A boolean that indicates the terraform state S3 bucket can be destroyed even if it contains objects. These objects are not recoverable. | `bool` | `false` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_prevent_unencrypted_uploads"></a> [prevent\_unencrypted\_uploads](#input\_prevent\_unencrypted\_uploads) | Prevent uploads of unencrypted objects to S3 | `bool` | `true` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tfstate_backend_dynamodb_table_arn"></a> [tfstate\_backend\_dynamodb\_table\_arn](#output\_tfstate\_backend\_dynamodb\_table\_arn) | Terraform state DynamoDB table ARN |
| <a name="output_tfstate_backend_dynamodb_table_id"></a> [tfstate\_backend\_dynamodb\_table\_id](#output\_tfstate\_backend\_dynamodb\_table\_id) | Terraform state DynamoDB table ID |
| <a name="output_tfstate_backend_dynamodb_table_name"></a> [tfstate\_backend\_dynamodb\_table\_name](#output\_tfstate\_backend\_dynamodb\_table\_name) | Terraform state DynamoDB table name |
| <a name="output_tfstate_backend_s3_bucket_arn"></a> [tfstate\_backend\_s3\_bucket\_arn](#output\_tfstate\_backend\_s3\_bucket\_arn) | Terraform state S3 bucket ARN |
| <a name="output_tfstate_backend_s3_bucket_domain_name"></a> [tfstate\_backend\_s3\_bucket\_domain\_name](#output\_tfstate\_backend\_s3\_bucket\_domain\_name) | Terraform state S3 bucket domain name |
| <a name="output_tfstate_backend_s3_bucket_id"></a> [tfstate\_backend\_s3\_bucket\_id](#output\_tfstate\_backend\_s3\_bucket\_id) | Terraform state S3 bucket ID |
<!-- END-TERRAFORM-DOCS -->
