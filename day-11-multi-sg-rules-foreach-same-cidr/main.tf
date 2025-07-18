resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_security_group" "web_sg" {
  name        = "multi-rule-sg"
  description = "Security group with multiple rules using for_each"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "multi-rule-sg"
  }
}

locals {
  ports = {
    "http"  = 80
    "https" = 443
    "ssh"   = 22
  }
}

resource "aws_security_group_rule" "ingress" {
  for_each = local.ports

  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg.id

  description = "Allow ${each.key} from 0.0.0.0/0"
}
