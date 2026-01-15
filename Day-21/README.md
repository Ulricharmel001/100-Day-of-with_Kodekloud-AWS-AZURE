# Day 21/100 — Setting Up EC2 Instance with Elastic IP

## Task Description
The Nautilus DevOps Team has received a new request from the Development Team to set up a new EC2 instance. This instance will be used to host a new application that requires a stable IP address. To ensure that the instance has a consistent public IP, an Elastic IP address needs to be associated with it. The instance will be named nautilus-ec2, and the Elastic IP will be named nautilus-eip. This setup will help the Development Team to have a reliable and consistent access point for their application.

Create an EC2 instance named nautilus-ec2 using any linux AMI like ubuntu, the Instance type must be t2.micro and associate an Elastic IP address with this instance, name it as nautilus-eip.

Use below given AWS Credentials: (You can run the showcreds command on aws-client host to retrieve these credentials)
Console URL https://624252175947.signin.aws.amazon.com/console?region=us-east-1
Username kk_labs_user_757524
Password 6tpAHwo@k%BK
Start Time Wed Jan 14 13:04:36 UTC 2026
End Time Wed Jan 14 14:04:36 UTC 2026


Notes:

    Create the resources only in us-east-1 region.

    To display or hide the terminal of the AWS client machine, you can use the expand toggle button as shown below: command to complete this task

---

## What I Learned
- Creating EC2 instances with specific configurations
- Understanding Elastic IP addresses and their importance
- Associating Elastic IPs with EC2 instances
- Using AWS Console to manage compute resources
- Importance of stable IP addresses for applications

---

## Technical Terms
- **EC2**: Amazon Elastic Compute Cloud service providing scalable computing capacity
- **Elastic IP**: Static IPv4 address designed for dynamic cloud computing
- **Instance Type**: Category of EC2 instance with specific CPU, memory, storage, and networking capacity
- **AMI**: Amazon Machine Image - template for launching EC2 instances
- **t2.micro**: A general purpose instance type with 1 vCPU and 1 GiB RAM
- **Public IP**: Address accessible from the internet
- **Private IP**: Internal IP address within the VPC
- **VPC**: Virtual Private Cloud - isolated network environment

---

## Commands Used

### Step 1: Launch EC2 Instance
Using the AWS Console:
1. Navigate to EC2 Dashboard
2. Click "Launch Instance"
3. Configure instance details:
   - Name: nautilus-ec2
   - AMI: Ubuntu (or any Linux distribution)
   - Instance Type: t2.micro
   - Configure remaining settings as needed

### Step 2: Allocate Elastic IP Address
Using the AWS Console:
1. Navigate to EC2 Dashboard
2. In the left panel, click "Elastic IPs"
3. Click "Allocate Elastic IP address"
4. Click "Allocate"
5. Select the newly allocated Elastic IP
6. Click "Actions" → "Associate Elastic IP address"
7. Choose the nautilus-ec2 instance
8. Complete the association

### Alternative AWS CLI Commands:
```bash
# Launch EC2 instance
aws ec2 run-instances \
    --image-id ami-xxxxxxxxx \
    --instance-type t2.micro \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=nautilus-ec2}]'

# Allocate Elastic IP
aws ec2 allocate-address --domain vpc

# Associate Elastic IP with instance
aws ec2 associate-address --instance-id i-xxxxxxxxx --allocation-id eipalloc-xxxxxxxxx
```

**Note**: Replace placeholder values (ami-xxxxxxxxx, i-xxxxxxxxx, eipalloc-xxxxxxxxx) with actual resource IDs from your account.

---

## Key Steps
1. Created EC2 instance named `nautilus-ec2` with t2.micro instance type
2. Selected a Linux AMI (Ubuntu or similar)
3. Allocated an Elastic IP address named `nautilus-eip`
4. Associated the Elastic IP with the EC2 instance
5. Verified the association in the AWS Console

---

## Screenshots

_Task details:_
![Task Details](./day-21-task-details.png)

_EC2 Instance created:_
![EC2 Instance](./day-21-ec2-instance.png)

_Elastic IP allocated:_
![Elastic IP](./day-21-elastic-ip.png)

_EC2 Instance with Elastic IP:_
![Instance with EIP](./day-21-instance-with-eip.png)

_Congratulations on completion:_
![Congratulations on Completion](./day-21-congrat-on-completion.png)