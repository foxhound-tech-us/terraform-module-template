output "id" {
  description = "An identifier for the resource with format projects/{{project}}/locations/{{location}}/repositories/{{repository_id}}."
  value       = google_artifact_registry_repository.repository.id
}

output "name" {
  description = "The name of the repository, for example: \"repo1\"."
  value       = google_artifact_registry_repository.repository.name
}

output "create_time" {
  description = "The time when the repository was created."
  value       = google_artifact_registry_repository.repository.create_time
}

output "update_time" {
  description = "The time when the repository was last updated."
  value       = google_artifact_registry_repository.repository.update_time
}
