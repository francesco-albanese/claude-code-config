# Terraform Configuration

## Version Requirements
- Terraform >= 1.14
- AWS provider >= 6.28.0

## Tooling
- Use `tfenv` for version management
- Run `tflint` before committing

## Project Initialization
- Use custom skill `terraform-bootstrap` for new projects
- Initialize with `terraform init -backend-config=...`

## File Structure
- `main.tf` - primary resources
- `variables.tf` - input variables
- `providers.tf` - provider/terraform versions

## Coding Standards
- Use snake_case for resource names
- Prefix resources with project/env identifier
- Group related resources in modules
- Always include `tags` with `franco:terraform_stack` specifying the name of the project and stack example "aws-api-gateway-mtls-ca-bootstrap", "franco:environment"     = var.account_name, `franco:managed_by` "terraform"

