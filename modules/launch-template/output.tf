output "launch_template_id" {
  description = "Launch template ID"
  value       = aws_launch_template.wordpress_launch_template.id
}

output "launch_template_latest_version" {
  description = "Latest launch template version"
  value       = aws_launch_template.wordpress_launch_template.latest_version
}