
# Chapter 10 - Security Operations and Automation Command Cheatsheet

---

## Deploy Test Environment (CloudFormation)
```bash
aws cloudformation create-stack --stack-name chapter10 --template-body file://chapter10.yaml --capabilities CAPABILITY_NAMED_IAM
aws cloudformation wait stack-create-complete --stack-name chapter10
```

## SNS Topic Setup
```bash
aws sns create-topic --name SecurityAlerts
aws sns subscribe --topic-arn <TOPIC_ARN> --protocol email --notification-endpoint <EMAIL>
```

## IAM Role and Policy for Lambda
```bash
aws iam create-role --role-name SecurityAutomationRole --assume-role-policy-document file://trust-policy.json
aws iam put-role-policy --role-name SecurityAutomationRole --policy-name SecurityAutomationPolicy --policy-document file://lambda-policy.json
```

## Create Lambda Function
```bash
aws lambda create-function \
  --function-name InstanceIsolationAutomation \
  --runtime python3.9 \
  --role <ROLE_ARN> \
  --handler lambda_function.lambda_handler \
  --zip-file fileb://function.zip \
  --timeout 30 \
  --environment Variables={SNS_TOPIC_ARN=<TOPIC_ARN>}
```

## EventBridge Rule for GuardDuty
```bash
aws events put-rule --name GuardDutyHighSeverityFindings --event-pattern file://event-pattern.json

aws lambda add-permission \
  --function-name InstanceIsolationAutomation \
  --statement-id EventBridgeInvoke \
  --action lambda:InvokeFunction \
  --principal events.amazonaws.com \
  --source-arn <EVENTBRIDGE_RULE_ARN>

aws events put-targets \
  --rule GuardDutyHighSeverityFindings \
  --targets "Id"="1","Arn"="<LAMBDA_FUNCTION_ARN>"
```

## Generate Sample Finding
```bash
aws guardduty list-detectors
aws guardduty create-sample-findings --detector-id <DETECTOR_ID>
```

## CloudWatch Dashboard (Optional)
```bash
aws cloudwatch put-dashboard --dashboard-name SecurityOperationsMetrics --dashboard-body file://dashboard.json
```
