variable "github_scope" {
  type        = string
  description = "Scope of the runner (e.g. `cloudposse/example` for repo or `cloudposse` for org)"
}

variable "max_size" {
  type        = number
  description = "The maximum size of the autoscale group"
}

variable "min_size" {
  type        = number
  description = "The minimum size of the autoscale group"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "account_map_environment_name" {
  type        = string
  default     = "gbl"
  description = "The name of the environment where `account_map` is provisioned"
}

variable "account_map_stage_name" {
  type        = string
  default     = "root"
  description = "The name of the stage where `account_map` is provisioned"
}

variable "account_map_tenant_name" {
  type        = string
  default     = null
  description = <<-EOT
  The name of the tenant where `account_map` is provisioned.

  If the `tenant` label is not used, leave this as `null`.
  EOT
}

variable "ami_filter" {
  type = map(list(string))
  default = {
    name = ["amzn2-ami-hvm-2.*-x86_64-ebs"]
  }
  description = "Map of lists used to look up the AMI which will be used for the GitHub Actions Runner."
}

variable "ami_owners" {
  type        = list(string)
  default     = ["amazon"]
  description = "The list of owners used to select the AMI of action runner instances."
}

variable "block_device_mappings" {
  type = list(object({
    device_name  = string
    no_device    = bool
    virtual_name = string
    ebs = object({
      delete_on_termination = bool
      encrypted             = bool
      iops                  = number
      kms_key_id            = string
      snapshot_id           = string
      volume_size           = number
      volume_type           = string
    })
  }))
  default     = []
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"
}

variable "cpu_utilization_high_evaluation_periods" {
  type        = number
  default     = 2
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "cpu_utilization_high_period_seconds" {
  type        = number
  default     = 300
  description = "The period in seconds over which the specified statistic is applied"
}

variable "cpu_utilization_high_threshold_percent" {
  type        = number
  default     = 90
  description = "The value against which the specified statistic is compared"
}

variable "cpu_utilization_low_evaluation_periods" {
  type        = number
  default     = 2
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "cpu_utilization_low_period_seconds" {
  type        = number
  default     = 300
  description = "The period in seconds over which the specified statistic is applied"
}

variable "cpu_utilization_low_threshold_percent" {
  type        = number
  default     = 10
  description = "The value against which the specified statistic is compared"
}

variable "default_cooldown" {
  type        = number
  default     = 300
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
}

variable "docker_compose_version" {
  type        = string
  default     = "1.29.2"
  description = "The version of docker-compose to install"
}

variable "instance_type" {
  type        = string
  default     = "m5.large"
  description = "Default instance type for the action runner."
}

variable "max_instance_lifetime" {
  type        = number
  default     = null
  description = "The maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 604800 and 31536000 seconds"
}

variable "mixed_instances_policy" {
  type = object({
    instances_distribution = object({
      on_demand_allocation_strategy            = string
      on_demand_base_capacity                  = number
      on_demand_percentage_above_base_capacity = number
      spot_allocation_strategy                 = string
      spot_instance_pools                      = number
      spot_max_price                           = string
    })
    override = list(object({
      instance_type     = string
      weighted_capacity = number
    }))
  })
  default     = null
  description = "Policy to use a mixed group of on-demand/spot of differing types. Launch template is automatically generated. https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html#mixed_instances_policy-1"
}

variable "runner_group" {
  type        = string
  default     = "default"
  description = "GitHub runner group"
}

variable "runner_labels" {
  type        = list(string)
  default     = []
  description = "List of labels to add to the GitHub Runner (e.g. 'Amazon Linux 2')."
}

variable "runner_role_additional_policy_arns" {
  type        = list(string)
  default     = []
  description = "List of policy ARNs that will be attached to the runners' default role on creation in addition to the defaults"
}

variable "runner_version" {
  type        = string
  default     = "2.288.1"
  description = "GitHub runner release version"
}

variable "scale_down_cooldown_seconds" {
  type        = number
  default     = 300
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start"
}

variable "ssm_parameter_name_format" {
  type        = string
  default     = "/%s/%s"
  description = "SSM parameter name format"
}

variable "ssm_path" {
  type        = string
  default     = "github"
  description = "GitHub token SSM path"
}

variable "ssm_path_key" {
  type        = string
  default     = "registration-token"
  description = "GitHub token SSM path key"
}

variable "userdata_post_install" {
  type        = string
  default     = ""
  description = "Shell script to run post installation of github action runner"
}

variable "userdata_pre_install" {
  type        = string
  default     = ""
  description = "Shell script to run before installation of github action runner"
}

variable "wait_for_capacity_timeout" {
  type        = string
  default     = "10m"
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior"
}
