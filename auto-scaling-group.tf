resource "aws_autoscaling_group" "wordpress_auto_scaling_group" {
  name             = "wordpress_asg"
  desired_capacity = 1
  max_size         = 2
  min_size         = 1

  launch_template {
    id      = aws_launch_template.wordpress_launch_template.id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    aws_subnet.wordpress_subnet_private_1a.id, aws_subnet.wordpress_subnet_private_1b.id
  ]

  health_check_grace_period = 300
  health_check_type         = "ELB"

  target_group_arns = [aws_lb_target_group.wordpress_target_group.arn]

  tag {
    key                 = "Name"
    value               = "wordpress-ec2"
    propagate_at_launch = true
  }

  tag {
    key                 = "Department"
    value               = "DevOps"
    propagate_at_launch = true
  }

  tag {
    key                 = "Organization"
    value               = "Infrastructure and Operations"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "Wordpress"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "Development"
    propagate_at_launch = true
  }
}