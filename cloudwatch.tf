resource "aws_cloudwatch_metric_alarm" "high_cpu_asg" {
  alarm_name          = "wordpress-high-cpu-asg"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Alarme quando a CPU média do Auto Scaling Group passar de 70%"
  treat_missing_data  = "notBreaching"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.wordpress_auto_scaling_group.name
  }

  tags = merge(
    local.tags,
    {
      Name = "wordpress-high-cpu-auto-scaling-group"
    }
  )
}


resource "aws_cloudwatch_metric_alarm" "low_cpu_asg" {
  alarm_name          = "wordpress-low-cpu-asg"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 20
  alarm_description   = "Alarme quando a CPU média do Auto Scaling Group for inferior a 20%"
  treat_missing_data  = "notBreaching"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.wordpress_auto_scaling_group.name
  }

  tags = merge(
    local.tags, {
      Name = "wordpress-low-cpu-auto-scaling-group"
    }
  )


}