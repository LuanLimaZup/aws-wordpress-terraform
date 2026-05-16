resource "aws_lb" "wordpress_alb" {
  name               = "wordpress-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]

  subnets = [
    aws_subnet.wordpress_subnet_public_1a.id,
    aws_subnet.wordpress_subnet_public_1b.id
  ]

  tags = merge(
    local.tags,
    {
      Name = "wordpress-alb"
    }
  )
}

#=======================================================================

resource "aws_lb_target_group" "wordpress_target_group" {
  name     = "wordpress-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.wordpress_vpc.id

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
  }

  tags = merge(
    local.tags,
    {
      Name = "wordpress-alb-tg"
    }
  )
}

#==================================================================================

resource "aws_lb_listener" "wordpress_http_listener_http" {
  load_balancer_arn = aws_lb.wordpress_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress_target_group.arn
  }
}

resource "aws_lb_listener" "wordpress_listener_https" {
  load_balancer_arn = aws_lb.wordpress_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress_target_group.arn
  }
}


# ssl_policy e certificate_arn são usados apenas para listeners HTTPS na porta 443.