variable "region" {
  type        = string
  description = "AWS Region"
}

variable "dynamodb_component_name" {
  type        = string
  default     = "gitops/dynamodb"
  description = "The name of the dynamodb component used to store Terraform state"
}

variable "dynamodb_environment_name" {
  type        = string
  default     = null
  description = "The name of the dynamodb environment used to store Terraform state"
}

variable "s3_bucket_component_name" {
  type        = string
  default     = "gitops/s3-bucket"
  description = "The name of the s3_bucket component used to store Terraform state"
}

variable "s3_bucket_environment_name" {
  type        = string
  default     = null
  description = "The name of the s3_bucket environment used to store Terraform state"
}
