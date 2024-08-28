################################################################################
# Encryption Key Data Sources
################################################################################
data "google_kms_key_ring" "my_key_ring" {
  name     = "antm-default-keyring-${var.location}"
  location = var.location
  project  = var.project_id
}

data "google_kms_crypto_key" "my_crypto_key" {
  name     = var.crypto_key
  key_ring = data.google_kms_key_ring.my_key_ring.id
}

################################################################################
# Artifact Registry Resource
################################################################################
resource "google_artifact_registry_repository" "repository" {
  description   = try(var.description, "Google Artifact Registry for ${var.repository_id}")
  format        = var.format
  kms_key_name  = data.google_kms_crypto_key.my_crypto_key.id
  labels        = merge({ "provisioned-by" : "terraform-google-artifact-registry" }, var.labels)
  location      = var.location
  mode          = var.mode
  project       = var.project_id
  repository_id = var.repository_id

  dynamic "docker_config" {
    for_each = length(var.docker_config) == 0 ? [] : [var.docker_config]
    content {
      immutable_tags = lookup(docker_config.value, "immutable_tags", null)
    }
  }

  timeouts {
    create = "${var.create_timeout}m"
    delete = "${var.delete_timeout}m"
    update = "${var.update_timeout}m"
  }
}
