resource "aws_instance" "name" {
  ami           = "ami-0eb9d6fc9fab44d24"
  instance_type = "t2.micro"
  key_name      = "test"

  tags = {
    Name = "Day2-EC2"
  }
}
