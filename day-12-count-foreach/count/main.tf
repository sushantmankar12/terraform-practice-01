#resource "aws_instance" "example" {
 # ami           = "ami-0eb9d6fc9fab44d24"  # devloper=1-2-3
 # instance_type = "t2.micro"
 # count         = 3

  #tags = {
    #Name = "dev${count.index + 1}"
 # }
#}

# devloper= 0-1-2-
#resource "aws_instance" "example" {
 # ami           = "ami-0eb9d6fc9fab44d24"
  #instance_type = "t2.micro"
  #count         = 3

  #tags = {
   # Name = "dev-${count.index}"
  #}
# }

######differnt namees -2 use ###########
 variable "env" {
  type    = list(string)
  default = ["dev", "prod"]
}

resource "aws_instance" "name2" {
  ami           = "ami-0c55b159cbfafe1f0"   # ✅ valid AMI for us-east-2
  instance_type = "t2.micro"
  count         = length(var.env)

  tags = {
    Name = var.env[count.index]
  }
}


# examaple 3 create iam users


#variable "user_names" {
 # description = "IAM usernames"
  #type      = list(string)
  #default     = ["user1", "user2", "user3"]
#}

#resource "aws_iam_user" "example" {
 # count = length(var.user_names)
  #name  = var.user_names[count.index]
#}

