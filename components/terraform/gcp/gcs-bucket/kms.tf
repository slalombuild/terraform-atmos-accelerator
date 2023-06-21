resource "google_kms_key_ring" "key_ring" {
  count    = local.enabled && var.kms_encryption_enabled ? 1 : 0
  project  = var.project_id
  name     = "${module.this.id}-temp"
  location = lower(var.kms.location)
}

resource "google_kms_crypto_key" "crypto_key" {
  count           = local.enabled && var.kms_encryption_enabled ? 1 : 0
  name            = "${module.this.id}temp"
  key_ring        = google_kms_key_ring.key_ring[0].id
  rotation_period = var.kms.key_rotation_period
  labels          = module.this.additional_tag_map
  purpose         = var.kms.purpose
  version_template {
    algorithm        = var.kms.key_algorithm
    protection_level = var.kms.key_protection_level
  }
}
