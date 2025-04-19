terraform {
  required_version = ">= 1.10.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "my-reception-memories"
    key    = "ecs-02/CI-CD-Fargate/terraform.tfstate" # here we need to change the bucket name based on requirement
    region = "us-east-1"
    encrypt = true
    use_lockfile = true # here I am using latest state locking feature of Terraform
  }
}
#assume role method
provider "aws" {
  region = "us-east-1"
  access_key = var.aws-access-key-id
  secret_key = var.aws-secret-access-key
  assume_role {
    role_arn = var.aws-iam-role-arn
    session_name = "terraform-session"
  }
}
