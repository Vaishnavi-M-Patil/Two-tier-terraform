# Two-tier-terraform

## 🚀 Overview:
This project provisions a two-tier architecture on AWS using Terraform. It separates the application into a frontend (public subnet) and backend (private subnet) tier. Infrastructure is defined using modular, reusable Terraform code with remote state management and basic automation.

## ⚖️ Prerequisites:
- Terraform CLI
- AWS CLI
- AWS Account with permissions to create infrastructure
- Code Editor (e.g., Visual Studio Code)


## 🧱 Architecture Diagram:


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
├── main.tf # Entry point for the root module  
├── variables.tf # Input variables  
├── outputs.tf # Output variables  
├── modules/  
│ ├── vpc/ # VPC, subnets, route tables, IGW  
│ ├── application/ # EC2 instances, security groups, user data  
│ └── database/ # (Optional) RDS resources  
├── terraform.tfvars # Variable values  
├── provider.tf # AWS provider configuration  

## 💻 Getting Started:
### 1. Create provider.tf file:
The provider.tf file in Terraform is a configuration file that specifies the cloud provider and its corresponding plugin that Terraform will use to manage resources in that provider.In this project, we use the AWS provider.


.markdown-body {
  --md-code-background: #e3dcef;
  --md-code-text: #4a2b7b;
  --md-code-tabs: #c6b8dd;
  --md-code-radius: 4px;
}

```
provider "aws" {
  region = var.region
}
```

### Set Up S3 and DynamoDB for Remote State
Before running terraform init, manually create:
- An S3 bucket (e.g., state-file-bucket-tf-121)
- A DynamoDB table (e.g., state_lock_table) with LockID as the primary key

