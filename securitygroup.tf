resource "aws_security_group" "alb_sg" {
  name        = "applicationLoadBalanceSG"
  description = "Security group for Application Load Balancer"
  vpc_id      = aws_vpc.wordpress_vpc.id

  tags = merge(
    local.tags,
    {
      Name = "wordpress-alb-sg"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "alb_http_ipv4" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "alb_https_ipv4" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "alb_all_outbound_ipv4" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

#======================================================================================

resource "aws_security_group" "ec2_sg" {
  name        = "wordpressEC2-SG"
  description = "Security group for WordPress EC2 instances"
  vpc_id      = aws_vpc.wordpress_vpc.id

  tags = merge(
    local.tags,
    {
      Name = "wordpress-ec2-sg"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "ec2_http_ipv4_from_alb" {
  security_group_id            = aws_security_group.ec2_sg.id
  referenced_security_group_id = aws_security_group.alb_sg.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}


resource "aws_vpc_security_group_egress_rule" "ec2_all_outbound_ipv4" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

#================================================================================

resource "aws_security_group" "rds_sg" {
  name        = "wordpressRDS-SG"
  description = "Security group for WordPress RDS"
  vpc_id      = aws_vpc.wordpress_vpc.id

  tags = merge(
    local.tags,
    {
      Name = "wordpress-rds-sg"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "rds_mysql_from_ec2" {
  security_group_id            = aws_security_group.rds_sg.id
  referenced_security_group_id = aws_security_group.ec2_sg.id
  from_port                    = 3306
  ip_protocol                  = "tcp"
  to_port                      = 3306
}


resource "aws_vpc_security_group_egress_rule" "rds_all_outbound_ipv4" {
  security_group_id = aws_security_group.rds_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}