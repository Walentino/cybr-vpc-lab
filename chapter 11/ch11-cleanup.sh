#!/bin/bash

echo "Deleting CloudFormation stack..."
aws cloudformation delete-stack --stack-name secure-s3-stack

echo "Check local Git repository for cleanup steps, or remove IaC resources from your pipeline manually."

echo "If you used Terraform:"
echo "Run 'terraform destroy' in your project directory."

echo "Cleanup complete. Review resource deletions manually to confirm."
