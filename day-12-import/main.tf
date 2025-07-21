

resource "aws_instance" "my_ec2" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"

  tags = {
    Name = "my-manually-instance"
  }
}


resource "aws_s3_bucket" "my_bucket" {
  bucket = "ankushabc123456"
}
