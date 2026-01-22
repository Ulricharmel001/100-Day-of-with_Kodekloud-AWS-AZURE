# AWS CLI Commands for Day 25: EC2 Instance and CloudWatch Alarm Setup

## Overview
This document contains the AWS CLI commands needed to complete the Day 25 task of setting up an EC2 instance with CloudWatch monitoring.

## Prerequisites
- AWS CLI installed and configured
- Appropriate IAM permissions for EC2, CloudWatch, and SNS
- AWS credentials configured (using `showcreds` command on aws-client host)

## Step 1: Launch EC2 Instance

### Find an appropriate Ubuntu AMI
```bash
aws ec2 describe-images --owners 099720109477 --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*" "Name=state,Values=available" --output json --query 'Images | sort_by(@,&CreationDate)[-1].ImageId'
```

### Create security group (optional, if needed)
```bash
aws ec2 create-security-group --group-name nautilus-ec2-sg --description "Security group for nautilus EC2 instance"
```

### Launch EC2 instance
```bash
aws ec2 run-instances \
  --image-id ami-xxxxxxxxx \  # Replace with actual Ubuntu AMI ID from previous command
  --count 1 \
  --instance-type t2.micro \
  --key-name your-key-pair \  # Replace with your key pair
  --security-groups nautilus-ec2-sg \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=nautilus-ec2}]'
```

## Step 2: Create CloudWatch Alarm

### Create the CloudWatch alarm for CPU utilization
```bash
aws cloudwatch put-metric-alarm \
  --alarm-name "nautilus-alarm" \
  --alarm-description "Monitor CPU utilization for nautilus-ec2 instance" \
  --metric-name "CPUUtilization" \
  --namespace "AWS/EC2" \
  --statistic "Average" \
  --period 300 \
  --threshold 90 \
  --comparison-operator "GreaterThanOrEqualToThreshold" \
  --evaluation-periods 1 \
  --alarm-actions "arn:aws:sns:region:account:nautilus-sns-topic" \  # Replace with actual ARN
  --dimensions "Name=InstanceId,Value=i-xxxxxxxxx"  # Replace with actual instance ID
```

## Alternative: Tag-based Alarm (for all instances with specific tag)
If you prefer to create an alarm based on instance tags rather than a specific instance ID:

```bash
aws cloudwatch put-metric-alarm \
  --alarm-name "nautilus-alarm" \
  --alarm-description "Monitor CPU utilization for nautilus-ec2 instance" \
  --metric-name "CPUUtilization" \
  --namespace "AWS/EC2" \
  --statistic "Average" \
  --period 300 \
  --threshold 90 \
  --comparison-operator "GreaterThanOrEqualToThreshold" \
  --evaluation-periods 1 \
  --alarm-actions "arn:aws:sns:region:account:nautilus-sns-topic" \  # Replace with actual ARN
  --dimensions "Name=tag:Name,Value=nautilus-ec2"
```

## Step 3: Verify Setup

### Check EC2 instance status
```bash
aws ec2 describe-instances --filters "Name=tag:Name,Values=nautilus-ec2" --query 'Reservations[].Instances[?State.Name==`running`]'
```

### Check CloudWatch alarm status
```bash
aws cloudwatch describe-alarms --alarm-names "nautilus-alarm"
```

### List all alarms
```bash
aws cloudwatch describe-alarms
```

## Step 4: Additional Useful Commands

### Get instance ID
```bash
aws ec2 describe-instances --filters "Name=tag:Name,Values=nautilus-ec2" --query 'Reservations[].Instances[].InstanceId' --output text
```

### Get public IP of the instance
```bash
aws ec2 describe-instances --filters "Name=tag:Name,Values=nautilus-ec2" --query 'Reservations[].Instances[].PublicIpAddress' --output text
```

### Check SNS topic exists
```bash
aws sns list-topics
```

### Test SNS notification (optional)
```bash
aws sns publish --topic-arn "arn:aws:sns:region:account:nautilus-sns-topic" --message "Test notification from nautilus monitoring setup"
```

## Cleanup (when needed)

### Terminate EC2 instance
```bash
aws ec2 terminate-instances --instance-ids i-xxxxxxxxx  # Replace with actual instance ID
```

### Delete CloudWatch alarm
```bash
aws cloudwatch delete-alarms --alarm-names "nautilus-alarm"
```

## Notes
- Replace placeholder values (AMI IDs, instance IDs, region, account number) with actual values from your AWS environment
- The SNS topic `nautilus-sns-topic` should already exist as per the requirements
- Make sure to use the correct AWS region for your setup
- Ensure your AWS CLI credentials have the necessary permissions for all required services