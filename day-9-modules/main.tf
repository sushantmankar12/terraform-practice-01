resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name =var.key
    availability_zone = var.az
    tags = {
      Name ="dev"
    }
  

  
}
resource "aws_s3_bucket" "name" {
  bucket = var.bucket

  tags = {
    Name = "MyS3Bucket"
  }
}

