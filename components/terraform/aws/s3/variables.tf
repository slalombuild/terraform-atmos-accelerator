# Variables for S3

variable "region" {
  type = string
}

variable "block_public_acls" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the blocking of new public access lists on the bucket"
}

variable "block_public_policy" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the blocking of new public policies on the bucket"
}

variable "ignore_public_acls" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the ignoring of public access lists on the bucket"
}

variable "restrict_public_buckets" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the restricting of making the bucket public"
}

variable "bucket_key_enabled" {
  type        = bool
  default     = false
  description = <<-EOT
  Set this to true to use Amazon S3 Bucket Keys for SSE-KMS, which reduce the cost of AWS KMS requests.

  For more information, see: https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-key.html
  EOT
}

variable "kms_master_key_id" {
  type        = string
  default     = null
  description = "The AWS KMS master key id used for the `SSE-KMS` encryption. This can only be used when you set the value of `sse_algorithm` as `aws:kms`. The default aws/s3 AWS KMS master key is used if this element is absent while the `sse_algorithm` is `aws:kms`"
}

variable "versioning_enabled" {
  type        = bool
  default     = false
  description = "A state of versioning. Versioning is a means of keeping multiple variants of an object in the same bucket"
}

variable "access_key_enabled" {
  type        = bool
  default     = true
  description = "Set to true to create an IAM Access Key for the created IAM user"
}

variable "account_map" {
  type        = map(any)
  description = "Account map of all the available accounts"
  default     = {}
}

variable "allow_encrypted_uploads_only" {
  type        = bool
  default     = false
  description = "Set to true to prevent uploads of unencrypted objects to S3 bucket"
}

variable "allowed_bucket_actions" {
  type = list(string)
  default = [
    "s3:PutObject",
    "s3:PutObjectAcl",
    "s3:GetObject",
    "s3:ListBucket",
    "s3:ListBucketMultipartUploads",
    "s3:GetBucketLocation",
  ]
  description = "Set to true to prevent uploads of unencrypted objects to S3 bucket"
}

variable "cors_configuration" {
  type = list(object({
    allowed_headers = list(string)
    allowed_methods = list(string)
    allowed_origins = list(string)
    expose_headers  = list(string)
    max_age_seconds = number
  }))
  default     = []
  description = "Specifies the allowed headers, methods, origins and exposed headers when using CORS on this bucket"
}

variable "lifecycle_configuration_rules" {
  type = list(object({
    enabled = bool
    id      = string

    abort_incomplete_multipart_upload_days = number

    # filter_and is the and configuration block inside the filter configuration.
    # This is the only place you should specify a prefix.
    filter_and = any
    expiration = any
    transition = list(any)

    noncurrent_version_expiration = any
    noncurrent_version_transition = list(any)
  }))
  description = "A list of lifecycle V2 rules"
  default     = []
}

variable "logging" {
  type = object({
    bucket_name = string
    prefix      = string
  })
  default     = null
  description = "Bucket access logging configuration."
}

variable "object_lock_configuration" {
  type = object({
    mode  = string # Valid values are GOVERNANCE and COMPLIANCE.
    days  = number
    years = number
  })
  description = "	A configuration for S3 object locking. With S3 Object Lock, you can store objects using a write once, read many (WORM) model. Object Lock can help prevent objects from being deleted or overwritten for a fixed amount of time or indefinitely."
  default     = null
}

variable "privileged_principal_actions" {
  type        = list(string)
  default     = []
  description = "List of actions to permit privileged_principal_arns to perform on bucket and bucket prefixes (see privileged_principal_arns)"
}

variable "privileged_principal_arns" {
  type        = list(map(list(string)))
  description = "List of maps. Each map has a key, an IAM Principal ARN, whose associated value is a list of S3 path prefixes to grant privileged_principal_actions permissions for that principal,in addition to the bucket itself, which is automatically included. Prefixes should not begin with '/'."
  default     = []
}

variable "s3_object_ownership" {
  description = "Specifies the S3 object ownership control. Valid values are ObjectWriter, BucketOwnerPreferred, and 'BucketOwnerEnforced'. Defaults to 'ObjectWriter' for backwards compatibility, but we recommend setting 'BucketOwnerEnforced' instead.\n"
  type        = string
  default     = "ObjectWriter"
}


variable "s3_replica_bucket_arn" {
  type        = string
  description = "A single S3 bucket ARN to use for all replication rules.Note: The destination bucket can be specified in the replication rule itself(which allows for multiple destinations), in which case it will take precedence over this variable."
  default     = ""
}


variable "s3_replication_permissions_boundary_arn" {
  type        = string
  description = "Permissions boundary ARN for the created IAM replication role."
  default     = null
}

variable "s3_replication_rules" {
  type        = list(any)
  default     = null
  description = "Specifies the replication rules for S3 bucket replication if enabled. You must also set s3_replication_enabled to true."
}

variable "s3_replication_source_roles" {
  type        = list(string)
  description = "Cross-account IAM Role ARNs that will be allowed to perform S3 replication to this bucket (for replication within the same AWS account, it's not necessary to adjust the bucket policy)."
  default     = []
}

variable "source_policy_documents" {
  type        = list(string)
  default     = []
  description = "List of IAM policy documents that are merged together into the exported document.Statements defined in source_policy_documents or source_json must have unique SIDs.Statement having SIDs that match policy SIDs generated by this module will override them."
}

variable "sse_algorithm" {
  description = "The server-side encryption algorithm."
  type        = string
  default     = "AES256"
}


variable "s3_replication_enabled" {
  type        = bool
  default     = false
  description = "Set this to true and specify s3_replication_rules to enable replication. versioning_enabled must also be true."
}


variable "ssm_base_path" {
  type        = string
  description = "	The base path for SSM parameters where created IAM user's access key is stored"
  default     = "/s3_user/"
}

variable "store_access_key_in_ssm" {
  type        = bool
  default     = false
  description = "Set to true to store the created IAM user's access key in SSM Parameter Store,false to store them in Terraform state as outputs.Since Terraform state would contain the secrets in plaintext,use of SSM Parameter Store is recommended."
}

variable "user_permissions_boundary_arn" {
  type        = string
  description = "Permission boundary ARN for the IAM user created to access the bucket."
  default     = null
}

variable "website_configuration" {
  type = list(object({
    index_document = string
    error_document = string
    routing_rules = list(object({
      condition = object({
        http_error_code_returned_equals = string
        key_prefix_equals               = string
      })
      redirect = object({
        host_name               = string
        http_redirect_code      = string
        protocol                = string
        replace_key_prefix_with = string
        replace_key_with        = string
      })
    }))
  }))
  description = "Specifies the static website hosting configuration object"
  default     = []
}
