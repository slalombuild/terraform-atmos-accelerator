output "container_definition" {
  description = "Output of container definition module"
  value       = local.container_definition
}

output "ecs_cluster_arn" {
  description = "Selected ECS cluster ARN"
  value       = local.ecs_cluster_arn
}

output "full_domain" {
  description = "Domain to respond to GET requests"
  value       = local.full_domain
}

output "lb_arn" {
  description = "Selected LB ARN"
  value       = local.lb_arn
}

output "lb_listener_https" {
  description = "Selected LB HTTPS Listener"
  value       = local.lb_listener_https_arn
}

output "lb_sg_id" {
  description = "Selected LB SG ID"
  value       = local.lb_sg_id
}

output "logs" {
  description = "Output of cloudwatch logs module"
  value       = module.logs
}

output "subnet_ids" {
  description = "Selected subnet IDs"
  value       = local.subnet_ids
}

output "task" {
  description = "Output of service task module"
  value       = module.ecs_alb_service_task
}

output "vpc_id" {
  description = "Selected VPC ID"
  value       = local.vpc_id
}

output "vpc_sg_id" {
  description = "Selected VPC SG ID"
  value       = local.vpc_sg_id
}
