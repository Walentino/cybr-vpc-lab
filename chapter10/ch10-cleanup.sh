#!/bin/bash

echo "Deleting EventBridge rule..."
aws events remove-targets --rule GuardDutyHighSeverityFindings --ids 1
aws events delete-rule --name GuardDutyHighSeverityFindings

echo "Deleting Lambda function..."
aws lambda delete-function --function-name InstanceIsolationAutomation

echo "Deleting IAM policy and role..."
aws iam delete-role-policy --role-name SecurityAutomationRole --policy-name SecurityAutomationPolicy
aws iam delete-role --role-name SecurityAutomationRole

echo "Deleting SNS subscription and topic..."
aws sns list-subscriptions-by-topic --topic-arn <TOPIC_ARN>
aws sns unsubscribe --subscription-arn <SUBSCRIPTION_ARN>
aws sns delete-topic --topic-arn <TOPIC_ARN>

echo "Deleting CloudFormation stack..."
aws cloudformation delete-stack --stack-name chapter10
aws cloudformation wait stack-delete-complete --stack-name chapter10
