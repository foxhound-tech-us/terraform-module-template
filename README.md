# terraform-module-template
Template Repository that is used to bootstrap new modules. 

This repo includes the following built-in workflows:
- Linting of:
    - YAML
    - Github Actions
    - Terraform HCL
- Checkov to check for baseline compliance of HCL code
- Dependabot for Github Actions

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