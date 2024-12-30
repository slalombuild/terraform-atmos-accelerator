# Component: **vpc**

## Diagram

![alt text](../../../docs/accelerator-vpc.png)

## About

This module creates the networking resources along with its dependencies. The
module creates the following:

- VPCs
- Subnets
- NACLs
- Route Tables
- Internet Gateway
- NAT Gateway
- Endpoints with Security Group for each endpoint
- Flow Logs for VPC along with S3 bucket to store the Flow Logs.

Enables VPC Endpoints

- S3
- Dynamodb
- EC2
- ECS (fargate and ECR)
- SSM
- Secret manager
- Api gateway
- Kinesis
- SQS
- ECR API
- ECR DKR

<!-- BEGIN-TERRAFORM-DOCS -->
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
| <a name="module_ec2_vpc_endpoint_sg_label"></a> [ec2\_vpc\_endpoint\_sg\_label](#module\_ec2\_vpc\_endpoint\_sg\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_ecr_api_vpc_endpoint_sg_label"></a> [ecr\_api\_vpc\_endpoint\_sg\_label](#module\_ecr\_api\_vpc\_endpoint\_sg\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_ecr_dkr_vpc_endpoint_sg_label"></a> [ecr\_dkr\_vpc\_endpoint\_sg\_label](#module\_ecr\_dkr\_vpc\_endpoint\_sg\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_ecs_vpc_endpoint_sg_label"></a> [ecs\_vpc\_endpoint\_sg\_label](#module\_ecs\_vpc\_endpoint\_sg\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_execute_api_vpc_endpoint_sg_label"></a> [execute\_api\_vpc\_endpoint\_sg\_label](#module\_execute\_api\_vpc\_endpoint\_sg\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_flow_logs"></a> [flow\_logs](#module\_flow\_logs) | cloudposse/vpc-flow-logs-s3-bucket/aws | 1.0.1 |
| <a name="module_kinesis_vpc_endpoint_sg_label"></a> [kinesis\_vpc\_endpoint\_sg\_label](#module\_kinesis\_vpc\_endpoint\_sg\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_secretsmanager_vpc_endpoint_sg_label"></a> [secretsmanager\_vpc\_endpoint\_sg\_label](#module\_secretsmanager\_vpc\_endpoint\_sg\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_sqs_vpc_endpoint_sg_label"></a> [sqs\_vpc\_endpoint\_sg\_label](#module\_sqs\_vpc\_endpoint\_sg\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_ssm_vpc_endpoint_sg_label"></a> [ssm\_vpc\_endpoint\_sg\_label](#module\_ssm\_vpc\_endpoint\_sg\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_subnets"></a> [subnets](#module\_subnets) | cloudposse/dynamic-subnets/aws | 2.3.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | cloudposse/vpc/aws | 2.1.0 |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | cloudposse/vpc/aws//modules/vpc-endpoints | v1.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route.private_vpn_tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_security_group.ec2_vpc_endpoint_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ecr_api_vpc_endpoint_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ecr_dkr_vpc_endpoint_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ecs_vpc_endpoint_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.execute_api_vpc_endpoint_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.kinesis_vpc_endpoint_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.secretsmanager_vpc_endpoint_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sqs_vpc_endpoint_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ssm_vpc_endpoint_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_endpoint_route_table_association.dynamodb_gateway_vpc_endpoint_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.s3_gateway_vpc_endpoint_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_map"></a> [account\_map](#input\_account\_map) | Account map of all the available accounts | `map(any)` | `{}` | no |
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_allow_ssl_requests_only"></a> [allow\_ssl\_requests\_only](#input\_allow\_ssl\_requests\_only) | Set to `true` to require requests to use Secure Socket Layer (HTTPS/SSL). This will explicitly deny access to HTTP requests | `bool` | `true` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of Availability Zones (AZs) where subnets will be created. Ignored when `availability_zone_ids` is set.<br>The order of zones in the list ***must be stable*** or else Terraform will continually make changes.<br>If no AZs are specified, then `max_subnet_count` AZs will be selected in alphabetical order.<br>If `max_subnet_count > 0` and `length(var.availability_zones) > max_subnet_count`, the list<br>will be truncated. We recommend setting `availability_zones` and `max_subnet_count` explicitly as constant<br>(not computed) values for predictability, consistency, and stability. | `list(string)` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enable_vpc_endpoints"></a> [enable\_vpc\_endpoints](#input\_enable\_vpc\_endpoints) | To enable or disable the creation of the VPC endpoint. Used mostly for VPC changes and redeploy | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_expiration_days"></a> [expiration\_days](#input\_expiration\_days) | Number of days after which to expunge the objects | `number` | `90` | no |
| <a name="input_flow_log_enabled"></a> [flow\_log\_enabled](#input\_flow\_log\_enabled) | Enable/disable the Flow Log creation. Useful in multi-account environments where the bucket is in one account, but VPC Flow Logs are in different accounts | `bool` | `true` | no |
| <a name="input_glacier_transition_days"></a> [glacier\_transition\_days](#input\_glacier\_transition\_days) | Number of days after which to move the data to the glacier storage tier | `number` | `60` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_ipv4_cidrs"></a> [ipv4\_cidrs](#input\_ipv4\_cidrs) | Lists of CIDRs to assign to subnets. Order of CIDRs in the lists must not change over time.<br>Lists may contain more CIDRs than needed. | <pre>list(object({<br>    private = list(string)<br>    public  = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_ipv4_primary_cidr_block"></a> [ipv4\_primary\_cidr\_block](#input\_ipv4\_primary\_cidr\_block) | The primary IPv4 CIDR block for the VPC.<br>Either `ipv4_primary_cidr_block` or `ipv4_primary_cidr_block_association` must be set, but not both. | `string` | n/a | yes |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_lifecycle_rule_enabled"></a> [lifecycle\_rule\_enabled](#input\_lifecycle\_rule\_enabled) | Enable lifecycle events on this bucket | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_nat_gateway_enabled"></a> [nat\_gateway\_enabled](#input\_nat\_gateway\_enabled) | Set `true` to create NAT Gateways to perform IPv4 NAT and NAT64 as needed.<br>Defaults to `true` unless `nat_instance_enabled` is `true`. | `bool` | n/a | yes |
| <a name="input_noncurrent_version_expiration_days"></a> [noncurrent\_version\_expiration\_days](#input\_noncurrent\_version\_expiration\_days) | Specifies when noncurrent object versions expire | `number` | `90` | no |
| <a name="input_noncurrent_version_transition_days"></a> [noncurrent\_version\_transition\_days](#input\_noncurrent\_version\_transition\_days) | Specifies when noncurrent object versions transitions | `number` | `30` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where the provider will operate. | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_standard_transition_days"></a> [standard\_transition\_days](#input\_standard\_transition\_days) | Number of days to persist in the standard storage tier before moving to the infrequent access tier | `number` | `30` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_traffic_type"></a> [traffic\_type](#input\_traffic\_type) | The type of traffic to capture. Valid values: `ACCEPT`, `REJECT`, `ALL` | `string` | `"ALL"` | no |
| <a name="input_transit_gateway_id"></a> [transit\_gateway\_id](#input\_transit\_gateway\_id) | Id of the transit gateway to route VPN traffic to | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_cidr_blocks"></a> [additional\_cidr\_blocks](#output\_additional\_cidr\_blocks) | A list of the additional IPv4 CIDR blocks associated with the VPC |
| <a name="output_additional_cidr_blocks_to_association_ids"></a> [additional\_cidr\_blocks\_to\_association\_ids](#output\_additional\_cidr\_blocks\_to\_association\_ids) | A map of the additional IPv4 CIDR blocks to VPC CIDR association IDs |
| <a name="output_additional_ipv6_cidr_blocks"></a> [additional\_ipv6\_cidr\_blocks](#output\_additional\_ipv6\_cidr\_blocks) | A list of the additional IPv4 CIDR blocks associated with the VPC |
| <a name="output_additional_ipv6_cidr_blocks_to_association_ids"></a> [additional\_ipv6\_cidr\_blocks\_to\_association\_ids](#output\_additional\_ipv6\_cidr\_blocks\_to\_association\_ids) | A map of the additional IPv4 CIDR blocks to VPC CIDR association IDs |
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | List of Availability Zones where subnets were created |
| <a name="output_igw_id"></a> [igw\_id](#output\_igw\_id) | The ID of the Internet Gateway |
| <a name="output_ipv6_cidr_block_network_border_group"></a> [ipv6\_cidr\_block\_network\_border\_group](#output\_ipv6\_cidr\_block\_network\_border\_group) | The IPv6 Network Border Group Zone name |
| <a name="output_ipv6_egress_only_igw_id"></a> [ipv6\_egress\_only\_igw\_id](#output\_ipv6\_egress\_only\_igw\_id) | The ID of the egress-only Internet Gateway |
| <a name="output_nat_gateway_ids"></a> [nat\_gateway\_ids](#output\_nat\_gateway\_ids) | IDs of the NAT Gateways created |
| <a name="output_nat_ips"></a> [nat\_ips](#output\_nat\_ips) | Elastic IP Addresses in use by NAT |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | IDs of the created private route tables |
| <a name="output_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#output\_private\_subnet\_cidrs) | IPv4 CIDR blocks of the created private subnets |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | IDs of the created private subnets |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | IDs of the created public route tables |
| <a name="output_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#output\_public\_subnet\_cidrs) | IPv4 CIDR blocks of the created public subnets |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | IDs of the created public subnets |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | The ARN of the VPC |
| <a name="output_vpc_cidr"></a> [vpc\_cidr](#output\_vpc\_cidr) | The primary IPv4 CIDR block of the VPC |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The primary IPv4 CIDR block of the VPC |
| <a name="output_vpc_default_network_acl_id"></a> [vpc\_default\_network\_acl\_id](#output\_vpc\_default\_network\_acl\_id) | The ID of the network ACL created by default on VPC creation |
| <a name="output_vpc_default_route_table_id"></a> [vpc\_default\_route\_table\_id](#output\_vpc\_default\_route\_table\_id) | The ID of the route table created by default on VPC creation |
| <a name="output_vpc_default_security_group_id"></a> [vpc\_default\_security\_group\_id](#output\_vpc\_default\_security\_group\_id) | The ID of the security group created by default on VPC creation |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vpc_ipv6_association_id"></a> [vpc\_ipv6\_association\_id](#output\_vpc\_ipv6\_association\_id) | The association ID for the primary IPv6 CIDR block |
| <a name="output_vpc_ipv6_cidr_block"></a> [vpc\_ipv6\_cidr\_block](#output\_vpc\_ipv6\_cidr\_block) | The primary IPv6 CIDR block |
| <a name="output_vpc_main_route_table_id"></a> [vpc\_main\_route\_table\_id](#output\_vpc\_main\_route\_table\_id) | The ID of the main route table associated with this VPC |
<!-- END-TERRAFORM-DOCS -->
