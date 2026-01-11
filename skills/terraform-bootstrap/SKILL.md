---
name: terraform-bootstrap
description: Bootstrap Terraform projects following multi-account AWS patterns with centralized state management, environment separation, and CI/CD integration. Use when users request (1) Bootstrap/setup/initialize terraform configuration/project, (2) Create initial terraform structure/folder structure, (3) Setup terraform following established patterns/conventions, or (4) Starting new AWS infrastructure projects with Terraform.
---

# Terraform Bootstrap

Bootstrap Terraform projects with multi-account AWS architecture patterns, centralized state management, and CI/CD integration.

## Quick Start

When user requests terraform project initialization:

1. **Run bootstrap script**:
   ```bash
   python scripts/bootstrap_project.py --project-name <name> [--output-dir <path>]
   ```

2. **Customize generated files**:
   - Update `state.conf` with actual S3 bucket and role ARN
   - Adjust account IDs in `env/*.tfvars`
   - Modify default tags in `providers.tf`

3. **Initialize terraform**:
   ```bash
   make environmental-init ACCOUNT=sandbox
   ```

## Architecture Pattern

Multi-account AWS setup:
- **Environments**: sandbox, staging, uat, production
- **State**: Centralized S3 + DynamoDB in shared-services account
- **Access**: Terraform role with admin privileges via assume_role
- **CI/CD**: GitHub Actions defaulting to sandbox, manual promotion

For detailed architecture, see [architecture.md](references/architecture.md).

## Project Structure

Bootstrap creates:
```
<project-name>/
├── state.conf                          # S3 backend config (gitignored)
├── Makefile                            # Root makefile
├── makefiles/
│   └── terraform.mk                    # Terraform automation
├── terraform/
│   └── environmental/
│       ├── main.tf                     # Resources (initially empty)
│       ├── providers.tf                # AWS provider + assume_role + default_tags
│       ├── terraform.tf                # Backend S3 config + versions
│       ├── variables.tf                # Input variables
│       ├── outputs.tf                  # Outputs
│       └── env/
│           ├── sandbox.tfvars          # Sandbox config
│           ├── staging.tfvars          # Staging config
│           ├── uat.tfvars              # UAT config
│           └── production.tfvars       # Production config
└── .github/
    └── workflows/
        └── terraform-deploy.yml        # CI/CD workflow
```

## Makefile Commands

```bash
# Initialize terraform with state.conf
make environmental-init ACCOUNT=sandbox

# Plan changes
make environmental-plan ACCOUNT=staging AWS_PROFILE=staging

# Apply changes
make environmental-apply ACCOUNT=production

# Format code
make fmt

# Clean .terraform/
make environmental-clean
```

## Customization Points

**state.conf**:
- `bucket`: S3 bucket name for state
- `role_arn`: IAM role for cross-account access
- `region`: AWS region

**providers.tf**:
- Default tags (change `franco:` prefix)
- Terraform role name (currently `terraform`)

**env/*.tfvars**:
- `account_id`: AWS account ID
- `account_name`: Environment name
- `region`: AWS region

**GitHub Actions**:
- Workflow triggers (push to main, PR, manual)
- Environment approval rules
- AWS credentials configuration

**Cross-Account Trust (GitHub OIDC)**:
- Shared-services terraform role must trust target account terraform roles
- Target account roles need OIDC trust + ability to assume shared-services role
- See [architecture.md](references/architecture.md#github-oidc--cross-account-state-access) for setup

## Workflow

1. **Bootstrap**: Run script, creates structure
2. **Configure**: Update state.conf, account IDs, tags
3. **Init**: `make environmental-init ACCOUNT=sandbox`
4. **Develop**: Add resources to main.tf
5. **Deploy**: Push to GitHub → Actions runs → Deploys to sandbox
6. **Promote**: Manual workflow dispatch for staging/uat/production

## GitHub Actions Integration

Generated workflow:
- Defaults to sandbox environment
- Requires manual approval for staging/uat/production
- Uses OIDC or AWS credentials from secrets
- Runs terraform init/plan/apply with appropriate flags
- Supports multiple environments in single workflow

Configure AWS credentials in GitHub:
- OIDC (recommended): Configure trust relationship
- Secrets: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`

## Security Patterns

- **Assume role**: Cross-account access via terraform role
- **State encryption**: SSE-S3 (free) not SSE-KMS
- **Default tags**: Track resources by stack/environment/managed_by
- **External ID**: Cross-account security (if needed)
- **Public access blocked**: S3 bucket hardened
- **GitIgnore**: state.conf, *.tfvars, .terraform/

## Common Operations

**Add new environment**:
1. Create `env/<new-env>.tfvars`
2. Add Make variables in `makefiles/terraform.mk`
3. Update GitHub Actions matrix

**Change state backend**:
1. Update `state.conf`
2. Run `make environmental-init ACCOUNT=<env>`
3. Migrate state if needed

**Switch AWS profile**:
```bash
make environmental-plan ACCOUNT=sandbox AWS_PROFILE=my-profile
```
