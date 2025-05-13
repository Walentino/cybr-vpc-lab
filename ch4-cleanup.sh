#!/bin/bash

# Cleanup Script for Chapter 4 - Identity Center Configurations
# NOTE: AWS Identity Center must be deleted via the AWS Console UI.

# Delete Accounts from AWS Organizations (if needed)
echo "Manual deletion of member accounts may be required."

# List accounts to get IDs
aws organizations list-accounts

# Delete Organization (will only succeed if no accounts or OUs exist)
# aws organizations delete-organization

echo "To delete AWS Identity Center setup:"
echo "1. Go to AWS Console -> IAM Identity Center -> Settings."
echo "2. Scroll down and click 'Delete'."

echo "Cleanup complete. Reminder: IAM Identity Center must be removed via Console."
