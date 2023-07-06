variable "project_id" {
  type        = string
  description = "The ID of the existing GCP project where the GCS bucket will be deployed."
}

variable "location" {
  type        = string
  description = "Location for the keyring."
}

variable "keys" {
  type        = list(string)
  description = "Key names."
  default     = []
}

variable "set_owners_for" {
  type        = list(string)
  description = "Name of keys for which owners will be set."
  default     = []
}

variable "set_encrypters_for" {
  type        = list(string)
  description = "Name of keys for which encrypters will be set."
  default     = []
}

variable "set_decrypters_for" {
  type        = list(string)
  description = "Name of keys for which decrypters will be set."
  default     = []
}

variable "owners_iam" {
  type        = list(string)
  description = "List of comma-separated owners for each key declared in set_owners_for."
  default     = []
}

variable "encrypters_iam" {
  type        = list(string)
  description = "List of comma-separated owners for each key declared in set_encrypters_for."
  default     = []
}

variable "decrypters_iam" {
  type        = list(string)
  description = "List of comma-separated owners for each key declared in set_decrypters_for."
  default     = []
}

variable "key_algorithm" {
  type        = string
  description = "The algorithm to use when creating a version based on this template. See the https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm for possible inputs."
  default     = "GOOGLE_SYMMETRIC_ENCRYPTION"
}

variable "key_protection_level" {
  type        = string
  description = "The protection level to use when creating a version based on this template. Default value: ** SOFTWARE ** Possible values: [SOFTWARE, HSM]"
  default     = "SOFTWARE"
}

variable "key_rotation_period" {
  type        = string
  description = "Generate a new key every time this period passes."
  default     = "100000s"
}

variable "purpose" {
  type        = string
  description = "he immutable purpose of the CryptoKey. Possible values are ENCRYPT_DECRYPT, ASYMMETRIC_SIGN, and ASYMMETRIC_DECRYPT."
  default     = "ENCRYPT_DECRYPT"
}

variable "prevent_destroy" {
  type        = bool
  description = "Set the prevent_destroy lifecycle attribute on keys."
  default     = false
}

variable "create_default_key" {
  type        = bool
  description = "To create a key by the module itself"
  default     = true
}

variable "set_encrypters_for_default_key" {
  type        = bool
  description = "To set the encrypters IAM role for default key."
  default     = false
}

variable "set_decrypters_for_default_key" {
  type        = bool
  description = "To set the decrypters IAM role for default key."
  default     = false
}

variable "set_owners_for_default_key" {
  type        = bool
  description = "To set the owners IAM role for default key."
  default     = false
}
