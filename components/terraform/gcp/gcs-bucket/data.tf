data "google_storage_project_service_account" "gcs_sa" {
  count   = local.enabled ? 1 : 0
  project = var.project_id
}
