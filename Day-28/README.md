# Day 28/100 — AWS ECR Setup: Creating Private Container Registry and Pushing Docker Images

## Task Overview
Set up a private Amazon Elastic Container Registry (ECR) repository to store Docker images. Build a Docker image from a Dockerfile located on the aws-client host and push this image to the ECR repository. This process is essential for maintaining and deploying containerized applications in a streamlined manner.

## Important Terms
- **Amazon ECR (Elastic Container Registry)**: Fully managed container registry service that stores, manages, and deploys Docker images
- **Private Repository**: ECR repository that restricts access to authorized users and roles within your AWS account
- **Docker Image**: Lightweight, standalone, executable package that includes everything needed to run a piece of software
- **Dockerfile**: Text document that contains all the commands a user could call on the command line to assemble an image
- **Docker Tag**: Label applied to a Docker image to identify different versions or variants
- **AWS CLI**: Command-line interface for interacting with AWS services

## Why Use Amazon ECR?
Amazon ECR is essential for containerized application deployment as it provides a secure, scalable, and reliable container registry. It integrates seamlessly with other AWS services like ECS and EKS, offers fine-grained access control, and eliminates the need to operate your own container registry infrastructure. ECR also provides lifecycle policies for automated image cleanup and vulnerability scanning for enhanced security.

## Prerequisites
- AWS account with appropriate permissions
- AWS CLI installed and configured
- Docker installed and running on the client machine
- Dockerfile located at /root/pyapp directory on aws-client host
- Basic understanding of Docker and containerization concepts
- Access to AWS Management Console

## Step-by-Step Instructions

### Step 1: Create Private ECR Repository
1. Navigate to the ECR dashboard in AWS Console
2. Click on "Repositories" in the left sidebar
3. Click "Create repository"
4. Select "Private" repository type
5. Enter the repository name `devops-ecr`
6. Configure scan settings as needed (basic or enhanced)
7. Configure encryption settings if required (default is AWS managed key)
8. Click "Create repository"

### Step 2: Install and Configure AWS CLI (if not already done)
1. On the aws-client host, ensure AWS CLI is installed
2. Configure AWS CLI with the provided credentials using:
   ```
   aws configure
   ```
3. Enter the Access Key ID, Secret Access Key, Region (us-east-1), and Output Format

### Step 3: Install Docker (if not already installed)
1. On the aws-client host, install Docker if not already present
2. Start the Docker service:
   ```
   sudo systemctl start docker
   sudo systemctl enable docker
   ```
3. Verify Docker is running:
   ```
   docker --version
   ```

### Step 4: Authenticate Docker to ECR
1. Retrieve the login command from AWS CLI:
   ```
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com
   ```
2. Replace `<account-id>` with your actual AWS account ID
3. Or use the full command provided in the ECR repository console

### Step 5: Navigate to Dockerfile Location
1. On the aws-client host, navigate to the directory containing the Dockerfile:
   ```
   cd /root/pyapp
   ```

### Step 6: Build Docker Image
1. Build the Docker image using the Dockerfile in the current directory:
   ```
   docker build -t devops-ecr:latest .
   ```
2. The `-t` flag tags the image with the name `devops-ecr` and tag `latest`
3. The `.` specifies to build from the current directory

### Step 7: Tag Docker Image for ECR
1. Tag the locally built image with the ECR repository URI:
   ```
   docker tag devops-ecr:latest <account-id>.dkr.ecr.us-east-1.amazonaws.com/devops-ecr:latest
   ```
2. Replace `<account-id>` with your actual AWS account ID

### Step 8: Push Docker Image to ECR
1. Push the tagged image to the ECR repository:
   ```
   docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/devops-ecr:latest
   ```
2. Wait for the upload to complete successfully

### Step 9: Verify Image in ECR
1. Navigate back to the ECR dashboard in AWS Console
2. Select the `devops-ecr` repository
3. Verify that the `latest` tag appears in the image tags section
4. Check that the image properties are displayed correctly

## Key Console Actions Summary
- ECR → Repositories → Create repository - Create private ECR repository named devops-ecr
- AWS CLI → Configure - Set up AWS CLI with credentials
- Docker → Build - Build Docker image from Dockerfile
- Docker → Tag - Tag image with ECR repository URI
- Docker → Push - Push image to ECR repository
- ECR → Repositories → View repository - Verify image pushed successfully

## Expected Outcome
The private ECR repository `devops-ecr` should be created successfully, and the Docker image built from the Dockerfile at `/root/pyapp` should be pushed to the repository with the `latest` tag. The image should be visible in the ECR console with its metadata and properties correctly displayed.

## Troubleshooting
- If authentication fails, ensure AWS CLI is properly configured with valid credentials
- If Docker build fails, verify the Dockerfile exists at /root/pyapp and has correct syntax
- If push fails, verify the Docker image is properly tagged with the ECR repository URI
- If permission errors occur, ensure IAM permissions allow ECR operations
- Check that Docker daemon is running on the client machine
- Verify the correct AWS region is specified in all commands
- Ensure the account ID in the ECR URI matches your AWS account

## Screenshots

### ECR Repository Created Successfully
![ECR Repository Created](Day-28-ecr-repository-created.png)

### Dockerfile Located in pyapp Directory
![Dockerfile Location](Day-28-dockerfile-location.png)

### Docker Image Built Successfully
![Docker Image Built](Day-28-docker-image-built.png)

### Docker Image Tagged for ECR
![Docker Image Tagged](Day-28-docker-image-tagged.png)

### Docker Image Pushed to ECR
![Docker Image Pushed](Day-28-docker-image-pushed.png)

### Image Visible in ECR Repository
![Image in ECR](Day-28-image-visible-in-ecr.png)

### ECR Repository Details
![ECR Details](Day-28-ecr-repository-details.png)

### Task Completion Congratulations
![Task Completion](Day-28-congrats-on-completion.png)