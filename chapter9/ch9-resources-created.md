
# Chapter 9 – Resources Created

---

## AWS Backup

- Vaults:
  - primary-backup (us-west-2)
  - secondary-backup (us-east-1)
- Backup Plan: `cross-region-backup`
- Backup Selection: `ec2-backup-selection`

## IAM

- Role: `AWSBackupDefaultServiceRole`
- Policies:
  - AWSBackupServiceRolePolicyForBackup
  - AWSBackupServiceRolePolicyForRestores

## CloudFormation

- Stack: Chapter 9 resilience testing
- Resources:
  - VPC and Subnet
  - Route Table and IGW
  - EC2 WebServer with CloudWatch Agent
  - IAM Role and Instance Profile
