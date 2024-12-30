variable "account_name" {
  type        = string
  description = "AWS Account name"
}

variable "account_number" {
  type        = string
  description = "The account number for the assume role"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "account-number" {
  type        = string
  default     = ""
  description = "The aws account number to where to deploy the services"
}

variable "alb_domain_name" {
  type        = string
  default     = null
  description = "The full CNAME record for the ALB"
}

variable "authenticated_paths" {
  type        = list(string)
  default     = []
  description = "Authenticated path pattern to match (a maximum of 1 can be defined)"
}

variable "authenticated_priority" {
  type        = number
  default     = null
  description = "The priority for the rules with authentication, between 1 and 50000 (1 being highest priority). Must be different from `unauthenticated_priority` since a listener can't have multiple rules with the same priority"
}

variable "authentication_oidc_authorization_endpoint" {
  type        = string
  default     = ""
  description = "OIDC Authorization Endpoint"
}

variable "authentication_oidc_client_id" {
  type        = string
  default     = ""
  description = "OIDC Client ID"
}

variable "authentication_oidc_client_secret" {
  type        = string
  default     = ""
  description = "OIDC Client Secret"
}

variable "authentication_oidc_issuer" {
  type        = string
  default     = ""
  description = "OIDC Issuer"
}

variable "authentication_oidc_token_endpoint" {
  type        = string
  default     = ""
  description = "OIDC Token Endpoint"
}

variable "authentication_oidc_user_info_endpoint" {
  type        = string
  default     = ""
  description = "OIDC User Info Endpoint"
}

variable "authentication_type" {
  type        = string
  default     = ""
  description = "Authentication type. Supported values are `COGNITO` and `OIDC`"
}

variable "cluster_attributes" {
  type        = list(string)
  default     = []
  description = "The attributes of the cluster name e.g. if the full name is `namespace-tenant-environment-dev-ecs-b2b` then the `cluster_name` is `ecs` and this value should be `b2b`."
}

variable "cluster_full_name" {
  type        = string
  default     = ""
  description = "The fully qualified name of the cluster. This will override the `cluster_suffix`."
}

variable "cluster_name" {
  type        = string
  default     = "ecs"
  description = "The name of the cluster"
}

variable "containers" {
  type        = any
  default     = {}
  description = "Feed inputs into container definition module"
}

variable "domain_name" {
  type        = string
  default     = ""
  description = "The domain name to use as the host header suffix"
}

variable "ecr_region" {
  type        = string
  default     = ""
  description = "The region to use for the fully qualified ECR image URL. Defaults to the current region."
}

variable "iam_policy_enabled" {
  type        = bool
  default     = false
  description = "If set to true will create IAM policy in AWS"
}

variable "iam_policy_statements" {
  type        = any
  default     = {}
  description = "Map of IAM policy statements to use in the policy. This can be used with or instead of the `var.iam_source_json_url`."
}

variable "kinesis_enabled" {
  type        = bool
  default     = false
  description = "Enable Kinesis"
}

variable "kms_key_alias" {
  type        = string
  default     = "default"
  description = "ID of KMS key"
}

variable "logs" {
  type        = any
  default     = {}
  description = "Feed inputs into cloudwatch logs module"
}

variable "retention_period_hours" {
  type        = number
  default     = 48
  description = "Length of time data records are accessible after they are added to the stream"
}

variable "shard_count" {
  type        = number
  default     = 1
  description = "Number of shards that the stream will use"
}

variable "shard_level_metrics" {
  type = set(string)
  default = [
    "IncomingBytes",
    "IncomingRecords",
    "IteratorAgeMilliseconds",
    "OutgoingBytes",
    "OutgoingRecords",
    "ReadProvisionedThroughputExceeded",
    "WriteProvisionedThroughputExceeded",
  ]
  description = "List of shard-level CloudWatch metrics which can be enabled for the stream"
}

variable "stream_mode" {
  type        = string
  default     = "PROVISIONED"
  description = "Stream mode details for the Kinesis stream"
}

variable "subnet_match_tags" {
  type        = map(string)
  default     = {}
  description = "The additional matching tags for the VPC subnet data source. Used with current namespace, tenant, env, and stage tags."
}

variable "task" {
  type        = any
  default     = {}
  description = "Feed inputs into ecs_alb_service_task module"
}

variable "task_enabled" {
  type        = bool
  default     = true
  description = "Whether or not to use the ECS task module"
}

variable "task_policy_arns" {
  type = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess",
  ]
  description = "The IAM policy ARNs to attach to the ECS task IAM role"
}

variable "unauthenticated_paths" {
  type        = list(string)
  default     = []
  description = "Unauthenticated path pattern to match (a maximum of 1 can be defined)"
}

variable "unauthenticated_priority" {
  type        = number
  default     = 0
  description = "The priority for the rules without authentication, between 1 and 50000 (1 being highest priority). Must be different from `authenticated_priority` since a listener can't have multiple rules with the same priority"
}

variable "use_lb" {
  type        = bool
  default     = false
  description = "Whether use load balancer for the service"
}

variable "use_rds_client_sg" {
  type        = bool
  default     = false
  description = "Use the RDS client security group"
}

variable "vpc_name" {
  type        = string
  default     = "vpc"
  description = "The name of the vpc, if multiples vpc are defined in the same aws account make sure to enter only the value of var.name of the selected vpc to use"
}
