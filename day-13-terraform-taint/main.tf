provider "aws" {
  region = "us-east-2"  # ✅ Ohio region
}

resource "aws_instance" "name" {
  ami           = "ami-0b8b44ec9a8f90422"  # ✅ Amazon Linux 2 AMI in us-east-2
  instance_type = "t2.micro"
  # key_name    = "your-key-name"

  tags = {
    Name = "OhioEC2"
  }
}
