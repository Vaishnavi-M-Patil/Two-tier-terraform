terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta1"
    }
  }
  backend "s3" {
    bucket = "state-file-bucket-tf-121"
    region = "ap-northeast-1"
    key = "backend/terraform.tfstate"
    dynamodb_table = "state_lock_table"
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

