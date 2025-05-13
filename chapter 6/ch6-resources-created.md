
# Chapter 6 – Resources Created

---

## GuardDuty

- Detector: `<DETECTOR_ID>`
- Custom Threat Intel Set: `<THREAT_INTEL_SET_ID>`
- Sample Findings: Enabled

## Security Hub

- Hub: Enabled
- Automation Rule: `HighSeverityFindings`

## Lambda Function

- Function: `GuardDutyResponse`
- IAM Role: `guardduty-response-role`
- Policies:
  - AWSLambdaBasicExecutionRole
  - AmazonEC2FullAccess
  - lambda-sns-publish

## EventBridge

- Rule: `GuardDutyFindings`

## SNS

- Topic: `GuardDutyAlerts`
- Subscription: `<EMAIL>`

## S3

- Bucket: `<THREAT_INTEL_BUCKET>`
- File: `threat-list.txt`
