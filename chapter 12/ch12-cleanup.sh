#!/bin/bash

echo "Run 'terraform destroy' using the GitHub Actions workflow (terraform-destroy.yml)."

echo "Manually cleaning up auxiliary infrastructure..."

aws s3 rm s3://terraformstatebucketsecuringtheawscloud --recursive
aws s3 rb s3://terraformstatebucketsecuringtheawscloud --force

aws dynamodb delete-table --table-name terraform_state_lock

aws iam delete-role --role-name GitHubActionsRole

echo "For full cleanup, remove OIDC provider via AWS Console or:"
echo "aws iam delete-open-id-connect-provider --open-id-connect-provider-arn <OIDC_ARN>"
