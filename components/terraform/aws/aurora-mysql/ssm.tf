locals {
  admin_user_parameters = [
    {
      name        = local.mysql_admin_user_key
      value       = local.mysql_admin_user
      description = "Aurora MySQL DB admin user"
      type        = "String"
      overwrite   = true
    },
    {
      name        = local.mysql_admin_password_key
      value       = local.mysql_admin_password
      description = "Aurora MySQL DB admin password"
      type        = "SecureString"
      overwrite   = true
    }
  ]
  cluster_parameters = var.mysql_cluster_size > 0 ? [
    {
      name        = format("%s/%s", local.ssm_path_prefix, "replicas_hostname")
      value       = module.aurora_mysql.replicas_host
      description = "Aurora MySQL DB Replicas hostname"
      type        = "String"
      overwrite   = true
    },
  ] : []
  default_parameters = [
    {
      name        = format("%s/%s", local.ssm_path_prefix, "cluster_domain")
      value       = local.cluster_domain
      description = "AWS DNS name under which DB instances are provisioned"
      type        = "String"
      overwrite   = true
    },
    {
      name        = format("%s/%s", local.ssm_path_prefix, "db_host")
      value       = module.aurora_mysql.master_host
      description = "Aurora MySQL DB Master hostname"
      type        = "String"
      overwrite   = true
    },
    {
      name        = format("%s/%s", local.ssm_path_prefix, "db_port")
      value       = "3306"
      description = "Aurora MySQL DB Master TCP port"
      type        = "String"
      overwrite   = true
    },
    {
      name        = format("%s/%s", local.ssm_path_prefix, "cluster_name")
      value       = module.aurora_mysql.cluster_identifier
      description = "Aurora MySQL DB Cluster Identifier"
      type        = "String"
      overwrite   = true
    }
  ]
  mysql_admin_password_key = format("%s/%s/%s", local.ssm_path_prefix, "admin", "password")
  mysql_admin_user_key     = format("%s/%s/%s", local.ssm_path_prefix, "admin", "user")
  parameter_write          = local.mysql_db_enabled ? concat(local.default_parameters, local.cluster_parameters, local.admin_user_parameters) : concat(local.default_parameters, local.cluster_parameters)
  ssm_path_prefix          = format("/%s/%s", var.ssm_path_prefix, module.cluster.id)
}

data "aws_ssm_parameter" "password" {
  count = local.fetch_admin_password ? 1 : 0

  name            = format(var.ssm_password_source, local.mysql_admin_user)
  with_decryption = true
}

module "parameter_store_write" {
  source  = "cloudposse/ssm-parameter-store/aws"
  version = "0.11.0"

  # kms_arn will only be used for SecureString parameters
  kms_arn = module.kms_key_rds.key_arn

  parameter_write = local.parameter_write

  context = module.cluster.context
}
