resource "aws_db_subnet_group" "wordpress_rds_subnet_group" {
  name       = "wordpress_rds_subnet_group"
  subnet_ids = module.vpc.private_subnet_ids
  tags = merge(
    local.tags,
    {
      Name = "wordpress-subnet-group"
    }
  )
}