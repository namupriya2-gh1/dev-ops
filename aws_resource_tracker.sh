#!/bin/bash

##########################
#Author: Namu
#
#Version: V1
#
#This script will report the AWS resource usage
##########################

echo "=== AWS RESOURCE UTILIZATION REPORT ==="
date
echo""

#Tracker list
#AWS S3
#AWS EC2
#AWS IAM Users

#1. List S3 buckets
echo "S3 buckets:"
aws s3 ls
echo ""

#2. List EC2 instances (Filtered to show raw instance IDs)
echo "EC2 Instance IDs:"
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'
echo ""

#3. List lambda functions (Filtered to show just functions name)
echo "Lambda Functions"
aws lambda list-functions | jq '.Funtions[]?.FunctionName'
echo ""

#4. List IAM users (Filtered to show just usernames)
echo "IAM Users:"
aws iam list-users | jq '.Users[].UserName'


