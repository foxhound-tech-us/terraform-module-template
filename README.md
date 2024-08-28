# terraform-module-template

Template Repository that is used to bootstrap new modules.

This repo includes the following built-in workflows:

- Linting of:
  - YAML
  - Github Actions
  - Terraform HCL
- Checkov to check for baseline compliance of HCL code
- Dependabot for Github Actions
- Semantic Versioning of releases

## Semantic Versioning

In order to promote changes to this repository, you must understand Semantic Versioning style commit messages. These types of commit messages allow developers to influence the versioning of the package in an accessible way.

Semantic Version commits should be made upon merging in a PR, which in turn will influence the next version number of the release. This allows developers to no have to worry about maintaining version numbers directly.

| Commit Prefix     | Commit Message                          | SemVer Output                           |
| ----------------- | --------------------------------------- | --------------------------------------- |
| `fix`             | `fix: add output property`              | Increment SemVer **patch** version by 1 |
| `feat`            | `feat: add CMEK to resource`            | Increment SemVer **minor** version by 1 |
| `breaking change` | `breaking change: totally reworked i/o` | Increment SemVer **major** version by 1 |

The [detailed SemVer specification can be found here](https://semver.org/), but simply following the rules above is sufficient to produce proper module versioning. It is not necessary to use SemVer commits during the normal development cycle, it is only necessary during merges.

## Prerequisites

TBD

## Important Notes

TBD

## Usage

### Module

To use the module, please see the example below:

```terraform
## TBD
```

### Terraform

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

## Module Documentation

<!-- BEGIN_TF_DOCS -->

{ .Content }

<!-- END_TF_DOCS -->
