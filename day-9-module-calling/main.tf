provider "aws" {
  region = "us-east-2"
}

module "project" {
  source         = "git::https://github.com/sushantmankar12/terraform-practice-01.git//day-9-modules"
  ami_id         = "ami-00399ec92321828f5"
  instance_type  = "t2.micro"
  key            = ""  # empty if no key pair
  az             = "us-east-2a"
  bucket = "sushanth2023"
}
