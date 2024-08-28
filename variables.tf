################################################################################
# General Project Variables
################################################################################

variable "project_id" {
  type        = string
  description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the project ID listed in the provider is used."
  default     = ""
}

################################################################################
# Encryption Key Configurations
################################################################################

variable "crypto_key" {
  type        = string
  description = "(Required) The name of the crypto key to use."
}

################################################################################
# Artifact Registry Configurations
################################################################################

variable "location" {
  type        = string
  description = "(Required) The name of the location this repository is located in."
}

variable "repository_id" {
  type        = string
  description = "(Required) The last part of the repository name"
}

variable "format" {
  type        = string
  description = "(Required) The format of packages that are stored in the repository. Currently, the possible allowed value for the Format of the Artifact Registry Repository is: DOCKER."
  default     = "DOCKER"

  validation {
    condition = anytrue([
      var.format == "DOCKER"
    ])
    error_message = "Currently, the possible allowed value for the Format of the Artifact Registry Repository is: DOCKER."
  }
}

variable "mode" {
  type        = string
  description = "(Optional) The mode configures the repository to serve artifacts from different sources. Default value is STANDARD_REPOSITORY. Currently, the possible allowed values for the Mode of the Artifact Registry Repository is: STANDARD_REPOSITORY."
  default     = "STANDARD_REPOSITORY"

  validation {
    condition = anytrue([
      var.mode == "STANDARD_REPOSITORY"
    ])
    error_message = "Currently, the possible allowed values for the Mode of the Artifact Registry Repository is: STANDARD_REPOSITORY."
  }
}

variable "docker_config" {
  type        = map(string)
  description = "(Optional) This contains repository level configuration for the repositories of format type of Docker. Allows setting immutable_tags."
  default     = null
}

variable "description" {
  type        = string
  description = "(Optional) The user-provided description of the repository."
  default     = null
}

variable "labels" {
  type        = map(string)
  description = "(Required) A set of additional key/value label pairs to assign to the bucket. This is usually inherited from the Mandatory Labels Module via the format: \"module.mandatory_labels.module\"."
  default     = {}
}

variable "create_timeout" {
  type        = number
  default     = 20
  description = "(Optional) Creation Timeout of Resource"

}
variable "delete_timeout" {
  type        = number
  default     = 20
  description = "(Optional) Delete Timeout of Resource"

}
variable "update_timeout" {
  type        = number
  default     = 20
  description = "(Optional) Update Timeout of Resource"
}
