
# Chapter 6 - Threat Detection and Response Command Cheatsheet

---

## GuardDuty

### Enable GuardDuty (Organization Admin)
```bash
aws guardduty enable-organization-admin-account --admin-account-id <ACCOUNT_ID>
```

### Enable GuardDuty Detector
```bash
aws guardduty create-detector --enable
```

### Get Detector ID
```bash
aws guardduty list-detectors
```

### Create S3 Bucket for Threat Intel
```bash
aws s3 mb s3://your-threat-intel-bucket-${RANDOM}
```

### Create Threat List File
```bash
echo "192.168.1.100\n10.0.0.1" > threat-list.txt
aws s3 cp threat-list.txt s3://<BUCKET_NAME>/threat-list.txt
```

### Create Custom Threat Intel Set
```bash
aws guardduty create-threat-intel-set   --detector-id <DETECTOR_ID>   --format TXT   --location https://s3.amazonaws.com/<BUCKET_NAME>/threat-list.txt   --name "Custom IP Threat List"   --activate
```

### Generate Sample Finding
```bash
aws guardduty create-sample-findings   --detector-id <DETECTOR_ID>   --finding-types Recon:EC2/PortProbeUnprotectedPort
```

---

## Lambda and Automation

### Create EventBridge Rule
```bash
aws events put-rule   --name GuardDutyFindings   --event-pattern '{"source":["aws.guardduty"],"detail-type":["GuardDuty Finding"],"detail":{"severity":[5,8]}}'
```

### Create IAM Role for Lambda
```bash
aws iam create-role --role-name guardduty-response-role   --assume-role-policy-document file://trust-policy.json
```

### Attach Policies to Role
```bash
aws iam attach-role-policy --role-name guardduty-response-role   --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

aws iam attach-role-policy --role-name guardduty-response-role   --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess
```

### Create SNS Publish Policy
```bash
aws iam create-policy --policy-name lambda-sns-publish   --policy-document file://sns-publish-policy.json

aws iam attach-role-policy --role-name guardduty-response-role   --policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/lambda-sns-publish
```

### Create SNS Topic
```bash
aws sns create-topic --name GuardDutyAlerts
```

### Subscribe Email to SNS Topic
```bash
aws sns subscribe --topic-arn arn:aws:sns:<REGION>:<ACCOUNT_ID>:GuardDutyAlerts   --protocol email --notification-endpoint your@email.com
```

### Deploy Lambda Function
```bash
aws lambda create-function   --function-name GuardDutyResponse   --runtime python3.9   --zip-file fileb://function.zip   --handler lambda_function.lambda_handler   --role arn:aws:iam::<ACCOUNT_ID>:role/guardduty-response-role   --timeout 30 --memory-size 128
```

---

## Security Hub

### Enable Security Hub with Default Standards
```bash
aws securityhub enable-security-hub --enable-default-standards --tags '{"Department": "Security"}'
```

### Create Security Hub Automation Rule
```bash
aws securityhub create-automation-rule   --rule-name "HighSeverityFindings"   --rule-order 1   --description "Automatically send high severity findings to EventBridge"   --criteria '{"SeverityLabel": [{"Value": "HIGH", "Comparison": "EQUALS"}]}'   --actions '{"Type": "FINDING_FIELDS_UPDATE", "FindingFieldsUpdate": {"Note": {"Text": "High severity finding detected", "UpdatedBy": "automation-rule"}}}'   --no-is-terminal
```
