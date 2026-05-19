output "efs_id" {
  description = "EFS file system ID"
  value       = aws_efs_file_system.wordpress_efs.id
}