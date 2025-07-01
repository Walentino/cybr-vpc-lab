# ⚠️ **Warning:** This script will **permanently delete** all resources listed. Be sure you want to remove everything before running it.

---

### **Shell Script to Clean Up Chapter 5 Resources**
# Save the script as `cleanup_ch5.sh`, make it executable with `chmod +x cleanup_ch5.sh`, and run it.


#!/bin/bash

# Set your AWS region
AWS_REGION="us-west-2"  # Change this if using a different region

# Retrieve IDs (Replace with your actual values or dynamically retrieve)
VPC_ID=$(aws ec2 describe-vpcs --filters "Name=tag:Name,Values=SecureInfraVPC" --query "Vpcs[0].VpcId" --output text --region $AWS_REGION)
IGW_ID=$(aws ec2 describe-internet-gateways --filters "Name=attachment.vpc-id,Values=$VPC_ID" --query "InternetGateways[0].InternetGatewayId" --output text --region $AWS_REGION)
SUBNET_IDS=$(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID" --query "Subnets[*].SubnetId" --output text --region $AWS_REGION)
ROUTE_TABLE_IDS=$(aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$VPC_ID" --query "RouteTables[*].RouteTableId" --output text --region $AWS_REGION)
NAT_GATEWAY_ID=$(aws ec2 describe-nat-gateways --filter "Name=vpc-id,Values=$VPC_ID" --query "NatGateways[0].NatGatewayId" --output text --region $AWS_REGION)
EIP_ALLOCATION_ID=$(aws ec2 describe-addresses --query "Addresses[?Tags[?Key=='Name'&&Value=='NATGW-EIP']].AllocationId" --output text --region $AWS_REGION)
SECURITY_GROUP_IDS=$(aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$VPC_ID" --query "SecurityGroups[*].GroupId" --output text --region $AWS_REGION)
NETWORK_ACL_IDS=$(aws ec2 describe-network-acls --filters "Name=vpc-id,Values=$VPC_ID" --query "NetworkAcls[*].NetworkAclId" --output text --region $AWS_REGION)
INSTANCE_IDS=$(aws ec2 describe-instances --filters "Name=vpc-id,Values=$VPC_ID" --query "Reservations[*].Instances[*].InstanceId" --output text --region $AWS_REGION)

echo "Cleaning up AWS resources in VPC: $VPC_ID"

# Step 1: Terminate EC2 Instances
if [[ -n "$INSTANCE_IDS" ]]; then
    echo "Terminating EC2 instances..."
    aws ec2 terminate-instances --instance-ids $INSTANCE_IDS --region $AWS_REGION
    aws ec2 wait instance-terminated --instance-ids $INSTANCE_IDS --region $AWS_REGION
    echo "EC2 instances terminated."
else
    echo "No EC2 instances found."
fi

# Step 2: Delete NAT Gateway
if [[ "$NAT_GATEWAY_ID" != "None" ]]; then
    echo "Deleting NAT Gateway..."
    aws ec2 delete-nat-gateway --nat-gateway-id $NAT_GATEWAY_ID --region $AWS_REGION
    aws ec2 wait nat-gateway-deleted --nat-gateway-id $NAT_GATEWAY_ID --region $AWS_REGION
    echo "NAT Gateway deleted."
fi

# Step 3: Release Elastic IP
if [[ "$EIP_ALLOCATION_ID" != "None" ]]; then
    echo "Releasing Elastic IP..."
    aws ec2 release-address --allocation-id $EIP_ALLOCATION_ID --region $AWS_REGION
    echo "Elastic IP released."
fi

# Step 4: Detach and Delete Internet Gateway
if [[ "$IGW_ID" != "None" ]]; then
    echo "Detaching Internet Gateway..."
    aws ec2 detach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID --region $AWS_REGION
    echo "Deleting Internet Gateway..."
    aws ec2 delete-internet-gateway --internet-gateway-id $IGW_ID --region $AWS_REGION
    echo "Internet Gateway deleted."
fi

# Step 5: Delete Route Tables
for RT_ID in $ROUTE_TABLE_IDS; do
    echo "Deleting Route Table: $RT_ID"
    aws ec2 delete-route-table --route-table-id $RT_ID --region $AWS_REGION
done

# Step 6: Delete Network ACLs (if custom)
for ACL_ID in $NETWORK_ACL_IDS; do
    echo "Deleting Network ACL: $ACL_ID"
    aws ec2 delete-network-acl --network-acl-id $ACL_ID --region $AWS_REGION
done

# Step 7: Delete Subnets
for SUBNET_ID in $SUBNET_IDS; do
    echo "Deleting Subnet: $SUBNET_ID"
    aws ec2 delete-subnet --subnet-id $SUBNET_ID --region $AWS_REGION
done

# Step 8: Delete Security Groups
for SG_ID in $SECURITY_GROUP_IDS; do
    echo "Deleting Security Group: $SG_ID"
    aws ec2 delete-security-group --group-id $SG_ID --region $AWS_REGION
done

# Step 9: Delete the VPC
if [[ "$VPC_ID" != "None" ]]; then
    echo "Deleting VPC: $VPC_ID"
    aws ec2 delete-vpc --vpc-id $VPC_ID --region $AWS_REGION
    echo "VPC deleted successfully."
else
    echo "No VPC found."
fi

echo "Cleanup complete."
