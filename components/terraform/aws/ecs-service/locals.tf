## Generic non company specific locals
locals {
  enabled = module.this.enabled

  service_container = lookup(var.containers, "service")
  # Get the first containerPort in var.container["service"]["port_mappings"]
  container_port   = lookup(local.service_container, "port_mappings")[0].containerPort
  assign_public_ip = lookup(var.task, "assign_public_ip", false)

  container_definition = [
    for container in module.container_definition :
    container.json_map_object
  ]

  role_name      = format("%s-%s-%s-role", var.namespace, var.environment, var.name)
  kinesis_kms_id = try(one(data.aws_kms_alias.selected[*].id), null)

  zone_domain = var.domain_name
  full_domain = var.alb_domain_name

  # Grab only namespace, tenant, environment, stage since those will be the common tags across resources of interest in this account
  match_tags = {
    for key, value in module.this.tags :
    key => value
    if contains(["namespace", "tenant", "environment", "stage"], lower(key))
  }

  subnet_match_tags = merge({
    Attributes = local.assign_public_ip ? "public" : "private"
  }, var.subnet_match_tags)

  lb_match_tags   = { Attributes = var.name }
  vpc_id          = try(one(data.aws_vpc.selected[*].id), null)
  vpc_sg_id       = try(one(data.aws_security_group.vpc_default[*].id), null)
  rds_sg_id       = try(one(data.aws_security_group.rds[*].id), null)
  subnet_ids      = try(one(data.aws_subnets.selected[*].ids), null)
  ecs_cluster_arn = try(one(data.aws_ecs_cluster.selected[*].arn), null)

  lb_arn                = try(one(data.aws_lb.selected[*].arn), null)
  lb_name               = try(one(data.aws_lb.selected[*].name), null)
  lb_listener_https_arn = try(one(data.aws_lb_listener.selected_https[*].arn), null)
  lb_sg_id              = try(one(data.aws_security_group.lb[*].id), null)
  lb_zone_id            = try(one(data.aws_lb.selected[*].zone_id), null)
  account_id            = try(one(data.aws_caller_identity.current[*].account_id), null)
}
