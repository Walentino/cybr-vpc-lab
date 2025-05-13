
# Chapter 8 - Monitoring, Logging, and Compliance Command Cheatsheet

---

## CloudWatch - List EC2 Metrics
```bash
aws cloudwatch list-metrics --namespace AWS/EC2
```

## SNS - Create and Subscribe
```bash
aws sns create-topic --name high-cpu-alert
aws sns subscribe --topic-arn <TOPIC_ARN> --protocol email --notification-endpoint <EMAIL>
```

## CloudWatch Alarm - CPU Usage
```bash
aws cloudwatch put-metric-alarm \
  --alarm-name high-cpu-usage \
  --metric-name CPUUtilization \
  --namespace AWS/EC2 \
  --statistic Average \
  --period 300 \
  --threshold 80 \
  --comparison-operator GreaterThanThreshold \
  --dimensions Name=InstanceId,Value=<INSTANCE_ID> \
  --evaluation-periods 2 \
  --alarm-actions <TOPIC_ARN> \
  --unit Percent
```

## CloudWatch Dashboard
```bash
aws cloudwatch put-dashboard --dashboard-name "EC2-Monitoring" --dashboard-body file://dashboard.json
```

## VPC Flow Logs
```bash
aws ec2 create-flow-logs \
  --resource-type VPC \
  --resource-ids <VPC_ID> \
  --traffic-type ALL \
  --log-destination-type cloud-watch-logs \
  --log-group-name vpc-flow-logs \
  --deliver-logs-permission-arn <ROLE_ARN>
```

## Logs Insights Query
```bash
aws logs start-query \
  --log-group-name vpc-flow-logs \
  --start-time $(date --date="10 minutes ago" +%s) \
  --end-time $(date +%s) \
  --query-string 'fields @timestamp, @message | filter @message like /REJECT/'
```

## CloudTrail - Create Trail and S3 Setup
```bash
aws s3api create-bucket --bucket cloudtrail-iam-logs --region us-west-2 \
  --create-bucket-configuration LocationConstraint=us-west-2

aws s3api put-bucket-policy --bucket cloudtrail-iam-logs --policy file://bucket-policy.json

aws cloudtrail create-trail --name iam-activity-trail --s3-bucket-name cloudtrail-iam-logs --is-multi-region-trail
aws cloudtrail start-logging --name iam-activity-trail
```
