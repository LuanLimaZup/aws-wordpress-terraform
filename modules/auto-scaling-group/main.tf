resource "aws_autoscaling_group" "wordpress_auto_scaling_group" {
  name             = "wordpress-asg"
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  vpc_zone_identifier = var.private_subnet_ids

  health_check_grace_period = 300
  health_check_type         = "ELB"

  target_group_arns = [var.target_group_arn]

  dynamic "tag" {
    for_each = merge(
      var.tags,
      {
        Name = "wordpress-ec2"
      }
    )

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}