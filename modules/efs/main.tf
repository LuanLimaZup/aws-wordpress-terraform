resource "aws_efs_file_system" "wordpress_efs" {
  creation_token = "wordpress-efs"

  tags = merge(
    var.tags,
    {
      Name = "wordpress-efs"
    }
  )
}

resource "aws_efs_mount_target" "efs_mount_targets" {
  count = length(var.private_subnet_ids)

  file_system_id  = aws_efs_file_system.wordpress_efs.id
  subnet_id       = var.private_subnet_ids[count.index]
  security_groups = [var.efs_security_group_id]
}