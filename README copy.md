# Elevance Health Google Artifact Registry Repository Module

This module creates a Google Artifact Registry Repository for storing artifacts. Currently only Docker format Registry/Repositories are allowed. 
Please see the link for more information about the [Google Artifact Registry Repository](https://cloud.google.com/artifact-registry/docs/overview) and the [Terraform Google Provider Reference](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository) for the Resource.

## HIPAA Eligibility Status

The GCP Artifact Registryis eligible for HIPAA requirements and covered under the [GCP Cloud BAA](https://cloud.google.com/security/compliance/hipaa/#covered-products).

## Security Guardrail Reference

[ESG Reference for GCP Artifact Registry](https://elevancehealth.service-now.com/esg?id=esg_form&table=u_esg_request&sys_id=543ca6cd97ed9550c18672300153af69&view=esgportal)

## Prerequisites

* Mandatory Labels Module with validated values 
* CMEK (Customer-Manged Encryption Key) Module
* Assign permissions for the Default Artifact Registry Service Account to be able to use ("roles/cloudkms.cryptoKeyEncrypterDecrypter") the CMEK Key

## Important Notes

None.

## Usage

To use the module, please see the example below:

```bash
data "google_project" "project" {}

module "mandatory_labels" {
  source  = "cps-terraform.anthem.com/<ORGANIZATION>/terraform-google-mandatory-labels/google"

  # The below labels are always mandatory - Some may even inherit directly from your GCP TFE Workspace if no value is provided.
  apm-id               = "<apm-id>"
  business-division    = "<business-division>"
  app-servicenow-group = "<app-servicenow-group>"
  app-support-dl       = "<app-support-dl>"
  application-name     = "<application-name>"
  company              = "<company>"
  compliance           = "<compliance>"
  patchgroup           = "<patchgroup>"
  patchwindow          = "<patchwindow>"
  costcenter           = "<costcenter>"
  environment          = "<environment>"
  workspace            = "<workspace>"

  # The below allows all modules within the configuration to take on additional values
  additional-labels = {
    "addltestkey" = "addltestvalue",
  }
}

## Create a CMEK Key for this test
module "artifactreg-cmek" {
  source        = "cps-terraform.anthem.com/<ORGANIZATION>/terraform-google-cmek/google"
  location      = "<location>"
  project_id    = "<project_id>"
  service_name  = "<service_name>"
  purpose       = "ENCRYPT_DECRYPT"
  key_algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"
  labels        = module.mandatory_labels.labels
}

# Permissions for the Custom Artifact Registry Repository Default SA to use CMEK Key to Encrypt/Decrypt
module "artifactreg-cmek-default-artifactreg-sa-iam-member" {
  source                = "cps-terraform.anthem.com/<ORGANIZATION>/terraform-google-cmek-iam-member/google"
  crypto_key_id         = module.artifactreg-cmek.id
  role                  = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  service_account_email = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-artifactregistry.iam.gserviceaccount.com"
}

# Custom Artifact Registry Repository for GCF API endpt
module "artifactregistry" {
  source        = "cps-terraform.anthem.com/<ORGANIZATION>/terraform-google-artifact-registry/google"
  location      = "<location>"
  project_id    = "<project_id>"
  repository_id = "<repository_name>"
  description   = "Custom Artifact Registry for <repository_name>"
  format        = "DOCKER"
  mode          = "STANDARD_REPOSITORY"
  crypto_key    = module.artifactreg-cmek.name
  docker_config = {
    immutable_tags = true
  }
  labels = module.mandatory_labels.labels
  depends_on = [
    module.artifactreg-cmek-default-artifactreg-sa-iam-member
  ]
}
```

Execution:
```bash
# Initialize Terraform. It’s going to download code for a provider(aws, gcp and azure) that we will use
terraform init

# Validate the syntax
terraform validate

# Terraform Format 
terraform fmt

# Terraform Dry-Run. This command will tell what terraform does before making any changes.
#     1: (+ sign): Resource going to be created
#     2: (- sign): Resource going to be deleted
#     3: (~ sign): Resource going to be modified  
terraform plan

# Create the resources. To apply the changes, run terraform apply command
terraform apply

# Destroy the resources
terraform destroy
```

##  Change Logs

List of all changes and notes below:

| Jira Ticket link  | Prod BitBucket Release Tag version | Notes |
|:---------:|:-------------:|:--------:|
| [CDTPSCLOUD-34346](https://jira.elevancehealth.com/browse/CDTPSCLOUD-34346) | 0.0.2 | New Module Developed |


## Testing

List of all tests/use-cases and results below:

| Test ID | Description | Results |
|:---------:|:-------------:|:--------:|
| 1 | Artifact Registry Repository Creation | Succeeded |
| 2 | CMEK-enabled Repository | Succeeded |


## Module Documentation

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.9 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~>6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~>6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_artifact_registry_repository.repository](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository) | resource |
| [google_kms_crypto_key.my_crypto_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/kms_crypto_key) | data source |
| [google_kms_key_ring.my_key_ring](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/kms_key_ring) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_timeout"></a> [create\_timeout](#input\_create\_timeout) | (Optional) Creation Timeout of Resource | `number` | `20` | no |
| <a name="input_crypto_key"></a> [crypto\_key](#input\_crypto\_key) | (Required) The name of the crypto key to use. | `string` | n/a | yes |
| <a name="input_delete_timeout"></a> [delete\_timeout](#input\_delete\_timeout) | (Optional) Delete Timeout of Resource | `number` | `20` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The user-provided description of the repository. | `string` | n/a | yes |
| <a name="input_docker_config"></a> [docker\_config](#input\_docker\_config) | (Optional) This contains repository level configuration for the repositories of format type of Docker. Allows setting immutable\_tags. | `map(string)` | `null` | no |
| <a name="input_format"></a> [format](#input\_format) | (Required) The format of packages that are stored in the repository. Currently, the possible allowed value for the Format of the Artifact Registry Repository is: DOCKER. | `string` | `"DOCKER"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | (Required) A set of additional key/value label pairs to assign to the bucket. This is usually inherited from the Mandatory Labels Module via the format: "module.mandatory\_labels.module". | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The name of the location this repository is located in. | `string` | n/a | yes |
| <a name="input_mode"></a> [mode](#input\_mode) | (Optional) The mode configures the repository to serve artifacts from different sources. Default value is STANDARD\_REPOSITORY. Currently, the possible allowed values for the Mode of the Artifact Registry Repository is: STANDARD\_REPOSITORY. | `string` | `"STANDARD_REPOSITORY"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (Optional) The ID of the project in which the resource belongs. If it is not provided, the project ID listed in the provider is used. | `string` | `""` | no |
| <a name="input_repository_id"></a> [repository\_id](#input\_repository\_id) | (Required) The last part of the repository name | `string` | n/a | yes |
| <a name="input_update_timeout"></a> [update\_timeout](#input\_update\_timeout) | (Optional) Update Timeout of Resource | `number` | `20` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_create_time"></a> [create\_time](#output\_create\_time) | The time when the repository was created. |
| <a name="output_id"></a> [id](#output\_id) | An identifier for the resource with format projects/{{project}}/locations/{{location}}/repositories/{{repository\_id}}. |
| <a name="output_name"></a> [name](#output\_name) | The name of the repository, for example: "repo1". |
| <a name="output_update_time"></a> [update\_time](#output\_update\_time) | The time when the repository was last updated. |
<!-- END_TF_DOCS -->