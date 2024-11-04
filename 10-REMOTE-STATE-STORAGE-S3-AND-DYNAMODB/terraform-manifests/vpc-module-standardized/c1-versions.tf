# Terraform Block
terraform {
  required_version = "~> 1.9.6" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  #Add backend as S3 for Remote State Storage

  backend "s3" {
    bucket = "terraform-backend-1987"
    key = "dev/project1-vpc/terraform.tfstate"
    region = "us-east-1"

    #Enable state locking with DynamoDB
    dynamodb_table = "dev-project1-vpc"
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "default"
}

