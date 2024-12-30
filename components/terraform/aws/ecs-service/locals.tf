## Generic non company specific locals
locals {
  account_id       = try(one(data.aws_caller_identity.current[*].account_id), null)
  assign_public_ip = lookup(var.task, "assign_public_ip", false)
  container_definition = [
    for container in module.container_definition :
    container.json_map_object
  ]
  # Get the first containerPort in var.container["service"]["port_mappings"]
  container_port        = lookup(local.service_container, "port_mappings")[0].containerPort
  ecs_cluster_arn       = try(one(data.aws_ecs_cluster.selected[*].arn), null)
  enabled               = module.this.enabled
  full_domain           = var.alb_domain_name
  kinesis_kms_id        = try(one(data.aws_kms_alias.selected[*].id), null)
  lb_arn                = try(one(data.aws_lb.selected[*].arn), null)
  lb_listener_https_arn = try(one(data.aws_lb_listener.selected_https[*].arn), null)
  lb_match_tags         = { Attributes = var.name }
  lb_sg_id              = try(one(data.aws_security_group.lb[*].id), null)
  # Grab only namespace, tenant, environment, stage since those will be the common tags across resources of interest in this account
  match_tags = {
    for key, value in module.this.tags :
    key => value
    if contains(["namespace", "tenant", "environment", "stage"], lower(key))
  }
  rds_sg_id         = try(one(data.aws_security_group.rds[*].id), null)
  service_container = lookup(var.containers, "service")
  subnet_ids        = try(one(data.aws_subnets.selected[*].ids), null)
  subnet_match_tags = merge({
    Attributes = local.assign_public_ip ? "public" : "private"
  }, var.subnet_match_tags)
  vpc_id      = try(one(data.aws_vpc.selected[*].id), null)
  vpc_sg_id   = try(one(data.aws_security_group.vpc_default[*].id), null)
  zone_domain = var.domain_name
}
