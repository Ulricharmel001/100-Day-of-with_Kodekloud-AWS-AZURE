# Day 1/100

## Task
The Nautilus DevOps team is strategizing the migration of a portion of their infrastructure to the AWS cloud. Recognizing the scale of this undertaking, they have opted to approach the migration in incremental steps rather than as a single massive transition. To achieve this, they have segmented large tasks into smaller, more manageable units. This granular approach enables the team to execute the migration in gradual phases, ensuring smoother implementation and minimizing disruption to ongoing operations. By breaking down the migration into smaller tasks, the Nautilus DevOps team can systematically progress through each stage, allowing for better control, risk mitigation, and optimization of resources throughout the migration process.

**Task Requirement:**  
Create a key pair with the following specifications:
- Name: `xfusion-kp`  
- Type: `RSA`  

---

## Task Description
Today, I created a **key pair** named `xfusion-kp` using the RSA type.  
This is a foundational task in AWS as key pairs are required for secure SSH access to EC2 instances. Completing this task gave me hands-on experience in managing cloud security credentials.

---

## Key Feature
**Key Pair (RSA)** – A key pair in AWS consists of:
- **Public key:** Stored in AWS  
- **Private key:** Stored securely on your local machine  

It allows secure **SSH access** to EC2 instances. Only someone with the private key can connect, ensuring authorized access without using passwords.

---

## Key Takeaway
Key pairs are essential for cloud security. Properly creating and managing them ensures that EC2 instances are protected and can only be accessed by authorized users.
