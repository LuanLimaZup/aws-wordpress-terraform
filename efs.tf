resource "aws_security_group" "efs_sg" {
  name        = "wordpress-efs-sg"
  description = "Permite NFS das instancias WordPress"
  vpc_id      = aws_vpc.wordpress_vpc.id

  ingress {
    description     = "NFS from EC2"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.tags,
    {
      Name = "wordpress-efs-sg"
    }
  )
}

resource "aws_efs_file_system" "wordpress_efs" {
  creation_token = "wordpress-efs"

  tags = merge(
    local.tags,
    {
      Name = "wordpress-efs"
    }
  )
}

resource "aws_efs_mount_target" "efs_private_1a" {
  file_system_id  = aws_efs_file_system.wordpress_efs.id
  subnet_id       = aws_subnet.wordpress_subnet_private_1a.id
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_efs_mount_target" "efs_private_1b" {
  file_system_id  = aws_efs_file_system.wordpress_efs.id
  subnet_id       = aws_subnet.wordpress_subnet_private_1b.id
  security_groups = [aws_security_group.efs_sg.id]
}