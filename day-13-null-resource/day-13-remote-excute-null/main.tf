provider "aws" {
  region = "us-east-2"
}

# 1. Security group for RDS (MySQL access)
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL from EC2"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # For learning/demo only — restrict in production
  }
}

# 2. Create Secrets Manager secret
resource "aws_secretsmanager_secret" "rds_secret" {
  name = "rds_secret"
}

# 3. Store username & password inside secret
resource "aws_secretsmanager_secret_version" "rds_secret_value" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id

  secret_string = jsonencode({
    username = "admin"
    password = "sahil1234"
  })
}

# 4. Create RDS Instance
resource "aws_db_instance" "mysql_rds" {
  identifier              = "my-rds"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  db_name                 = "dev"

  username = jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)["username"]
  password = jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)["password"]

  skip_final_snapshot     = true
  publicly_accessible     = true
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
}

# 5. Create EC2 instance to run SQL remotely
resource "aws_instance" "sql_runner" {
  ami                         = "ami-0cd582ee8a22cc7be" # Amazon Linux 2 for us-east-2
  instance_type               = "t2.micro"
  key_name                    = "us-east-2"             # Must match your AWS key pair
  associate_public_ip_address = true

  tags = {
    Name = "SQL Runner"
  }
}

# 6. Run SQL remotely via remote-exec
resource "null_resource" "remote_sql_exec" {
  depends_on = [
    aws_db_instance.mysql_rds,
    aws_instance.sql_runner
  ]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/JOHN/Downloads/us-east-2.pem")  # ✅ Your .pem file path
    host        = aws_instance.sql_runner.public_ip
  }

  provisioner "file" {
  source      = "../local-exec-resource/init.sql"
  destination = "/tmp/init.sql"
}
provisioner "remote-exec" {
  inline = [
    "echo '== STARTING =='",

    # Update and install mariadb (MySQL client)
    "sudo yum clean all",
    "sudo yum makecache",
    "sudo yum install -y mariadb",

    # Debug whether it worked
    "echo '== Checking mysql client ==' ",
    "which mysql || echo '❌ mysql not found'",
    "mysql --version || echo '❌ mysql not installed properly'",

    # Show SQL file
    "echo '== Checking init.sql file ==' ",
    "ls -l /tmp/init.sql || echo '❌ SQL file missing'",

    # Run SQL only if everything is fine
    "echo '== RUNNING SQL ==' ",
    "mysql -h ${aws_db_instance.mysql_rds.address} -u ${jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)["username"]} -p${jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)["password"]} < /tmp/init.sql || echo '❌ SQL execution failed'"
  ]
}


  triggers = {
    always_run = timestamp()
  }
}

  

  