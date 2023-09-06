# See https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-swagger-extensions.html for additional 
# configuration information.
variable "openapi_config" {
  description = "The OpenAPI specification for the API"
  type        = any
  default     = null
}

variable "endpoint_type" {
  type        = string
  description = "The type of the endpoint. One of - PUBLIC, PRIVATE, REGIONAL"
  default     = "REGIONAL"

  validation {
    condition     = contains(["EDGE", "REGIONAL", "PRIVATE"], var.endpoint_type)
    error_message = "Valid values for var: endpoint_type are (EDGE, REGIONAL, PRIVATE)."
  }
}

variable "logging_level" {
  type        = string
  description = "The logging level of the API. One of - OFF, INFO, ERROR"
  default     = "INFO"

  validation {
    condition     = contains(["OFF", "INFO", "ERROR"], var.logging_level)
    error_message = "Valid values for var: logging_level are (OFF, INFO, ERROR)."
  }
}

variable "metrics_enabled" {
  description = "A flag to indicate whether to enable metrics collection."
  type        = bool
  default     = false
}

variable "xray_tracing_enabled" {
  description = "A flag to indicate whether to enable X-Ray tracing."
  type        = bool
  default     = false
}

# See https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-logging.html for additional information
# on how to configure logging.
variable "access_log_format" {
  description = "The format of the access log file."
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
}

# See https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-resource-policies.html for additional
# information on how to configure resource policies.
#
# Example:
# {
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Effect": "Allow",
#            "Principal": "*",
#            "Action": "execute-api:Invoke",
#            "Resource": "arn:aws:execute-api:us-east-1:000000000000:*"
#        },
#        {
#            "Effect": "Deny",
#            "Principal": "*",
#            "Action": "execute-api:Invoke",
#            "Resource": "arn:aws:execute-api:region:account-id:*",
#            "Condition": {
#                "NotIpAddress": {
#                    "aws:SourceIp": "123.4.5.6/24"
#                }
#            }
#        }
#    ]
#}

variable "rest_api_policy" {
  description = "The IAM policy document for the API."
  type        = any
  default     = null
}

variable "private_link_target_arns" {
  type        = list(string)
  description = "A list of target ARNs for VPC Private Link"
  default     = []
}

variable "iam_tags_enabled" {
  type        = string
  description = "Enable/disable tags on IAM roles and policies"
  default     = true
}

variable "permissions_boundary" {
  type        = string
  default     = ""
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
}

variable "iam_role_arn" {
  type        = string
  description = "ARN of the IAM role for API Gateway to use. If not specified, a new role will be created."
  default     = null
}

variable "stage_name" {
  type        = string
  default     = ""
  description = "The name of the stage"
}

variable "api_gateway_account_settings_enabled" {
  type        = bool
  default     = false
  description = "Enable/disable CloudWatch Api gateway account settings. This is required to log any api gateway requests"
}

# variables that are passing to the calling module
variable "open_api_file_name" {
  type        = string
  description = "OpenApidoc name for API Gateway integration"
  default     = ""
}

variable "lambda_function_names" {
  type        = set(string)
  default     = []
  description = "Add ApiGateway permission to call lambda:InvokeFunction "
}

variable "region" {
  type        = string
  description = "AWS Region for the Provider to make the deployments"
}

variable "account_map" {
  type        = map(any)
  description = "Account map of all the available accounts"
}
