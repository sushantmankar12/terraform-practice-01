resource "aws_s3_object" "test_file" {
  bucket  = "sahil1234abc"
  key     = "demo.txt"
  content = "This is a test file from Terraform"
  acl     = "public-read"
}
