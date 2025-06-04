# Two-tier-terraform

## 🚀 Overview:
This project provisions a two-tier architecture on AWS using Terraform. It separates the application into a frontend (public subnet) and backend (private subnet) tier. Infrastructure is defined using modular, reusable Terraform code with remote state management and basic automation.

## 🧱 Architecture Diagram:


## 🔧 Features:
- Modular Terraform code (vpc, application, database modules)
- Two-tier architecture with frontend (EC2) and backend (RDS)
- Public and private subnets across multiple AZs
- Application Load Balancer for traffic distribution
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
