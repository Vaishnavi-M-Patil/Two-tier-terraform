# Deploy two-tier architecture in AWS using Terraform
## 🚀 Overview:
This project provisions a two-tier architecture on AWS using Terraform. It separates the application into a frontend (public subnet) and backend (private subnet) tier. Infrastructure is defined using modular, reusable Terraform code with remote state management and basic automation.

## ⚖️ Prerequisites:
- Terraform CLI
- AWS CLI
- AWS Account with permissions to create infrastructure
- Code Editor (e.g., Visual Studio Code)


## 🛠️ Architecture Diagram:
![architecture](https://github.com/Vaishnavi-M-Patil/Two-tier-terraform/blob/main/assets/architecture.png)

## 🔧 Features:
- Modular Terraform code (vpc, application, database modules)
- Two-tier architecture with frontend (EC2) and backend (RDS)
- Public and private subnets across multiple AZs
- Application Load Balancer for traffic distribution
- Health check on / path to monitor EC2 availability
- Security groups to restrict traffic between tiers
- User data scripts to install Apache and host a static site
- Terraform remote state with S3 + DynamoDB locking


## 📁 Project Structure:
├── modules/  
&nbsp;│ ├── vpc/&nbsp;&nbsp;&nbsp;# VPC, subnets, route tables, IGW  
&nbsp;│ ├── application/&nbsp;# EC2 instances, security groups, user data  
&nbsp;│ └── database/&nbsp;&nbsp;# (Optional) RDS resources  
├── main.tf&nbsp;&nbsp;&nbsp;# Entry point for the root module  
├── variables.tf&nbsp;&nbsp;# Input variables  
├── outputs.tf&nbsp;&nbsp;# Output variables  
├── terraform.tfvars&nbsp;# Variable values  
├── provider.tf&nbsp;&nbsp;# AWS provider configuration  


## 💻 Getting Started:
### ☁️ Create provider.tf file:
The `provider.tf` file in Terraform is a configuration file that specifies the cloud provider and its corresponding plugin that Terraform will use to manage resources in that provider.In this project, we use the AWS provider.Also add the backend configuration for remote state in the `provider.tf` file.
#### Set Up S3 and DynamoDB for Remote State
Before running terraform init, manually create:
- An S3 bucket (e.g., state-file-bucket-tf-121)
- A DynamoDB table (e.g., state_lock_table) with LockID as the primary key


### 🧱 VPC Module:
The VPC module in this project defines all networking components required by the infrastructure. It includes:
- **Virtual Private Cloud (VPC):** An isolated network environment.
- **Subnets:**
  - Public subnets for hosting frontend EC2 instances.
  - Private subnets for hosting backend RDS instances.
- **Internet Gateway:** Enables internet access for public subnets.
- **Route Tables:** Define routing rules for each subnet.

### 🛠️ application Module:
The application module is responsible for provisioning and configuring the frontend tier of the infrastructure. It includes:
- Launch **EC2 Instances** in public subnets (across multiple Availability Zones).
- Attaching **security groups** to control inbound (HTTP/SSH) and outbound traffic.
- Run **User Data** Scripts to:
  - Install and start Apache web server
  - Serve a static HTML page indicating the instance identity
- **Application Load Balancer (ALB)**:
  - Distributes incoming HTTP traffic evenly across the frontend EC2 instances.
  - Provides fault tolerance by routing traffic only to healthy instances.
  - Configured with health checks to monitor instance health on the / path.
  - Listens on port 80 (HTTP) and forwards traffic to backend EC2 instances on port 80.
- Expose **Public IPs** of frontend EC2 instances via output variables.

### 📝 Database Module:
The database module provisions the backend database tier in the private subnet. It focuses on high availability, data durability, and restricted access. Key features include:
- Creating an RDS instance (MySQL) in private subnets.
- Defining a DB subnet group with private subnets across multiple AZs.
- Attaching a security group that only allows access from the application servers.
- RDS is securely isolated and only reachable from the frontend EC2 instances.


### 🚀 Let's deploy!
Make sure you have already inserted your AWS credentials and are operating from the root directory before starting these Terraform commands.
#### 1. terraform init:
The terraform init the command is used to initialize a new or existing Terraform configuration. This command downloads the required provider plugins and sets up the backend for storing state.
```
terraform init
```
#### 2. terraform plan:
The terraform plan the command is used to create an execution plan for the Terraform configuration. This command shows what resources Terraform will create, modify, or delete when applied.
```
terraform plan
```
#### 3. terraform apply:
The terraform apply the command is used to apply the Terraform configuration and create or modify resources in the target environment.
```
terraform apply
```

### 📤 Output:
After applying, Terraform will output:
- Load balancer DNS (to access the frontend)
- Public IPs of EC2 instances


### 🔍 Verify Deployment in AWS Console
#### 1. VPC and Network resources
![VPC image]()

#### 2. EC2 instances
![VPC image]()

#### 3. Load Balancer
![VPC image]()

#### 4. Target Group
![VPC image]()

#### 5. RDS MYSQL Database
![VPC image]()

#### 6. Web Server on EC2 Instances
web server-1
![VPC image]()
web server-2
![VPC image]()

#### 7. Security Groups
![VPC image]()

## ⚠️ Important: Cleanup Your Resources:
Remember to delete all your AWS resources ( Application Load Balancer, RDS instances, EC2 instances, etc.) and release any Elastic IPs once you’re done to avoid ongoing charges.

### 🙏 Thank You!!!
