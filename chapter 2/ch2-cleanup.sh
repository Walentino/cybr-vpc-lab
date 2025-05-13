#!/bin/bash

# Cleanup script for AWS Security Fundamentals - Chapter 2
# Replace placeholders with actual resource identifiers before executing.

# === IAM ===
echo "Deleting IAM user..."
aws iam delete-user-policy --user-name <USER_NAME> --policy-name <POLICY_NAME>
aws iam delete-user --user-name <USER_NAME>

# === KMS ===
echo "Schedule deletion of KMS key..."
aws kms schedule-key-deletion --key-id <KMS_KEY_ID> --pending-window-in-days 7

# === CloudTrail ===
echo "Deleting CloudTrail trail..."
aws cloudtrail stop-logging --name <TRAIL_NAME>
aws cloudtrail delete-trail --name <TRAIL_NAME>

# === AWS Config ===
echo "Stopping and deleting AWS Config recorder..."
aws configservice stop-configuration-recorder --configuration-recorder-name <RECORDER_NAME>
aws configservice delete-configuration-recorder --configuration-recorder-name <RECORDER_NAME>

# === GuardDuty ===
echo "Deleting GuardDuty detector..."
DETECTOR_ID=$(aws guardduty list-detectors --query 'DetectorIds[0]' --output text)
aws guardduty delete-detector --detector-id $DETECTOR_ID

# === VPC and Network ===
echo "Deleting Flow Logs..."
# You'll need to list and delete flow logs manually or by script if you know their IDs

echo "Revoking and deleting security group..."
aws ec2 revoke-security-group-ingress --group-id <GROUP_ID> --protocol tcp --port <PORT> --cidr <CIDR_BLOCK>
aws ec2 delete-security-group --group-id <GROUP_ID>

echo "Deleting VPC..."
aws ec2 delete-vpc --vpc-id <VPC_ID>

# === AWS Organizations ===
echo "Deleting Service Control Policy (SCP)..."
aws organizations delete-policy --policy-id <POLICY_ID>

# === Security Hub ===
echo "Disabling Security Hub..."
aws securityhub disable-security-hub

echo "Cleanup complete. Make sure all placeholders were replaced before running this script."
