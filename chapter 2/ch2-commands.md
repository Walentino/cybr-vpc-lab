
# Chapter 2 - AWS Security Fundamentals Command Cheatsheet

This file contains command-line examples covered in Chapter 2 of *Securing the Cloud*. Replace the placeholder values (like `<USER_NAME>`, `<CIDR_BLOCK>`, etc.) with values specific to your AWS environment.

---

## IAM

### Create IAM User
```bash
aws iam create-user --user-name <USER_NAME>
```

### Attach Policy to IAM User
```bash
aws iam attach-user-policy --user-name <USER_NAME> --policy-arn <POLICY_ARN>
```

---

## KMS (Key Management Service)

### Create a KMS Key
```bash
aws kms create-key --description "<DESCRIPTION>" --key-usage ENCRYPT_DECRYPT --origin AWS_KMS
```

---

## CloudTrail

### Create a Trail
```bash
aws cloudtrail create-trail --name <TRAIL_NAME> --s3-bucket-name <S3_BUCKET_NAME>
```

### Start Logging
```bash
aws cloudtrail start-logging --name <TRAIL_NAME>
```

---

## Config

### Enable AWS Config
```bash
aws configservice put-configuration-recorder --configuration-recorder name=<RECORDER_NAME> --role-arn <ROLE_ARN>
aws configservice start-configuration-recorder --configuration-recorder-name <RECORDER_NAME>
```

---

## GuardDuty

### Enable GuardDuty
```bash
aws guardduty create-detector --enable
```

---

## VPC and Network Security

### Create VPC
```bash
aws ec2 create-vpc --cidr-block <CIDR_BLOCK>
```

### Create Security Group
```bash
aws ec2 create-security-group --group-name <GROUP_NAME> --description "<DESCRIPTION>" --vpc-id <VPC_ID>
```

### Add Ingress Rule to Security Group
```bash
aws ec2 authorize-security-group-ingress --group-id <GROUP_ID> --protocol tcp --port <PORT> --cidr <CIDR_BLOCK>
```

### Enable VPC Flow Logs
```bash
aws ec2 create-flow-logs --resource-type VPC --resource-ids <VPC_ID> --traffic-type ALL --log-group-name <LOG_GROUP> --deliver-logs-permission-arn <IAM_ROLE_ARN>
```

---

## Organizations

### Create Service Control Policy (SCP)
```bash
aws organizations create-policy --content file://<POLICY_FILE>.json --description "<DESCRIPTION>" --name <POLICY_NAME> --type SERVICE_CONTROL_POLICY
```

---

## Security Hub

### Enable Security Hub
```bash
aws securityhub enable-security-hub
```
