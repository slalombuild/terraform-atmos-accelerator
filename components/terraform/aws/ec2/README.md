# Component: **ec2-instance**

This component is responsible for provisioning a general purpose EC2 host.

## Usage

**Stack Level**: Regional

The following will create:

- Automatically creates a Security Group
- Option to switch EIP attachment
- CloudWatch monitoring and automatic reboot if instance hangs
- Assume Role capability

Here's an example snippet for how to use this component in the root stack e.i.
`dev/us-east-2.yaml`:

```yaml
components:
  terraform:
    ec2/change-me:
      metadata:
        component: ec2
        type: real
        inherits:
          - ec2/defaults
      vars:
        name: "ec2-test"
```

When you have configurations that you want to share across various stacks, use
service `catalogs`. By convention, all shared configurations for stacks catalogs
are in the `stacks/catalog/` folder, which can then be used in the root
`stacks/` stack files via import. These files use the same stack schema.

This is an example snippet for how to use this component in a service catalog
file `stack/catalog/ec2/defaults.yaml`

```yaml
# stacks/catalog/ec2/defaults.yaml
components:
  terraform:
    ec2/defaults:
      metadata:
        component: ec2
        type: abstract
      vars:
        name: ec2
        tags:
          component: "ec2"
          expense-class: "compute"
        associate_public_ip_address: false
        instance_type: t3.micro
        availability_zones: ["us-east-2a", "us-east-2b", "us-east-2c"]
        assign_eip_address: false
        egress_cidrs: ["0.0.0.0/0"]
        ssh_ingress_cidrs: ["10.0.0.0/8"]
        custom_managed_policies: []
        ami_name: "CentOS-7-2111-20220825_1.x86_64-*"
        ami_owner: "679593333241"
        volume_type: gp2
        volume_size: 10
        iops: null
        throughput: null
        delete_on_termination: true
        device_encrypted: true
        device_kms_key_id: null
        metadata_http_tokens_required: true
        metadata_http_endpoint_enabled: true
        metadata_tags_enabled: false
        metadata_http_put_response_hop_limit: 2
        security_group_rules: []

```

Perform the following commands on the root folder:

- `atmos terraform plan ec2 -s {namespace}-{environment}` to see the
  infrastructure execution plan
- `atmos terraform apply ec2 -s {namespace}-{environment}` to execute the action
  proposed at terraform plan
- `atmos terraform destroy ec2 -s {namespace}-{environment}` to destroy all
  remote objects

<!-- BEGIN-TERRAFORM-DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2_instance"></a> [ec2\_instance](#module\_ec2\_instance) | cloudposse/ec2-instance/aws | 0.48.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.iam_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.managed_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_icmp_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_ssh_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.outbound_internet_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ami.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | AWS Account name | `string` | n/a | yes |
| <a name="input_account_number"></a> [account\_number](#input\_account\_number) | The account number for the assume role | `string` | n/a | yes |
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_ami_name"></a> [ami\_name](#input\_ami\_name) | AMI name | `string` | n/a | yes |
| <a name="input_ami_owner"></a> [ami\_owner](#input\_ami\_owner) | AMI owner | `string` | n/a | yes |
| <a name="input_assign_eip_address"></a> [assign\_eip\_address](#input\_assign\_eip\_address) | Assign an Elastic IP address to the instance | `bool` | n/a | yes |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Associate a public IP address with the instance | `bool` | n/a | yes |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_custom_managed_policies"></a> [custom\_managed\_policies](#input\_custom\_managed\_policies) | User defined policies list of AWS managed policies | `list(string)` | `[]` | no |
| <a name="input_delete_on_termination"></a> [delete\_on\_termination](#input\_delete\_on\_termination) | Whether the volume should be destroyed on instance termination | `bool` | `true` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_device_encrypted"></a> [device\_encrypted](#input\_device\_encrypted) | Whether to encrypt the root block device | `bool` | `true` | no |
| <a name="input_device_kms_key_id"></a> [device\_kms\_key\_id](#input\_device\_kms\_key\_id) | KMS key ID used to encrypt EBS volume. When specifying root\_block\_device\_kms\_key\_id, root\_block\_device\_encrypted needs to be set to true | `string` | `null` | no |
| <a name="input_egress_cidrs"></a> [egress\_cidrs](#input\_egress\_cidrs) | Egress cidr to allow the instance to connect to | `list(string)` | `[]` | no |
| <a name="input_enable_instance_icmp"></a> [enable\_instance\_icmp](#input\_enable\_instance\_icmp) | whether to create ICMP role | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of the instance | `string` | n/a | yes |
| <a name="input_iops"></a> [iops](#input\_iops) | Amount of provisioned IOPS. This must be set if root\_volume\_type is set of `io1`, `io2` or `gp3` | `number` | `0` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_metadata_http_endpoint_enabled"></a> [metadata\_http\_endpoint\_enabled](#input\_metadata\_http\_endpoint\_enabled) | Whether the metadata service is available | `bool` | `true` | no |
| <a name="input_metadata_http_put_response_hop_limit"></a> [metadata\_http\_put\_response\_hop\_limit](#input\_metadata\_http\_put\_response\_hop\_limit) | The desired HTTP PUT response hop limit (between 1 and 64) for instance metadata requests. | `number` | `2` | no |
| <a name="input_metadata_http_tokens_required"></a> [metadata\_http\_tokens\_required](#input\_metadata\_http\_tokens\_required) | Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2. | `bool` | `true` | no |
| <a name="input_metadata_tags_enabled"></a> [metadata\_tags\_enabled](#input\_metadata\_tags\_enabled) | Whether the tags are enabled in the metadata service. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | A list of maps of Security Group rules. <br>The values of map is fully complated with `aws_security_group_rule` resource. <br>To get more info see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule . | `list(any)` | n/a | yes |
| <a name="input_ssh_ingress_cidrs"></a> [ssh\_ingress\_cidrs](#input\_ssh\_ingress\_cidrs) | List of CIDR blocks to allow SSH ingress | `list(string)` | <pre>[<br>  "10.0.0.0/8"<br>]</pre> | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_throughput"></a> [throughput](#input\_throughput) | Amount of throughput. This must be set if root\_volume\_type is set to `gp3` | `number` | `0` | no |
| <a name="input_userdata_file"></a> [userdata\_file](#input\_userdata\_file) | The userdata script name from component/asg/userdata to use for the instances | `string` | `""` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Size of the root volume in gigabytes | `number` | `8` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | Type of root volume. Can be standard, gp2, gp3, io1 or io2 | `string` | `"gp2"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the vpc, if multiples vpc are defined in the same aws account make sure to enter only the value of var.name of the selected vpc to use | `string` | `"vpc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_eni_ids"></a> [additional\_eni\_ids](#output\_additional\_eni\_ids) | Map of ENI to EIP |
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the instance |
| <a name="output_ebs_ids"></a> [ebs\_ids](#output\_ebs\_ids) | IDs of EBSs |
| <a name="output_id"></a> [id](#output\_id) | Disambiguated ID of the instance |
| <a name="output_name"></a> [name](#output\_name) | Instance name |
| <a name="output_primary_network_interface_id"></a> [primary\_network\_interface\_id](#output\_primary\_network\_interface\_id) | ID of the instance's primary network interface |
| <a name="output_private_dns"></a> [private\_dns](#output\_private\_dns) | Private DNS of instance |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Private IP of instance |
| <a name="output_public_dns"></a> [public\_dns](#output\_public\_dns) | Public DNS of instance (or DNS of EIP) |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Public IP of instance (or EIP) |
| <a name="output_role"></a> [role](#output\_role) | Name of AWS IAM Role associated with the instance |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | EC2 instance Security Group ARN |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | EC2 instance Security Group ID |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | IDs on the AWS Security Groups associated with the instance |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | EC2 instance Security Group name |
| <a name="output_ssh_key_pair"></a> [ssh\_key\_pair](#output\_ssh\_key\_pair) | Name of the SSH key pair provisioned on the instance |
<!-- END-TERRAFORM-DOCS -->
