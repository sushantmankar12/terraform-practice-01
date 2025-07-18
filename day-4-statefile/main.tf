provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI for us-east-2
  instance_type = "t2.micro"

  tags = {
    Name = "day-4"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "sushantabc12345"

  tags = {
    Name = "day-4-s3"
  }

  force_destroy = true
}
