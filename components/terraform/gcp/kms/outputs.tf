output "kms" {
  description = "Attributes of created KMS"
  value = local.enabled ? [for i in module.kms : {
    keyring          = i.keyring
    keyring_name     = i.keyring_name
    keyring_resource = i.keyring_resource
    keys             = i.keys
  }] : null
}
