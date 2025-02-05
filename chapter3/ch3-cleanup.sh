#!/bin/bash

# Set AWS account ID
ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)

echo "Starting cleanup of IAM resources created in the chapter..."

# Step 1: Detach policies from IAM Users
echo "Detaching policies from IAM users..."
aws iam detach-user-policy --user-name Administrator --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
aws iam detach-user-policy --user-name Bob --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess
aws iam detach-user-policy --user-name Bob --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess
aws iam detach-user-policy --user-name S3User --policy-arn arn:aws:iam::$ACCOUNT_ID:policy/S3ExamplePolicy

# Step 2: Delete IAM access keys for each user
echo "Deleting access keys..."
for user in Administrator Bob PowerUser S3User; do
  for key in $(aws iam list-access-keys --user-name $user --query 'AccessKeyMetadata[].AccessKeyId' --output text); do
    aws iam delete-access-key --user-name $user --access-key-id $key
  done
done

# Step 3: Delete IAM Users
echo "Deleting IAM users..."
aws iam delete-user --user-name Administrator
aws iam delete-user --user-name Bob
aws iam delete-user --user-name PowerUser
aws iam delete-user --user-name S3User

# Step 4: Remove users from groups
echo "Removing users from groups..."
aws iam remove-user-from-group --user-name PowerUser --group-name Developers
aws iam remove-user-from-group --user-name PowerUser --group-name Managers

# Step 5: Detach policies from IAM Groups
echo "Detaching policies from IAM groups..."
aws iam detach-group-policy --group-name Developers --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess
aws iam detach-group-policy --group-name Developers --policy-arn arn:aws:iam::aws:policy/AmazonCodeCatalystFullAccess
aws iam detach-group-policy --group-name Managers --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

# Step 6: Delete IAM Groups
echo "Deleting IAM groups..."
aws iam delete-group --group-name Developers
aws iam delete-group --group-name Managers

# Step 7: Detach policy from IAM Role
echo "Detaching policies from IAM role..."
aws iam detach-role-policy --role-name EC2S3FullAccess --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess

# Step 8: Delete IAM Role
echo "Deleting IAM role..."
aws iam delete-role --role-name EC2S3FullAccess

# Step 9: Delete Custom IAM Policy
echo "Deleting custom IAM policy..."
aws iam delete-policy --policy-arn arn:aws:iam::$ACCOUNT_ID:policy/S3ExamplePolicy

echo "Cleanup complete!"
