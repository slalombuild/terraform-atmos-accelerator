output "cluster_arn" {
  value       = join("", aws_ecs_cluster.default[*].arn)
  description = "ECS cluster ARN"
}

output "cluster_name" {
  value       = join("", aws_ecs_cluster.default[*].name)
  description = "ECS Cluster Name"
}

output "alb" {
  value       = module.alb
  description = "ALB outputs"
}

