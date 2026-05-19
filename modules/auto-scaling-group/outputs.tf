output "autoscaling_group_name" {
  description = "Auto Scaling Group name"
  value       = aws_autoscaling_group.wordpress_auto_scaling_group.name
}

output "autoscaling_group_arn" {
  description = "Auto Scaling Group ARN"
  value       = aws_autoscaling_group.wordpress_auto_scaling_group.arn
}