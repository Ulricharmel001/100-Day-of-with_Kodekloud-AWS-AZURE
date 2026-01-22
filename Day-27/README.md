# Day 27/100 — AWS Public VPC Setup: Creating Public VPC with Subnet and EC2 Instance for Public-Facing Services

## Task Overview
Set up a new public VPC to support a set of public-facing services. This VPC will host various resources that need to be accessible over the internet, including a public subnet with automatic IP assignment and an EC2 instance with SSH access enabled.

## Important Terms
- **VPC (Virtual Private Cloud)**: Isolated virtual network in AWS where you can launch AWS resources
- **Public Subnet**: Subnet that has a route to an Internet Gateway, allowing resources to be accessible from the internet
- **Internet Gateway**: Horizontally scaled, redundant gateway that enables communication between instances in your VPC and the internet
- **EC2 Instance**: Virtual server in the AWS cloud
- **Auto-assign Public IP**: Feature that automatically assigns a public IP address to instances launched in the subnet
- **Security Group**: Virtual firewall that controls inbound and outbound traffic for AWS resources

## Why Use Public VPC?
A public VPC is essential for hosting resources that need to be accessible over the internet, such as web servers, APIs, and other public-facing applications. By creating a properly configured public VPC with public subnets, you ensure that your applications can receive traffic from the internet while maintaining security through proper network controls.

## Prerequisites
- AWS account with appropriate permissions
- AWS credentials provided for the task
- Basic understanding of AWS networking concepts
- Access to AWS Management Console

## Step-by-Step Instructions

### Step 1: Create Public VPC
1. Navigate to the VPC dashboard in AWS Console
2. Click on "Virtual Private Clouds" in the left sidebar
3. Click "Create VPC"
4. Enter the name `devops-pub-vpc`
5. Set IPv4 CIDR block to a valid range (e.g., 10.0.0.0/16)
6. Ensure IPv6 CIDR block is set to "Amazon-provided IPv6 CIDR block" (optional)
7. Select the appropriate region
8. Click "Create VPC"

### Step 2: Enable Auto-Assign Public IP for Subnet
1. After creating the VPC, navigate to the "Subnets" section in the left sidebar
2. Find the subnet associated with your newly created VPC
3. Select the subnet and click on "Actions" → "Modify auto-assign IP settings"
4. Check the box for "Enable auto-assign public IPv4 address"
5. Click "Save"

### Step 3: Create Public Subnet
1. In the VPC dashboard, click on "Subnets" in the left sidebar
2. Click "Create subnet"
3. Enter the name `devops-pub-subnet`
4. Select the VPC `devops-pub-vpc` from the dropdown
5. Choose an Availability Zone
6. Set IPv4 CIDR block (e.g., 10.0.1.0/24) within the VPC range
7. Ensure "Auto-assign IPv4" is set to "Yes"
8. Click "Create subnet"

### Step 4: Create Internet Gateway
1. Navigate to "Internet Gateways" in the left sidebar
2. Click "Create internet gateway"
3. Enter the name `devops-pub-igw`
4. Click "Create internet gateway"

### Step 5: Attach Internet Gateway to VPC
1. Select the newly created internet gateway `devops-pub-igw`
2. Click on the "Actions" button and select "Attach to VPC"
3. Choose the VPC `devops-pub-vpc` from the dropdown
4. Click "Attach internet gateway"

### Step 6: Update Route Table for Public Subnet
1. Navigate to "Route Tables" in the left sidebar
2. Find the route table associated with your VPC `devops-pub-vpc`
3. Select the route table and go to the "Routes" tab
4. Click "Edit routes" and then "Add route"
5. Set destination to 0.0.0.0/0 (for all traffic to internet)
6. Set target to the internet gateway `devops-pub-igw`
7. Click "Save routes"

### Step 7: Create Security Group for EC2 Instance
1. Navigate to the EC2 dashboard in AWS Console
2. Click on "Security Groups" in the left sidebar
3. Click "Create security group"
4. Enter the name `devops-pub-sg`
5. Add an inbound rule allowing SSH (port 22) traffic from anywhere (0.0.0.0/0)
6. Select the VPC `devops-pub-vpc` and click "Create security group"

### Step 8: Launch EC2 Instance in Public VPC
1. Navigate to the EC2 dashboard in AWS Console
2. Click on "Instances" in the left sidebar
3. Click "Launch Instances"
4. Enter the name `devops-pub-ec2`
5. Choose an AMI (e.g., Amazon Linux 2)
6. Select instance type `t2.micro`
7. Select the VPC `devops-pub-vpc`
8. Select the subnet `devops-pub-subnet`
9. Select the security group `devops-pub-sg`
10. Configure storage and tags as needed
11. Click "Launch Instances"

## Key Console Actions Summary
- VPC → Virtual Private Clouds → Create VPC - Create public VPC named devops-pub-vpc
- VPC → Subnets → Create subnet - Create public subnet named devops-pub-subnet
- VPC → Internet Gateways → Create internet gateway - Create internet gateway
- VPC → Internet Gateways → Attach to VPC - Attach internet gateway to VPC
- VPC → Route Tables → Edit routes - Add route to internet gateway
- EC2 → Security Groups → Create security group - Create security group for SSH access
- EC2 → Instances → Launch Instances - Launch EC2 instance in public VPC

## Expected Outcome
The public VPC `devops-pub-vpc` should be created with a public subnet `devops-pub-subnet` that automatically assigns public IP addresses to resources. The EC2 instance `devops-pub-ec2` should be accessible over the internet with SSH port 22 open, allowing secure remote access for managing public-facing applications.

## Troubleshooting
- If the EC2 instance doesn't get a public IP, verify that auto-assign public IP is enabled for the subnet
- If SSH access fails, check that the security group allows inbound traffic on port 22
- Verify that the route table has a route to the internet gateway (0.0.0.0/0)
- Ensure the internet gateway is properly attached to the VPC
- Check that the EC2 instance is launched in the correct subnet within the public VPC
- Confirm that your SSH key pair is correctly configured for the instance

## Screenshots

### VPC Created Successfully
![VPC Created Successfully](Day-27-vpc-created.png)

### Public Subnet Created
![Public Subnet Created](Day-27-public-subnet-created.png)

### Internet Gateway Created
![Internet Gateway Created](Day-27-internet-gateway-created.png)

### Internet Gateway Attached to VPC
![Internet Gateway Attached](Day-27-igw-attached-to-vpc.png)

### Route Table Updated with Internet Gateway Route
![Route Table Updated](Day-27-route-table-updated.png)

### Security Group Created for SSH Access
![Security Group Created](Day-27-security-group-created.png)

### EC2 Instance Launched in Public VPC
![EC2 Instance Launched](Day-27-ec2-instance-launched.png)

### EC2 Instance with Public IP Assigned
![Instance with Public IP](Day-27-instance-public-ip-assigned.png)

### Task Completion Congratulations
![Task Completion](Day-27-congrats-on-completion.png)