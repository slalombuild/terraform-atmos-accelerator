module "kms" {
  count   = local.enabled ? 1 : 0
  source  = "terraform-google-modules/kms/google"
  version = "~> 2.2.2"

  project_id           = var.project_id
  location             = upper(var.location)
  keyring              = module.this.id
  keys                 = var.create_default_key ? [module.this.id] : var.keys
  set_owners_for       = var.create_default_key && var.set_owners_for_default_key ? [module.this.id] : var.set_owners_for
  set_encrypters_for   = var.create_default_key && var.set_encrypters_for_default_key ? [module.this.id] : var.set_encrypters_for
  set_decrypters_for   = var.set_decrypters_for_default_key ? [module.this.id] : var.set_encrypters_for
  owners               = var.owners_iam
  encrypters           = var.encrypters_iam
  decrypters           = var.decrypters_iam
  key_algorithm        = var.key_algorithm
  key_protection_level = var.key_protection_level
  key_rotation_period  = var.key_rotation_period
  purpose              = var.purpose
  labels               = module.this.tags
  prevent_destroy      = var.prevent_destroy
}
