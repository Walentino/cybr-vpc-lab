import boto3
import json

def lambda_handler(event, context):
    # Initialize AWS clients
    ec2 = boto3.client('ec2')
    sns = boto3.client('sns')
    
    # Extract event details
    finding = event['detail']
    instance_id = finding['resource']['instanceDetails']['instanceId']
    
    # Implement automated response
    if finding['severity'] >= 7:
        # Create an isolation security group
        response = ec2.create_security_group(
            GroupName=f'ISOLATION-{instance_id}',
            Description='Automated isolation security group'
        )
        
        # Apply the isolation security group
        ec2.modify_instance_attribute(
            InstanceId=instance_id,
            Groups=[response['GroupId']]
        )
        
        # Notify security team
        sns.publish(
            TopicArn='arn:aws:sns:region:account:SecurityAlerts',
            Message=f'High severity finding detected. Instance {instance_id} isolated.'
        )
    
    return {
        'statusCode': 200,
        'body': 'Security automation completed'
    }

