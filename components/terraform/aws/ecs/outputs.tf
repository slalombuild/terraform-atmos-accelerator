output "alb" {
  description = "ALB outputs"
  value       = module.alb
}

output "cluster_arn" {
  description = "ECS cluster ARN"
  value       = join("", aws_ecs_cluster.default[*].arn)
}

output "cluster_name" {
  description = "ECS Cluster Name"
  value       = join("", aws_ecs_cluster.default[*].name)
}
