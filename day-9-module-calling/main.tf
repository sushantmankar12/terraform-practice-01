module "project" {
  source         = "../day-9-modules"
  ami_id         = "ami-00399ec92321828f5"
  instance_type  = "t2.micro"
  key            = ""                     # now it's okay
  az             = "us-east-2a"
  bucket         = "sushant1234"
}
