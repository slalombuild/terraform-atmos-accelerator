variable "region" {
  type        = string
  description = "AWS Region for the Provider to make the deployments"
}

# See https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-logging.html for additional information
# on how to configure logging.
variable "access_log_format" {
  type        = string
  default     = <<EOF
  {
	"requestTime": "$context.requestTime",
	"requestId": "$context.requestId",
	"httpMethod": "$context.httpMethod",
	"path": "$context.path",
	"resourcePath": "$context.resourcePath",
	"status": $context.status,
	"responseLatency": $context.responseLatency,
  "xrayTraceId": "$context.xrayTraceId",
  "integrationRequestId": "$context.integration.requestId",
	"functionResponseStatus": "$context.integration.status",
  "integrationLatency": "$context.integration.latency",
	"integrationServiceStatus": "$context.integration.integrationStatus",
  "authorizeResultStatus": "$context.authorize.status",
	"authorizerServiceStatus": "$context.authorizer.status",
	"authorizerLatency": "$context.authorizer.latency",
	"authorizerRequestId": "$context.authorizer.requestId",
  "ip": "$context.identity.sourceIp",
	"userAgent": "$context.identity.userAgent",
	"principalId": "$context.authorizer.principalId",
	"cognitoUser": "$context.identity.cognitoIdentityId",
  "user": "$context.identity.user"
}
  EOF
  description = "The format of the access log file."
}

variable "api_gateway_account_settings_enabled" {
  type        = bool
  default     = false
  description = "Enable/disable CloudWatch Api gateway account settings. This is required to log any api gateway requests"
}

variable "endpoint_type" {
  type        = string
  default     = "REGIONAL"
  description = "The type of the endpoint. One of - PUBLIC, PRIVATE, REGIONAL"

  validation {
    condition     = contains(["EDGE", "REGIONAL", "PRIVATE"], var.endpoint_type)
    error_message = "Valid values for var: endpoint_type are (EDGE, REGIONAL, PRIVATE)."
  }
}

variable "iam_role_arn" {
  type        = string
  default     = null
  description = "ARN of the IAM role for API Gateway to use. If not specified, a new role will be created."
}

variable "iam_tags_enabled" {
  type        = string
  default     = true
  description = "Enable/disable tags on IAM roles and policies"
}

variable "lambda_function_names" {
  type        = set(string)
  default     = []
  description = "Add ApiGateway permission to call lambda:InvokeFunction "
}

variable "logging_level" {
  type        = string
  default     = "INFO"
  description = "The logging level of the API. One of - OFF, INFO, ERROR"

  validation {
    condition     = contains(["OFF", "INFO", "ERROR"], var.logging_level)
    error_message = "Valid values for var: logging_level are (OFF, INFO, ERROR)."
  }
}

variable "metrics_enabled" {
  type        = bool
  default     = false
  description = "A flag to indicate whether to enable metrics collection."
}

# variables that are passing to the calling module
variable "open_api_file_name" {
  type        = string
  default     = ""
  description = "OpenApidoc name for API Gateway integration"
}

# See https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-swagger-extensions.html for additional
# configuration information.
variable "openapi_config" {
  type        = any
  default     = null
  description = "The OpenAPI specification for the API"
}

variable "permissions_boundary" {
  type        = string
  default     = ""
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
}

variable "private_link_target_arns" {
  type        = list(string)
  default     = []
  description = "A list of target ARNs for VPC Private Link"
}

variable "rest_api_policy" {
  type        = any
  default     = null
  description = "The IAM policy document for the API."
}

variable "stage_name" {
  type        = string
  default     = ""
  description = "The name of the stage"
}

variable "xray_tracing_enabled" {
  type        = bool
  default     = false
  description = "A flag to indicate whether to enable X-Ray tracing."
}
