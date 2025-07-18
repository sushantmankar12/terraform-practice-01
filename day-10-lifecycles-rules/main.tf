provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "name" {
  ami           = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  # key_name     = "test"  # Optional: for SSH

  tags = {
    Name = "test"
  }

  lifecycle {
    create_before_destroy = true
  }

  # lifecycle {
  #   ignore_changes = [tags]
  # }

  # lifecycle {
  #   prevent_destroy = true
  # }
}
