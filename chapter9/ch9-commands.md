
# Chapter 9 - Resilience and Recovery Strategies Command Cheatsheet

---

## AWS Backup - Create Backup Vaults
```bash
aws backup create-backup-vault --backup-vault-name primary-backup --region us-west-2
aws backup create-backup-vault --backup-vault-name secondary-backup --region us-east-1
```

## Create Backup Plan (Cross-Region)
```bash
aws backup create-backup-plan --cli-input-json file://cross-region-backup-plan.json
```

## View Backup Plan
```bash
aws backup get-backup-plan --backup-plan-id <BACKUP_PLAN_ID>
```

## Create IAM Role for Backup
```bash
aws iam create-role --role-name AWSBackupDefaultServiceRole \
  --assume-role-policy-document file://trust-policy.json

aws iam attach-role-policy --role-name AWSBackupDefaultServiceRole \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup

aws iam attach-role-policy --role-name AWSBackupDefaultServiceRole \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores
```

## Assign Resource to Backup Plan
```bash
aws backup create-backup-selection --backup-plan-id <BACKUP_PLAN_ID> \
  --backup-selection file://backup-selection.json
```

## Validate Backup Selection
```bash
aws backup list-backup-selections --backup-plan-id <BACKUP_PLAN_ID>
```
