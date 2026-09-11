#!/bin/bash
# ====================================================================
# DevOps Portfolio: Automated AWS Environment Teardown
# Description: This script automates the destruction of resources
#              created by the deployment script to maintain a $0.00 bill.
# ====================================================================

echo "🧹 Starting DevOps infrastructure cleanup..."

# 1. Find and terminate instances attached to the portfolio security group
echo "🔍 Searching for instances attached to 'portfolio-devops-sg'..."
INSTANCE_IDS=$(aws ec2 describe-instances \
    --filters "Name=instance-state-name,Values=running,stopped" "Name=instance.security-group-name,Values=portfolio-devops-sg" \
    --query "Reservations[*].Instances[*].InstanceId" --output text)

if [ -n "$INSTANCE_IDS" ]; then
    echo "⚠️ Terminating instances: $INSTANCE_IDS"
    aws ec2 terminate-instances --instance-ids $INSTANCE_IDS
    echo "⏳ Waiting for instances to terminate completely..."
    aws ec2 wait instance-terminated --instance-ids $INSTANCE_IDS
    echo "✅ Instances terminated successfully."
else
    echo "ℹ️ No running or stopped instances found for this project."
fi

# 2. Delete the Security Group
echo "🛡️ Deleting Security Group 'portfolio-devops-sg'..."
aws ec2 delete-security-group --group-name "portfolio-devops-sg" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✅ Security Group deleted successfully."
else
    echo "⚠️ Could not delete Security Group immediately (it may still be detaching from terminated instances). Please retry in 1-2 minutes."
fi

echo "🎉 TEARDOWN COMPLETE! Account is safe from charges."
