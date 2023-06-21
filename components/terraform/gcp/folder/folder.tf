resource "google_folder" "folder" {
  display_name = module.this.name
  parent       = var.parent
}

resource "google_folder_iam_binding" "iam_bindings" {
  for_each = { for i, iam in var.iam_bindings: i => iam}
  folder   = google_folder.folder.name
  role     = each.value.role
  members  = each.value.members
}
