terraform {
  backend "s3" {
    bucket        = "sahil1234abc"
    key           = "terraform.tfstate"
    region        = "us-east-2"
    use_lockfile  = true
  }
}
