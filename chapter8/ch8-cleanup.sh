#!/bin/bash

echo "Cleaning up Chapter 8 resources..."

# CloudTrail
aws cloudtrail stop-logging --name iam-activity-trail
aws cloudtrail delete-trail --name iam-activity-trail

# S3
aws s3 rb s3://cloudtrail-iam-logs --force

# CloudWatch
aws cloudwatch delete-alarms --alarm-names high-cpu-usage unusual-vpc-traffic
aws cloudwatch delete-dashboards --dashboard-names EC2-Monitoring

# SNS
aws sns delete-topic --topic-arn <TOPIC_ARN_HIGH_CPU>
aws sns delete-topic --topic-arn <TOPIC_ARN_NETWORK_ALERT>

# VPC Flow Logs
aws ec2 delete-flow-logs --flow-log-ids <FLOW_LOG_ID>

# EC2 (optional)
aws ec2 terminate-instances --instance-ids <INSTANCE_ID_1> <INSTANCE_ID_2>

echo "Manual steps may be needed to fully clean up roles and security groups."
