module "tfstate_backend" {
  source  = "cloudposse/tfstate-backend/aws"
  version = "1.4.1"

  force_destroy                 = var.force_destroy
  prevent_unencrypted_uploads   = var.prevent_unencrypted_uploads
  enable_point_in_time_recovery = var.enable_point_in_time_recovery

  context = module.this.context
}
