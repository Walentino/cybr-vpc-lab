#!/bin/bash

echo "Disabling GuardDuty..."
DETECTOR_ID=$(aws guardduty list-detectors --query 'DetectorIds[0]' --output text)
aws guardduty delete-detector --detector-id $DETECTOR_ID

echo "Disabling Security Hub..."
aws securityhub disable-security-hub

echo "Deleting Lambda function..."
aws lambda delete-function --function-name GuardDutyResponse

echo "Deleting EventBridge rule..."
aws events delete-rule --name GuardDutyFindings

echo "Detaching and deleting IAM roles and policies..."
aws iam detach-role-policy --role-name guardduty-response-role --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
aws iam detach-role-policy --role-name guardduty-response-role --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess
aws iam detach-role-policy --role-name guardduty-response-role --policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/lambda-sns-publish
aws iam delete-role --role-name guardduty-response-role
aws iam delete-policy --policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/lambda-sns-publish

echo "Deleting SNS topic..."
aws sns delete-topic --topic-arn arn:aws:sns:<REGION>:<ACCOUNT_ID>:GuardDutyAlerts

echo "Done. Please verify resources were removed."
