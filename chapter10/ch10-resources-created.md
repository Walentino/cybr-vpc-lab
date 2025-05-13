
# Chapter 10 – Resources Created

---

## CloudFormation Environment
- VPC: Chapter10-VPC
- Subnet, Route Table, Internet Gateway
- EC2 Instance: Chapter10-TestInstance
- Security Group: Chapter10-SG
- IAM Role: SSMInstanceRole

## SNS
- Topic: SecurityAlerts
- Email Subscription: <EMAIL>

## Lambda
- Function: InstanceIsolationAutomation
- Role: SecurityAutomationRole
- Policy: SecurityAutomationPolicy

## EventBridge
- Rule: GuardDutyHighSeverityFindings

## Optional
- CloudWatch Dashboard: SecurityOperationsMetrics
