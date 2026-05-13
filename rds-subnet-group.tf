resource "aws_db_subnet_group" "wordpress_rds_subnet_group" {
  name       = "wordpress_rds_subnet_group"
  subnet_ids = [aws_subnet.wordpress_subnet_private_1a.id, aws_subnet.wordpress_subnet_private_1b.id]

  tags = merge(
    local.tags,
    {
      Name = "wordpress-subnet-group"
    }
  )
}