output "bucket_name" {
  value = google_storage_bucket.bucket[0].name
}

output "bucket_self_link" {
  value = google_storage_bucket.bucket[0].self_link
}

output "bucket_url" {
  value = google_storage_bucket.bucket[0].url
}
