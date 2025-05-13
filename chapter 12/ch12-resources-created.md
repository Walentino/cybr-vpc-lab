
# Chapter 12 – Resources Created

---

## Terraform State Management

- S3 Bucket: `terraformstatebucketsecuringtheawscloud`
  - Versioning enabled
  - Encryption enforced
- DynamoDB Table: `terraform_state_lock`

## IAM

- Role: `GitHubActionsRole` (with OpenID Connect)
- Permissions: least privilege for terraform deploy

## GitHub

- Actions Workflow: `.github/workflows/network-firewall.yml`
- Secrets: `AWS_IAM_ROLE`, `TF_STATE_BUCKET`
- Feature Branch: `AddingFirewallRules`

## Terraform Infrastructure

- VPC and Subnets
- Route Table and Internet Gateway
- AWS Network Firewall + Policy + Rule Groups
- Terraform outputs (Firewall ID, VPC ID, Subnet IDs)
