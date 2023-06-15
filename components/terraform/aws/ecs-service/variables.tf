variable "region" {
  type        = string
  description = "AWS Region"
}

variable "cluster_attributes" {
  type        = list(string)
  description = "The attributes of the cluster name e.g. if the full name is `namespace-tenant-environment-dev-ecs-b2b` then the `cluster_name` is `ecs` and this value should be `b2b`."
  default     = []
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
  default     = "ecs"
}

variable "cluster_full_name" {
  type        = string
  description = "The fully qualified name of the cluster. This will override the `cluster_suffix`."
  default     = ""
}

variable "account-number" {
  type        = string
  description = "The aws account number to where to deploy the services"
  default     = ""
}

variable "logs" {
  type        = any
  description = "Feed inputs into cloudwatch logs module"
  default     = {}
}

variable "containers" {
  type        = any
  description = "Feed inputs into container definition module"
  default     = {}
}

variable "task" {
  type        = any
  description = "Feed inputs into ecs_alb_service_task module"
  default     = {}
}

variable "task_policy_arns" {
  type        = list(string)
  description = "The IAM policy ARNs to attach to the ECS task IAM role"
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess",
  ]
}

variable "domain_name" {
  type        = string
  description = "The domain name to use as the host header suffix"
  default     = ""
}

variable "public_lb_enabled" {
  type        = bool
  description = "Whether or not to use public LB and public subnets"
  default     = false
}

variable "task_enabled" {
  type        = bool
  description = "Whether or not to use the ECS task module"
  default     = true
}

variable "ecr_stage_name" {
  type        = string
  description = "The ecr stage (account) name to use for the fully qualified ECR image URL."
  default     = "auto"
}

variable "ecr_region" {
  type        = string
  description = "The region to use for the fully qualified ECR image URL. Defaults to the current region."
  default     = ""
}

variable "account_stage" {
  type        = string
  description = "The ecr stage (account) name to use for the fully qualified stage parameter store."
  default     = "auto"
}

variable "iam_policy_statements" {
  type        = any
  description = "Map of IAM policy statements to use in the policy. This can be used with or instead of the `var.iam_source_json_url`."
  default     = {}
}

variable "iam_policy_enabled" {
  type        = bool
  description = "If set to true will create IAM policy in AWS"
  default     = false
}

variable "vanity_alias" {
  type        = list(string)
  description = "The vanity aliases to use for the public LB."
  default     = []
}

variable "kinesis_enabled" {
  type        = bool
  description = "Enable Kinesis"
  default     = false
}

variable "shard_count" {
  description = "Number of shards that the stream will use"
  default     = "1"
}

variable "retention_period" {
  description = "Length of time data records are accessible after they are added to the stream"
  default     = "48"
}

variable "shard_level_metrics" {
  description = "List of shard-level CloudWatch metrics which can be enabled for the stream"

  default = [
    "IncomingBytes",
    "IncomingRecords",
    "IteratorAgeMilliseconds",
    "OutgoingBytes",
    "OutgoingRecords",
    "ReadProvisionedThroughputExceeded",
    "WriteProvisionedThroughputExceeded",
  ]
}

variable "kms_key_alias" {
  description = "ID of KMS key"
  default     = "default"
}

variable "use_lb" {
  description = "Whether use load balancer for the service"
  default     = false
  type        = bool
}

variable "stream_mode" {
  description = "Stream mode details for the Kinesis stream"
  default     = "PROVISIONED"
  type        = string
}

variable "use_rds_client_sg" {
  type        = bool
  description = "Use the RDS client security group"
  default     = false
}

variable "ecs_service_enabled" {
  default     = true
  type        = bool
  description = "Whether to create the ECS service"
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

variable "authenticated_priority" {
  type        = number
  default     = null
  description = "The priority for the rules with authentication, between 1 and 50000 (1 being highest priority). Must be different from `unauthenticated_priority` since a listener can't have multiple rules with the same priority"
}

variable "authenticated_paths" {
  type        = list(string)
  default     = []
  description = "Authenticated path pattern to match (a maximum of 1 can be defined)"
}

variable "authenticated_hosts" {
  type        = list(string)
  default     = []
  description = "Authenticated hosts to match in Hosts header"
}

variable "unauthenticated_listener_arns" {
  type        = list(string)
  default     = []
  description = "A list of unauthenticated ALB listener ARNs to attach ALB listener rules to"
}

variable "authenticated_listener_arns" {
  type        = list(string)
  default     = []
  description = "A list of authenticated ALB listener ARNs to attach ALB listener rules to"
}

variable "authentication_type" {
  type        = string
  default     = ""
  description = "Authentication type. Supported values are `COGNITO` and `OIDC`"
}


variable "authentication_oidc_client_id" {
  type        = string
  description = "OIDC Client ID"
  default     = ""
}

variable "authentication_oidc_client_secret" {
  type        = string
  description = "OIDC Client Secret"
  default     = ""
}

variable "authentication_oidc_issuer" {
  type        = string
  description = "OIDC Issuer"
  default     = ""
}

variable "authentication_oidc_authorization_endpoint" {
  type        = string
  description = "OIDC Authorization Endpoint"
  default     = ""
}

variable "authentication_oidc_token_endpoint" {
  type        = string
  description = "OIDC Token Endpoint"
  default     = ""
}

variable "authentication_oidc_user_info_endpoint" {
  type        = string
  description = "OIDC User Info Endpoint"
  default     = ""
}

variable "authentication_oidc_scope" {
  type        = string
  description = "OIDC scope, which should be a space separated string of requested scopes (see https://openid.net/specs/openid-connect-core-1_0.html#ScopeClaims, and https://developers.google.com/identity/protocols/oauth2/openid-connect#scope-param for an example set of scopes when using Google as the IdP)"
  default     = null
}

variable "authentication_oidc_on_unauthenticated_request" {
  type        = string
  description = "OIDC unauthenticated behavior, deny, allow, or authenticate"
  default     = "authenticate"
}

variable "authentication_oidc_request_extra_params" {
  type        = map(string)
  description = "OIDC query parameters to include in redirect request"
  default     = null
}

variable "alb_domain_name" {
  type        = string
  description = "The full CNAME record for the ALB"
  default     = null

}
variable "account_number" {
  type        = string
  description = "The account number for the assume role"
}

variable "account_name" {
  type        = string
  description = "AWS Account name"
}

variable "vpc_name" {
  type        = string
  default     = "vpc"
  description = "The name of the vpc, if multiples vpc are defined in the same aws account make sure to enter only the value of var.name of the selected vpc to use"
}

variable "vpc_match_tags" {
  type        = map(any)
  description = "The additional matching tags for the VPC data source. Used with current namespace, tenant, env, and stage tags."
  default     = {}
}

variable "subnet_match_tags" {
  type        = map(string)
  description = "The additional matching tags for the VPC subnet data source. Used with current namespace, tenant, env, and stage tags."
  default     = {}
}

variable "lb_match_tags" {
  type        = map(string)
  description = "The additional matching tags for the LB data source. Used with current namespace, tenant, env, and stage tags."
  default     = {}
}
