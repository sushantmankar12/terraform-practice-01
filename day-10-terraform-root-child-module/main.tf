

module "vpc" {
  source        = "./modules/vpc"
  vpc_cidr      = "10.0.0.0/16"
  subnet_cidr1  = "10.0.1.0/24"
  subnet_cidr2  = "10.0.2.0/24"
  az1           = "us-east-2a"
  az2           = "us-east-2b"
}
module "ec2" {
  source        = "./modules/ec2"
  ami_id        = "ami-0c55b159cbfafe1f0"  # Replace with valid AMI                               main.tf
  instance_type = "t2.micro"
  subnet_id = module.vpc.subnet_ids[0] 
}


module "rds" {
  source         = "./modules/rds"
  subnet_ids     = module.vpc.subnet_ids
  instance_class = "db.t3.micro"
  db_name        = "mydb"
  db_user        = "admin"
  db_password    = "sahil1234"
}
