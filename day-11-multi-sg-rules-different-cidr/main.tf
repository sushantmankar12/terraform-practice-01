resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "day-11-vpc"
  }
}

resource "aws_security_group" "multi_sg" {
  name        = "multi-sg-different-cidrs"
  description = "Security group with multiple ingress rules with different CIDRs"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "day-11-sg"
  }
}

# Map of descriptions and CIDRs for different access levels
locals {
  access_rules = {
    office_ip   = "203.0.113.0/24"
    home_ip     = "198.51.100.0/24"
    datacenter  = "192.0.2.0/24"
  }
}

resource "aws_security_group_rule" "ingress_rules" {
  for_each = local.access_rules

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [each.value]
  security_group_id = aws_security_group.multi_sg.id
  description       = "Allow SSH from ${each.key}"
}
