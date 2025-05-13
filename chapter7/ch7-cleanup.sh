#!/bin/bash

echo "Deleting IAM Roles..."
aws iam delete-role --role-name PayrollKeyAdmin
aws iam delete-role --role-name PayrollKeyUser

echo "Deleting KMS Key..."
KEY_ID=$(aws kms list-keys --query 'Keys[0].KeyId' --output text)
aws kms schedule-key-deletion --key-id $KEY_ID --pending-window-in-days 7

echo "Removing S3 Bucket (make sure it's empty)..."
aws s3 rb s3://secure-customer-data-<RANDOM_SUFFIX> --force

echo "Cleanup complete. Verify manually where necessary."
