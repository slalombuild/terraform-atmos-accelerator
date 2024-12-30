variable "autoscaling_group_name" {
  type        = string
  description = "The name of the Auto Scaling Group to create the lifecycle hook for."
}

variable "command" {
  type        = string
  description = "Command to run on EC2 instance shutdown."
}
