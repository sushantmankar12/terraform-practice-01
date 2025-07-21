provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "name" {
  ami           = "ami-00399ec92321828f5"   # ✅ Valid AMI ID
  instance_type = "t2.micro"

  tags = {
    Name = "my-ec2"
  }
}

resource "aws_s3_bucket" "name" {
  bucket = "my-unique-bucket-terraform-7212025"

  tags = {
    Name = "my-test-bucket"
  }
}
