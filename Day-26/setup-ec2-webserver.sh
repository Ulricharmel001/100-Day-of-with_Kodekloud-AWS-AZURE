#!/bin/bash

# AWS EC2 Web Server Setup Script
# Creates an EC2 instance with Nginx web server

# Variables
INSTANCE_NAME="xfusion-ec2"
SECURITY_GROUP_NAME="xfusion-web-sg"
KEY_PAIR_NAME="xfusion-key-pair"  # Change this to your key pair name
AMI_ID=""  # Will be dynamically selected
INSTANCE_TYPE="t2.micro"
REGION="us-east-1"  # Change this to your preferred region

echo "Starting EC2 Web Server Setup..."

# Function to get latest Ubuntu AMI ID
get_ubuntu_ami() {
    echo "Finding latest Ubuntu AMI..."
    AMI_ID=$(aws ec2 describe-images \
        --owners 099720109477 \
        --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*" \
        "Name=state,Values=available" \
        --query "sort_by(Images, &CreationDate)[-1].ImageId" \
        --output text \
        --region $REGION)
    
    if [ -z "$AMI_ID" ]; then
        echo "Error: Could not find Ubuntu AMI"
        exit 1
    fi
    
    echo "Found Ubuntu AMI: $AMI_ID"
}

# Function to create security group
create_security_group() {
    echo "Creating security group: $SECURITY_GROUP_NAME"
    
    # Create security group
    SG_ID=$(aws ec2 create-security-group \
        --group-name $SECURITY_GROUP_NAME \
        --description "Security group for xfusion web server" \
        --query 'GroupId' \
        --output text \
        --region $REGION)
    
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create security group"
        exit 1
    fi
    
    echo "Created security group: $SG_ID"
    
    # Add HTTP rule (port 80)
    aws ec2 authorize-security-group-ingress \
        --group-id $SG_ID \
        --protocol tcp \
        --port 80 \
        --cidr 0.0.0.0/0 \
        --region $REGION
    
    # Add SSH rule (port 22) - restrict to your IP for security
    aws ec2 authorize-security-group-ingress \
        --group-id $SG_ID \
        --protocol tcp \
        --port 22 \
        --cidr 0.0.0.0/0 \
        --region $REGION
    
    echo "Added inbound rules to security group"
}

# Function to launch EC2 instance
launch_instance() {
    echo "Launching EC2 instance: $INSTANCE_NAME"
    
    USER_DATA_SCRIPT="#!/bin/bash
apt update
apt install -y nginx
systemctl start nginx
systemctl enable nginx
"

    # Encode user data script to base64
    USER_DATA_ENCODED=$(echo -n "$USER_DATA_SCRIPT" | base64 -w 0)
    
    # Launch instance
    INSTANCE_ID=$(aws ec2 run-instances \
        --image-id $AMI_ID \
        --count 1 \
        --instance-type $INSTANCE_TYPE \
        --key-name $KEY_PAIR_NAME \
        --security-group-ids $SG_ID \
        --user-data "$USER_DATA_ENCODED" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" \
        --query 'Instances[0].InstanceId' \
        --output text \
        --region $REGION)
    
    if [ $? -ne 0 ]; then
        echo "Error: Failed to launch instance"
        exit 1
    fi
    
    echo "Launched instance: $INSTANCE_ID"
    
    # Wait for instance to be running
    echo "Waiting for instance to be running..."
    aws ec2 wait instance-running --instance-ids $INSTANCE_ID --region $REGION
    echo "Instance is now running"
    
    # Wait for instance status to be ok
    echo "Waiting for instance status to be ok..."
    aws ec2 wait instance-status-ok --instance-ids $INSTANCE_ID --region $REGION
    echo "Instance status is ok"
}

# Main execution
main() {
    echo "Setting up EC2 instance with Nginx web server..."
    
    # Get Ubuntu AMI
    get_ubuntu_ami
    
    # Create security group
    create_security_group
    
    # Launch instance
    launch_instance
    
    # Get instance public IP
    PUBLIC_IP=$(aws ec2 describe-instances \
        --instance-ids $INSTANCE_ID \
        --query 'Reservations[0].Instances[0].PublicIpAddress' \
        --output text \
        --region $REGION)
    
    echo ""
    echo "==========================================="
    echo "EC2 Instance Setup Complete!"
    echo "==========================================="
    echo "Instance Name: $INSTANCE_NAME"
    echo "Instance ID: $INSTANCE_ID"
    echo "Public IP: $PUBLIC_IP"
    echo "Security Group: $SG_ID ($SECURITY_GROUP_NAME)"
    echo "Region: $REGION"
    echo ""
    echo "Nginx should be accessible at: http://$PUBLIC_IP"
    echo "==========================================="
}

# Run main function
main