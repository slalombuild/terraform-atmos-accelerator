
output "project_id" {
  description = "The identifier of the project."
  value       = one(google_project.project[*].project_id)
}

output "id" {
  description = "The identifier of the project with format projects/{project}."
  value       = one(google_project.project[*].id)
}

output "number" {
  description = "The numeric identifier of the project."
  value       = one(google_project.project[*].number)
}

output "apis" {
  description = "APIs enabled on the project."
  value       = local.enabled ? [for api in google_project_service.apis : api.service] : null
}
