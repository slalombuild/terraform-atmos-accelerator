variable "lambda_environment" {
  description = "Environment (e.g. env variables) configuration for the Lambda function enable you to dynamically pass settings to your function code and libraries"
  default     = null
  type = object({
    variables = map(string)
  })
}

variable "handler" {
  description = "The function entrypoint in your code."
  type        = string
}

variable "package_name" {
  description = "The name of the zipped package that houses the Lambda code (ie. ExampleFunction)."
  type        = string
}

variable "runtime" {
  description = "The runtime environment for the Lambda function you are uploading."
  type        = string
}

variable "s3_key" {
  description = "The S3 key of an object containing the function's deployment package. Conflicts with filename and image_uri."
  default     = null
  type        = string
}

variable "s3_bucket_name" {
  type        = string
  description = <<EOF
  The S3 bucket location containing the function's deployment package. Conflicts with filename and image_uri.
  This bucket must reside in the same AWS region where you are creating the Lambda function.
  EOF
  default     = ""
}

variable "region" {
  type        = string
  description = "AWS Region for S3 bucket"
}

variable "security_group_id" {
  type        = list(string)
  default     = null
  description = "The ID of the security group"
}

variable "account_map" {
  type        = map(any)
  description = "Account map of all the available accounts"
}
