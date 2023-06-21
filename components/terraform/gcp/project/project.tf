resource "google_project" "project" {
  name                = module.this.name
  project_id          = var.project_id
  billing_account     = var.billing_account_id
  org_id              = var.org_id
  folder_id           = var.folder_id
  skip_delete         = var.skip_delete
  auto_create_network = var.auto_create_network
  labels              = module.this.tags
}

resource "google_project_iam_binding" "iam_bindings" {
  for_each = { for i, iam in var.iam_bindings: i => iam}
  project  = google_project.project.project_id
  role     = each.value.role
  members  = each.value.members
}

resource "google_project_service" "apis" {
  for_each                   = { for index, api in var.apis : index => api }
  project                    = google_project.project.id
  service                    = each.value
  disable_dependent_services = var.disable_dependent_services
  disable_on_destroy         = var.disable_on_destroy
  provisioner "local-exec" {
    command = "sleep 30"
  }
}
