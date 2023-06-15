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

variable "region" {
  type        = string
  description = "AWS Region for S3 bucket"
}

variable "vpc_name" {
  type        = string
  description = "The name of the vpc, if multiples vpc are defined in the same aws account make sure to enter only the value of var.name of the selected vpc to use"
  default     = "vpc"
}

variable "security_group_id" {
  type        = list(string)
  default     = null
  description = "The ID of the security group"
}

variable "account_number" {
  type        = string
  description = "The account number for the assume role"
}

variable "account_name" {
  type        = string
  description = "AWS Account name"
}
