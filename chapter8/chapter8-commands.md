# List EC2 Metrics
aws cloudwatch list-metrics --namespace AWS/EC2

# Create an SNS Topic for High CPU Alerts
aws sns create-topic --name high-cpu-alert

# Subscribe Your Email to the SNS Topic
aws sns subscribe \
    --topic-arn arn:aws:sns:<REGION>:<ACCOUNT_ID>:high-cpu-alert \
    --protocol email \
    --notification-endpoint <your-email@example.com>

# Create a CPU Alarm for an EC2 Instance
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
    --alarm-actions arn:aws:sns:<REGION>:<ACCOUNT_ID>:high-cpu-alert \
    --unit Percent

# Verify the CPU Alarm
aws cloudwatch describe-alarms --alarm-names high-cpu-usage

# Create a Custom CloudWatch Dashboard
aws cloudwatch put-dashboard \
    --dashboard-name "EC2-Monitoring" \
    --dashboard-body file://<path-to-your-dashboard.json>

# View Your Dashboard via CLI
aws cloudwatch get-dashboard --dashboard-name "EC2-Monitoring"

# Enable VPC Flow Logs
aws ec2 create-flow-logs \
    --resource-type VPC \
    --resource-ids <VPC_ID> \
    --traffic-type ALL \
    --log-destination-type cloud-watch-logs \
    --log-group-name vpc-flow-logs \
    --deliver-logs-permission-arn arn:aws:iam::<ACCOUNT_ID>:role/<ROLE_NAME>

# Start a Query on VPC Flow Logs
aws logs start-query \
    --log-group-name vpc-flow-logs \
    --start-time $(date --date="10 minutes ago" +%s) \
    --end-time $(date +%s) \
    --query-string 'fields @timestamp, @message | filter @message like /REJECT/'

# Retrieve Query Results
aws logs get-query-results --query-id <QUERY_ID>

# Create an Alarm for Outbound Network Traffic
aws cloudwatch put-metric-alarm \
    --alarm-name unusual-vpc-traffic \
    --metric-name NetworkPacketsOut \
    --namespace AWS/EC2 \
    --statistic Average \
    --period 300 \
    --threshold 100000 \
    --comparison-operator GreaterThanThreshold \
    --evaluation-periods 1 \
    --alarm-actions arn:aws:sns:<REGION>:<ACCOUNT_ID>:network-anomalies-alert

# Verify the Network Alarm
aws cloudwatch describe-alarms --alarm-names unusual-vpc-traffic

# Manually Trigger and Reset the Alarm (for Testing)
aws cloudwatch set-alarm-state \
    --alarm-name unusual-vpc-traffic \
    --state-value ALARM \
    --state-reason "Testing alarm notifications"

aws cloudwatch set-alarm-state \
    --alarm-name unusual-vpc-traffic \
    --state-value OK \
    --state-reason "Resetting alarm after test"

# Create an S3 Bucket for CloudTrail Logs
aws s3api create-bucket \
    --bucket cloudtrail-iam-logs \
    --region <REGION> \
    --create-bucket-configuration LocationConstraint=<REGION>

# Apply a Bucket Policy for CloudTrail
aws s3api put-bucket-policy \
    --bucket cloudtrail-iam-logs \
    --policy '{
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "AWSCloudTrailAclCheck20150319",
                "Effect": "Allow",
                "Principal": { "Service": "cloudtrail.amazonaws.com" },
                "Action": "s3:GetBucketAcl",
                "Resource": "arn:aws:s3:::cloudtrail-iam-logs"
            },
            {
                "Sid": "AWSCloudTrailWrite20150319",
                "Effect": "Allow",
                "Principal": { "Service": "cloudtrail.amazonaws.com" },
                "Action": "s3:PutObject",
                "Resource": "arn:aws:s3:::cloudtrail-iam-logs/AWSLogs/*",
                "Condition": {
                    "StringEquals": { "s3:x-amz-acl": "bucket-owner-full-control" }
                }
            }
        ]
     }'

# Verify the Bucket Policy
aws s3api get-bucket-policy --bucket cloudtrail-iam-logs

# Create a CloudTrail Trail for IAM Activity Logs
aws cloudtrail create-trail \
    --name iam-activity-trail \
    --s3-bucket-name cloudtrail-iam-logs \
    --is-multi-region-trail

# Start CloudTrail Logging
aws cloudtrail start-logging --name iam-activity-trail

# Verify CloudTrail Logging Status
aws cloudtrail get-trail-status --name iam-activity-trail

# Create a CloudWatch Log Group for CloudTrail Logs
aws logs create-log-group --log-group-name cloudtrail-iam-logs

# Create a Metric Filter for Suspicious IAM Activity
aws logs put-metric-filter \
    --log-group-name cloudtrail-iam-logs \
    --filter-name iam-suspicious-activity \
    --filter-pattern '{ ($.eventName = "DeleteUser") || ($.eventName = "AttachUserPolicy") }' \
    --metric-transformations metricName=SuspiciousIAMActivity,metricNamespace=CloudTrailMetrics,metricValue=1

# Create an SNS Topic for IAM Alerts
aws sns create-topic --name iam-alerts

# Subscribe to IAM Alerts Topic
aws sns subscribe \
   --topic-arn arn:aws:sns:<REGION>:<ACCOUNT_ID>:iam-alerts\
   ---protocol email\
   ---notification-endpoint-brand
