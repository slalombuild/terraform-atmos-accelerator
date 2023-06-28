
output "project_id" {
  description = "The identifier of the project."
  value       = local.enabled ? google_project.project[0].project_id : null
}

output "id" {
  description = "The identifier of the project with format projects/{project}."
  value       = local.enabled ? google_project.project[0].id : null
}

output "number" {
  description = "The numeric identifier of the project."
  value       = local.enabled ? google_project.project[0].number : null
}

output "apis" {
  description = "APIs enabled on the project."
  value       = local.enabled ? [for api in google_project_service.apis : api.service] : null
}
