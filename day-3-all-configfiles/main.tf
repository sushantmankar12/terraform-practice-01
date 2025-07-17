resource "aws_instance" "name" {
  ami           = "ami-0eb9d6fc9fab44d24"  # ✅ Direct AMI ID (in quotes)
  instance_type = var.instance_type       # ✅ Use variable for instance type

  tags = {
    Name = "day-3"
  }
}
