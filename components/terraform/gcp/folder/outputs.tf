
output "name" {
  description = "The resource name of the Folder: folders/{folder_id}."
  value       = one(google_folder.folder[*].name)
}

output "lifecycle_state" {
  description = "The lifecycle state of the folder such as ACTIVE or DELETE_REQUESTED."
  value       = one(google_folder.folder[*].lifecycle_state)
}

output "create_time" {
  description = "Timestamp of when the Folder was created. It is assigned by the server and in RFC3339 UTC \"Zulu\" format, accurate to nanoseconds. Example: \"2014-10-02T15:01:23.045123456Z\"."
  value       = one(google_folder.folder[*].create_time)
}

