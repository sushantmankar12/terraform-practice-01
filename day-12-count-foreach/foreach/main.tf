provider "aws" {
  region = "us-east-2"
}

variable "ami" {
  type    = string
  default = "ami-0fb653ca2d3203ac1" # ✅ Valid Ubuntu AMI for us-east-2
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "env" {
  type    = list(string)
  default = ["one", "three"]
}

resource "aws_instance" "sandbox" {
  ami           = var.ami
  instance_type = var.instance_type
  for_each      = toset(var.env)

  tags = {
    Name = each.value
  }
}
