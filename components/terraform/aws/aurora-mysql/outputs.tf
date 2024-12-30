output "aurora_mysql_cluster_arn" {
  description = "The ARN of Aurora cluster"
  value       = module.aurora_mysql.arn
}

output "aurora_mysql_cluster_id" {
  description = "The ID of Aurora cluster"
  value       = module.cluster.id
}

output "aurora_mysql_cluster_name" {
  description = "Aurora MySQL cluster identifier"
  value       = local.enabled ? module.aurora_mysql.cluster_identifier : null
}

output "aurora_mysql_endpoint" {
  description = "Aurora MySQL endpoint"
  value       = local.enabled ? module.aurora_mysql.endpoint : null
}

output "aurora_mysql_master_hostname" {
  description = "Aurora MySQL DB master hostname"
  value       = local.enabled ? module.aurora_mysql.master_host : null
}

output "aurora_mysql_master_password" {
  description = "Location of admin password in SSM"
  sensitive   = true
  value       = local.mysql_db_enabled ? "Password for admin user ${module.aurora_mysql.master_username} is stored in SSM at ${local.mysql_admin_password_key}" : null
}

output "aurora_mysql_master_password_ssm_key" {
  description = "SSM key for admin password"
  value       = local.mysql_db_enabled ? local.mysql_admin_password_key : null
}

output "aurora_mysql_master_username" {
  description = "Aurora MySQL username for the master DB user"
  sensitive   = true
  value       = local.enabled ? module.aurora_mysql.master_username : null
}

output "aurora_mysql_reader_endpoint" {
  description = "Aurora MySQL reader endpoint"
  value       = local.enabled ? module.aurora_mysql.reader_endpoint : null
}

output "aurora_mysql_replicas_hostname" {
  description = "Aurora MySQL replicas hostname"
  value       = local.enabled ? module.aurora_mysql.replicas_host : null
}

output "cluster_domain" {
  description = "Cluster DNS name"
  value       = local.cluster_domain
}

output "kms_key_arn" {
  description = "KMS key ARN for Aurora MySQL"
  value       = module.kms_key_rds.key_arn
}
