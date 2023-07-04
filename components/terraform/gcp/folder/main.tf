resource "google_folder" "folder" {
  count        = local.enabled ? 1 : 0
  display_name = module.this.name
  parent       = var.parent
}

resource "google_folder_iam_binding" "iam_bindings" {
  for_each = local.enabled ? { for i, iam in var.iam_bindings : i => iam } : {}
  folder   = google_folder.folder[0].name
  role     = each.value.role
  members  = each.value.members
}
