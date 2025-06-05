#Manually destroy the DB instance using:  terraform destroy -target=module.database.aws_db_instance.db1
# Creates a DB subnet group using two private subnets.
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [ var.pvt_subnet_1_id , var.pvt_subnet_2_id ]
}

resource "aws_db_instance" "db1" {
  allocated_storage           = 5
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = "db.t3.micro"
  db_subnet_group_name        = aws_db_subnet_group.db_subnet_group.id
  vpc_security_group_ids      = [aws_security_group.db_sg.id]
  parameter_group_name        = "default.mysql5.7"
  db_name                     = "db1"
  username                    = var.user
  password                    = var.password
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  backup_retention_period     = 35
  backup_window               = "22:00-23:00"
  maintenance_window          = "Sat:00:00-Sat:03:00"
  multi_az                    = false
  skip_final_snapshot         = true

}



resource "aws_security_group" "db_sg" {
    name ="db_sg"
    vpc_id = var.vpc_id

  ingress {
    description = "mysql"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    project = "Security group for database"
  }

}
