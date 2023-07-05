variable "project_id" {
  type        = string
  description = "The ID of the existing GCP project where the GCS bucket will be deployed."
}

variable "function_location" {
  type        = string
  description = "The location of this cloud function"
}

variable "description" {
  type        = string
  description = "Short description of the function"
  default     = null
}

variable "docker_repository" {
  type        = string
  description = "User managed repository created in Artifact Registry optionally with a customer managed encryption key."
  default     = null
}

variable "entrypoint" {
  type        = string
  description = "The name of the function (as defined in source code) that will be executed. Defaults to the resource name suffix, if not specified"
}

variable "runtime" {
  description = "The runtime in which to run the function."
  type        = string
}

variable "event_trigger" {
  description = "Event triggers for the function"
  type = object({
    trigger_region        = optional(string, null),
    event_type            = string,
    service_account_email = string,
    pubsub_topic          = optional(string, null),
    retry_policy          = string,
    event_filters = optional(set(object({
      attribute       = string
      attribute_value = string
      operator        = optional(string)
    })), null)
  })
  default = null
}

variable "members" {
  description = "Cloud Function Invoker and Developer roles for Users/SAs. Key names must be developers and/or invokers"
  type        = map(list(string))
  default     = {}
}

variable "service_config" {
  description = "Details of the service"
  type = object({
    max_instance_count    = optional(string, 100),
    min_instance_count    = optional(string, 1),
    available_memory      = optional(string, "256M"),
    timeout_seconds       = optional(string, 60),
    runtime_env_variables = optional(map(string), null),
    runtime_secret_env_variables = optional(set(object({
      key_name   = string,
      project_id = optional(string, null),
      secret     = string,
      version    = string
    })), null),
    secret_volumes = optional(set(object({
      mount_path = string,
      project_id = optional(string, null),
      secret     = string,
      versions = set(object({
        version = string,
        path    = string
      }))
    })), null),
    vpc_connector                  = optional(string, null),
    vpc_connector_egress_settings  = optional(string, null),
    ingress_settings               = optional(string, null),
    service_account_email          = optional(string, null),
    all_traffic_on_latest_revision = optional(bool, true)
  })
  default = {}
}

variable "worker_pool" {
  description = "Name of the Cloud Build Custom Worker Pool that should be used to build the function."
  type        = string
  default     = null
}

variable "bucket_source_enabled" {
  description = "whether to use cloud storage bucket as the sorce to cloud function"
  type        = bool
  default     = true
}

variable "bucket_name" {
  description = "name of the bucket. defaults to null and it's automattically creates one for you unless the bucket name is passed"
  type        = string
  default     = null
}

variable "bucket" {
  description = "Get the source from this location in Google Cloud Storage"
  type = object({
    object_path = string,
    generation  = optional(string, null)
  })
  default = null
}

variable "repo_source_enabled" {
  description = "whether to use SCM or repository as the sorce to cloud function"
  type        = bool
  default     = false
}

variable "repo_source" {
  description = "Get the source from this location in a Cloud Source Repository"
  type = object({
    project_id   = optional(string, null),
    repo_name    = string,
    branch_name  = string,
    dir          = optional(string, null),
    tag_name     = optional(string, null),
    commit_sha   = optional(string, null),
    invert_regex = optional(bool, false)
  })
  default = null
}
