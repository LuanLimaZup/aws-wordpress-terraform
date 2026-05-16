resource "aws_db_instance" "wordpress_rds" {
  allocated_storage    = 20
  db_name              = "wordpress"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true #configuração somente para estudo
  multi_az             = false

  db_subnet_group_name = aws_db_subnet_group.wordpress_rds_subnet_group.name

  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible = false

  tags = merge(
    local.tags,
    {
      Name = "wordpress-rds"
    }
  )
}