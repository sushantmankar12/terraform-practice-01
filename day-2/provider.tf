provider "aws" {
  region = "us-east-2"   # ← Region required
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0, < 5.0"
    }
  }
}
