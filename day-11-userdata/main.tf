# just data and resource blocks
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "default-for-az"
    values = ["true"]
  }

  filter {
    name   = "availability-zone"
    values = ["us-east-2a"]
  }
}

resource "aws_instance" "devops_ec2" {
  ami                         = "ami-00399ec92321828f5"
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnet.default.id
  key_name                    = "test"
  associate_public_ip_address = true
  user_data                   = file("${path.module}/test.sh")

  tags = {
    Name = "devops-project-sushant"
  }
}
