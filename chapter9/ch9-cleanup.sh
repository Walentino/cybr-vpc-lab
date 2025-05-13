#!/bin/bash

echo "Deleting backup selection..."
aws backup delete-backup-selection --backup-plan-id <BACKUP_PLAN_ID> --selection-id <SELECTION_ID>

echo "Deleting backup plan..."
aws backup delete-backup-plan --backup-plan-id <BACKUP_PLAN_ID>

echo "Deleting backup vaults..."
aws backup delete-backup-vault --backup-vault-name primary-backup --region us-west-2
aws backup delete-backup-vault --backup-vault-name secondary-backup --region us-east-1

echo "Deleting IAM role..."
aws iam detach-role-policy --role-name AWSBackupDefaultServiceRole \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup
aws iam detach-role-policy --role-name AWSBackupDefaultServiceRole \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores
aws iam delete-role --role-name AWSBackupDefaultServiceRole

echo "Delete CloudFormation stack manually if needed via AWS Console."
