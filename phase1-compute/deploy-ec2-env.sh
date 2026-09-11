#!/bin/bash
# ====================================================================
# DevOps Portfolio: Automated AWS EC2 Environment Deployment
# Description: This script automates VPC query extraction, builds a 
#              Security Group firewall, opens web ports, and boots an EC2.
# ====================================================================

echo "🚀 Starting DevOps infrastructure deployment..."

# 1. Automatically grab your Default VPC ID using the --query tool
echo "🔍 Fetching your default VPC ID..."
VPC_ID=$(aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text)
echo "✅ Found Default VPC: $VPC_ID"

# 2. Create a Security Group
echo "🛡️ Creating DevOps Security Group..."
SG_ID=$(aws ec2 create-security-group --group-name "portfolio-devops-sg" --description "Security group for web traffic" --vpc-id "$VPC_ID" --query "GroupId" --output text)
echo "✅ Security Group Created with ID: $SG_ID"

# 3. Open port 22 (SSH) and Port 80 (Web traffic)
echo "🔓 Opening Ports 22 and 80..."
aws ec2 authorize-security-group-ingress --group-id "$SG_ID" --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id "$SG_ID" --protocol tcp --port 80 --cidr 0.0.0.0/0

# 4. Launch a Region-Compliant t3.micro Instance
echo "💻 Launching EC2 instance..."
INSTANCE_ID=$(aws ec2 run-instances --image-id ami-0b6d9d3d33ba97d99 --count 1 --instance-type t3.micro --security-group-ids "$SG_ID" --query "Instances[0].InstanceId" --output text)

echo "🎉 DEPLOYMENT COMPLETE!"
echo "-------------------------------------"
echo "Your Live Instance ID is: $INSTANCE_ID"
echo "-------------------------------------"
