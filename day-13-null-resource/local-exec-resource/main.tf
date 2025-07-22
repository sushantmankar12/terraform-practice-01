provider "aws" {
  region = "us-east-2"
}

# Create the RDS instance
resource "aws_db_instance" "mysql_rds" {
  identifier              = "my-mysql-db"
  engine                  = "mysql"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "sahil1234"
  db_name                 = "dev"
  allocated_storage       = 20
  skip_final_snapshot     = true
  publicly_accessible     = true
}

# Use null_resource to execute the SQL script from your local machine
resource "null_resource" "local_sql_exec" {
  depends_on = [aws_db_instance.mysql_rds]

  provisioner "local-exec" {
    command = "mysql -h ${aws_db_instance.mysql_rds.address} -u admin -psahil1234 dev < init.sql"
  }

  triggers = {
    always_run = timestamp()
  }
}
