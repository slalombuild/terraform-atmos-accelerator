module "autoscale_group" {
  source  = "cloudposse/ec2-autoscale-group/aws"
  version = "0.39.0"

  image_id                    = local.image_id
  instance_type               = var.instance_type
  instance_market_options     = var.instance_market_options
  mixed_instances_policy      = var.mixed_instances_policy
  subnet_ids                  = local.subnet_ids
  security_group_ids          = concat([aws_security_group.asg.id], var.security_group_ids)
  load_balancers              = var.load_balancers
  target_group_arns           = concat(local.target_group_arns, var.target_group_arns)
  health_check_type           = var.health_check_type
  min_size                    = var.min_size
  max_size                    = var.max_size
  wait_for_capacity_timeout   = var.wait_for_capacity_timeout
  associate_public_ip_address = var.associate_public_ip_address
  user_data_base64            = local.userdata
  # Disabling in the meantime for testing
  metadata_http_tokens_required           = var.metadata_http_tokens_required
  metadata_instance_metadata_tags_enabled = var.metadata_instance_metadata_tags_enabled
  iam_instance_profile_name               = aws_iam_instance_profile.iam_profile.name

  # Auto-scaling policies and CloudWatch metric alarms
  autoscaling_policies_enabled           = var.autoscaling_policies_enabled
  cpu_utilization_high_threshold_percent = var.cpu_utilization_high_threshold_percent
  cpu_utilization_low_threshold_percent  = var.cpu_utilization_low_threshold_percent

  block_device_mappings = var.block_device_mappings

  # Additional variables:
  key_name                                = var.key_name
  launch_template_version                 = var.launch_template_version
  enable_monitoring                       = var.enable_monitoring
  update_default_version                  = var.update_default_version
  ebs_optimized                           = var.ebs_optimized
  instance_refresh                        = var.instance_refresh
  placement                               = var.placement
  credit_specification                    = var.credit_specification
  elastic_gpu_specifications              = var.elastic_gpu_specifications
  disable_api_termination                 = var.disable_api_termination
  default_cooldown                        = var.default_cooldown
  health_check_grace_period               = var.health_check_grace_period
  force_delete                            = var.force_delete
  termination_policies                    = var.termination_policies
  suspended_processes                     = var.suspended_processes
  placement_group                         = var.placement_group
  metrics_granularity                     = var.metrics_granularity
  enabled_metrics                         = var.enabled_metrics
  min_elb_capacity                        = var.min_elb_capacity
  wait_for_elb_capacity                   = var.wait_for_elb_capacity
  protect_from_scale_in                   = var.protect_from_scale_in
  service_linked_role_arn                 = var.service_linked_role_arn
  scale_up_cooldown_seconds               = var.scale_up_cooldown_seconds
  scale_up_scaling_adjustment             = var.scale_up_scaling_adjustment
  scale_up_adjustment_type                = var.scale_up_adjustment_type
  scale_up_policy_type                    = var.scale_up_policy_type
  scale_down_cooldown_seconds             = var.scale_down_cooldown_seconds
  scale_down_scaling_adjustment           = var.scale_down_scaling_adjustment
  scale_down_adjustment_type              = var.scale_down_adjustment_type
  scale_down_policy_type                  = var.scale_down_policy_type
  cpu_utilization_high_evaluation_periods = var.cpu_utilization_high_evaluation_periods
  cpu_utilization_high_period_seconds     = var.cpu_utilization_high_period_seconds
  cpu_utilization_high_statistic          = var.cpu_utilization_high_statistic
  cpu_utilization_low_evaluation_periods  = var.cpu_utilization_low_evaluation_periods
  cpu_utilization_low_period_seconds      = var.cpu_utilization_low_period_seconds
  cpu_utilization_low_statistic           = var.cpu_utilization_low_statistic
  desired_capacity                        = var.desired_capacity
  default_alarms_enabled                  = var.default_alarms_enabled
  custom_alarms                           = var.custom_alarms
  metadata_http_endpoint_enabled          = var.metadata_http_endpoint_enabled
  metadata_http_put_response_hop_limit    = var.metadata_http_put_response_hop_limit
  metadata_http_protocol_ipv6_enabled     = var.metadata_http_protocol_ipv6_enabled
  tag_specifications_resource_types       = var.tag_specifications_resource_types
  capacity_rebalance                      = var.capacity_rebalance
  warm_pool                               = var.warm_pool
  max_instance_lifetime                   = var.max_instance_lifetime
  instance_initiated_shutdown_behavior    = var.instance_initiated_shutdown_behavior

  context = module.this.context
}

