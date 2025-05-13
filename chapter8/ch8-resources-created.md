
# Chapter 8 – Resources Created

---

## EC2 Instances
- Target Instance
- Load Testing Instance

## IAM
- Role: `SSMRole`
- Instance Profile: `SSMInstanceProfile`
- Flow Logs Role (manually created)

## Networking
- VPC: `LoadTesting-VPC`
- Subnet, Route Table, IGW
- Security Groups: `LoadTestSecurityGroup`, `TargetSecurityGroup`

## Monitoring
- CloudWatch Alarms:
  - `high-cpu-usage`
  - `unusual-vpc-traffic`
- CloudWatch Dashboard: `EC2-Monitoring`
- CloudWatch Log Group: `vpc-flow-logs`

## SNS
- Topic: `high-cpu-alert`
- Topic: `network-anomalies-alert`

## CloudTrail
- Trail: `iam-activity-trail`
- S3 Bucket: `cloudtrail-iam-logs`
