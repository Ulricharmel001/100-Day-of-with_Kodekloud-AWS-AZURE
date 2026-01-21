# AWS Console Instructions: Creating EC2 Instance with Nginx

## Overview
This document provides step-by-step instructions for creating an EC2 instance named `xfusion-ec2` with Nginx web server using the AWS Management Console.

## Prerequisites
- AWS Account with appropriate permissions
- AWS Credentials (Access Key ID and Secret Access Key)
- Basic understanding of AWS services

## Steps to Create EC2 Instance with Nginx

### 1. Log into AWS Management Console
- Go to https://aws.amazon.com/console/
- Sign in with your AWS credentials

### 2. Navigate to EC2 Service
- From the AWS Management Console, search for "EC2" in the services search bar
- Click on "EC2" under Compute section

### 3. Create Security Group
- In the left navigation panel, click on "Security Groups" under "Network & Security"
- Click "Create security group"
- Fill in the details:
  - Security group name: `xfusion-web-sg`
  - Description: "Security group for xfusion web server"
  - VPC: Select your default VPC
- Add inbound rules:
  - Type: HTTP, Protocol: TCP, Port: 80, Source: 0.0.0.0/0 (for internet access)
  - Type: SSH, Protocol: TCP, Port: 22, Source: Your IP address (for secure access)
- Click "Create security group"

### 4. Launch EC2 Instance
- In the left navigation panel, click on "Instances" under "Instances"
- Click "Launch Instance"
- Configure the instance:
  - Name: `xfusion-ec2`
  - Application and OS Images: Choose Ubuntu Server 20.04 LTS or newer
  - Instance type: t2.micro (free tier eligible)
  - Key pair: Select an existing key pair or create a new one
  - Network settings: Select the security group created in step 3

### 5. Configure User Data Script
- Scroll down to "Advanced details" section
- In the "User data" field, paste the following script:
```
#!/bin/bash
# Update packages
apt update

# Install Nginx
apt install -y nginx

# Start and enable Nginx service
systemctl start nginx
systemctl enable nginx

# Optional: Create a simple custom index page
cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to xFusion Web Server</title>
</head>
<body>
    <h1>xFusion Web Server is Running!</h1>
    <p>This server was automatically configured during launch.</p>
    <p>Server: $(hostname)</p>
    <p>Date: $(date)</p>
</body>
</html>
EOF

# Restart Nginx to apply changes
systemctl restart nginx
```

### 6. Launch the Instance
- Review all configurations
- Click "Launch instance"
- Wait for the instance status to change to "Running"

### 7. Access the Web Server
- Copy the Public IP address of the instance from the EC2 console
- Open a web browser and navigate to `http://[PUBLIC_IP_ADDRESS]`
- You should see the Nginx welcome page or the custom page created by the user data script

## Verification Steps
1. Check that the instance is running in the EC2 console
2. Verify that the security group allows HTTP traffic on port 80
3. Access the web server using the public IP address
4. Confirm that Nginx is running by checking the default page

## Troubleshooting Tips
- If the website is not accessible, check the security group settings to ensure port 80 is open
- Verify that the user data script executed properly by connecting via SSH
- Check the instance system logs in the EC2 console for any errors during boot
- Ensure the instance is in a public subnet with Internet Gateway attached

## Cleanup
When no longer needed, terminate the instance:
- Select the instance in the EC2 console
- Click "Instance State" → "Terminate"
- Confirm termination