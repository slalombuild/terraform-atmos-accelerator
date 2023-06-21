output "iam_bindings" {
  description = "Transformed IAM bindings. These are the IAM bindings that will be applied to the project."
  value       = local.iam_bindings_map
}

output "project_id" {
  description = "The identifier of the project."
  value       = google_project.project.project_id
}

output "id" {
  description = "The identifier of the project with format projects/{project}."
  value       = google_project.project.id
}

output "number" {
  description = "The numeric identifier of the project."
  value       = google_project.project.number
}

output "apis" {
  description = "APIs enabled on the project."
  value       = [for api in google_project_service.apis : api.service]
}
