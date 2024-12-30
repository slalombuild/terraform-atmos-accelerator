variable "account_name" {
  type        = string
  description = "AWS Account name"
}

variable "account_number" {
  type        = string
  description = "The account number for the assume role"
}

variable "ami_name" {
  type        = string
  description = "AMI name"
}

variable "ami_owner" {
  type        = string
  description = "AMI owner"
}

variable "assign_eip_address" {
  type        = bool
  description = "Assign an Elastic IP address to the instance"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address with the instance"
}

variable "instance_type" {
  type        = string
  description = "The type of the instance"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "security_group_rules" {
  type        = list(any)
  description = <<-EOT
    A list of maps of Security Group rules.
    The values of map is fully complated with `aws_security_group_rule` resource.
    To get more info see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule .
  EOT
}

variable "custom_managed_policies" {
  type        = list(string)
  default     = []
  description = "User defined policies list of AWS managed policies"
}

variable "delete_on_termination" {
  type        = bool
  default     = true
  description = "Whether the volume should be destroyed on instance termination"
}

variable "device_encrypted" {
  type        = bool
  default     = true
  description = "Whether to encrypt the root block device"
}

variable "device_kms_key_id" {
  type        = string
  default     = null
  description = "KMS key ID used to encrypt EBS volume. When specifying root_block_device_kms_key_id, root_block_device_encrypted needs to be set to true"
}

variable "iops" {
  type        = number
  default     = 0
  description = "Amount of provisioned IOPS. This must be set if root_volume_type is set of `io1`, `io2` or `gp3`"
}

variable "metadata_http_endpoint_enabled" {
  type        = bool
  default     = true
  description = "Whether the metadata service is available"
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  default     = 2
  description = "The desired HTTP PUT response hop limit (between 1 and 64) for instance metadata requests."
}

variable "metadata_http_tokens_required" {
  type        = bool
  default     = true
  description = "Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2."
}

variable "metadata_tags_enabled" {
  type        = bool
  default     = false
  description = "Whether the tags are enabled in the metadata service."
}

variable "ssh_ingress_cidrs" {
  type        = list(string)
  default     = ["10.0.0.0/8"]
  description = "List of CIDR blocks to allow SSH ingress"
}

variable "throughput" {
  type        = number
  default     = 0
  description = "Amount of throughput. This must be set if root_volume_type is set to `gp3`"
}

variable "userdata_file" {
  type        = string
  default     = ""
  description = "The userdata script name from component/asg/userdata to use for the instances"
}

variable "volume_size" {
  type        = number
  default     = 8
  description = "Size of the root volume in gigabytes"
}

variable "volume_type" {
  type        = string
  default     = "gp2"
  description = "Type of root volume. Can be standard, gp2, gp3, io1 or io2"
}

variable "vpc_name" {
  type        = string
  default     = "vpc"
  description = "The name of the vpc, if multiples vpc are defined in the same aws account make sure to enter only the value of var.name of the selected vpc to use"
}
