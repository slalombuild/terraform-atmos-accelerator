variable "region" {
  type        = string
  description = "AWS Region for S3 bucket"
}

variable "architectures" {
  type        = list(string)
  default     = null
  description = <<EOF
    Instruction set architecture for your Lambda function. Valid values are ["x86_64"] and ["arm64"].
    Default is ["x86_64"]. Removing this attribute, function's architecture stay the same.
  EOF
}

variable "cloudwatch_lambda_insights_enabled" {
  type        = bool
  default     = true
  description = "Enable CloudWatch Lambda Insights for the Lambda Function."
}

variable "cloudwatch_logs_kms_key_arn" {
  type        = string
  default     = null
  description = "The ARN of the KMS Key to use when encrypting log data."
}

variable "cloudwatch_logs_retention_in_days" {
  type        = number
  default     = 90
  description = <<EOF
  Specifies the number of days you want to retain log events in the specified log group. Possible values are:
  1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the
  log group are always retained and never expire.
  EOF
}

variable "custom_iam_policy_arns" {
  type        = set(string)
  default     = []
  description = "ARNs of custom policies to be attached to the lambda role"
}

variable "dead_letter_config_target_arn" {
  type        = string
  default     = null
  description = <<EOF
  ARN of an SNS topic or SQS queue to notify when an invocation fails. If this option is used, the function's IAM role
  must be granted suitable access to write to the target object, which means allowing either the sns:Publish or
  sqs:SendMessage action on this ARN, depending on which service is targeted."
  EOF
}

variable "default_sg_enabled" {
  type        = bool
  default     = false
  description = "Enable default SG egress for lambda function"
}

variable "description" {
  type        = string
  default     = null
  description = "Description of what the Lambda Function does."
}

variable "ephemeral_storage_size" {
  type        = number
  default     = null
  description = <<EOF
  The size of the Lambda function Ephemeral storage (/tmp) represented in MB.
  The minimum supported ephemeral_storage value defaults to 512MB and the maximum supported value is 10240MB.
  EOF
}

variable "filename" {
  type        = string
  default     = ""
  description = "The path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options and image_uri cannot be used."
}

variable "function_name" {
  type        = string
  default     = ""
  description = "Unique name for the Lambda Function."
}

variable "handler" {
  type        = string
  default     = null
  description = "The function entrypoint in your code."
}

variable "iam_policy_description" {
  type        = string
  default     = "Provides minimum SSM read permissions."
  description = "Description of the IAM policy for the Lambda IAM role"
}

variable "image_config" {
  type        = any
  default     = {}
  description = <<EOF
  The Lambda OCI [image configurations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function#image_config)
  block with three (optional) arguments:
  - *entry_point* - The ENTRYPOINT for the docker image (type `list(string)`).
  - *command* - The CMD for the docker image (type `list(string)`).
  - *working_directory* - The working directory for the docker image (type `string`).
  EOF
}

variable "image_uri" {
  type        = string
  default     = null
  description = "The ECR image URI containing the function's deployment package. Conflicts with filename, s3_bucket, s3_key, and s3_object_version."
}

variable "kms_key_arn" {
  type        = string
  default     = ""
  description = <<EOF
  Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables.
  If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key.
  If this configuration is provided when environment variables are not in use, the AWS Lambda API does not save this
  configuration and Terraform will show a perpetual difference of adding the key. To fix the perpetual difference,
  remove this configuration.
  EOF
}

variable "lambda_at_edge_enabled" {
  type        = bool
  default     = false
  description = "Enable Lambda@Edge for your Node.js or Python functions. The required trust relationship and publishing of function versions will be configured in this module."
}

variable "lambda_environment" {
  type = object({
    variables = map(string)
  })
  default     = null
  description = "Environment (e.g. env variables) configuration for the Lambda function enable you to dynamically pass settings to your function code and libraries."
}

variable "layers" {
  type        = list(string)
  default     = []
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to the Lambda Function."
}

variable "memory_size" {
  type        = number
  default     = 128
  description = "Amount of memory in MB the Lambda Function can use at runtime."
}

variable "package_type" {
  type        = string
  default     = "Zip"
  description = "The Lambda deployment package type. Valid values are Zip and Image."
}

variable "permissions_boundary" {
  type        = string
  default     = ""
  description = "ARN of the policy that is used to set the permissions boundary for the role"
}

variable "publish" {
  type        = bool
  default     = false
  description = "Whether to publish creation/change as new Lambda Function Version."
}

variable "reserved_concurrent_executions" {
  type        = number
  default     = -1
  description = "The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations."
}

variable "runtime" {
  type        = string
  default     = null
  description = "The runtime environment for the Lambda function you are uploading."
}

variable "s3_bucket" {
  type        = string
  default     = null
  description = <<EOF
  The S3 bucket location containing the function's deployment package. Conflicts with filename and image_uri.
  This bucket must reside in the same AWS region where you are creating the Lambda function.
  EOF
}

variable "s3_bucket_access_enabled" {
  type        = bool
  default     = true
  description = "Enable access to the provided s3 bucket with default access policy"
}

variable "s3_key" {
  type        = string
  default     = null
  description = "The S3 key of an object containing the function's deployment package. Conflicts with filename and image_uri."
}

variable "s3_object_version" {
  type        = string
  default     = null
  description = "The object version containing the function's deployment package. Conflicts with filename and image_uri."
}

variable "source_code_hash" {
  type        = string
  default     = ""
  description = <<EOF
  Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either
  filename or s3_key. The usual way to set this is filebase64sha256('file.zip') where 'file.zip' is the local filename
  of the lambda function source archive.
  EOF
}

variable "ssm_parameter_names" {
  type        = list(string)
  default     = null
  description = <<EOF
  List of AWS Systems Manager Parameter Store parameter names. The IAM role of this Lambda function will be enhanced
  with read permissions for those parameters. Parameters must start with a forward slash and can be encrypted with the
  default KMS key.
  EOF
}

variable "timeout" {
  type        = number
  default     = 120
  description = "The amount of time the Lambda Function has to run in seconds."
}

variable "tracing_config_mode" {
  type        = string
  default     = "Active"
  description = "Tracing config mode of the Lambda function. Can be either PassThrough or Active."
}

variable "vpc_config" {
  type = object({
    security_group_ids = list(string)
    subnet_ids         = list(string)
  })
  default     = null
  description = <<EOF
  Provide this to allow your function to access your VPC (if both 'subnet_ids' and 'security_group_ids' are empty then
  vpc_config is considered to be empty or unset, see https://docs.aws.amazon.com/lambda/latest/dg/vpc.html for details).
  EOF
}
