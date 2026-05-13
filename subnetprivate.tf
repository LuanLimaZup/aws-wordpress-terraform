resource "aws_subnet" "wordpress_subnet_private_1a" {
  vpc_id            = aws_vpc.wordpress_vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 3)
  availability_zone = "${data.aws_region.current.region}a"

  tags = merge(
    local.tags,
    {
      Name = "wordpress-subnet-private-1a"
    }
  )
}

resource "aws_subnet" "wordpress_subnet_private_1b" {
  vpc_id            = aws_vpc.wordpress_vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 4)
  availability_zone = "${data.aws_region.current.region}b"

  tags = merge(
    local.tags,
    {
      Name = "wordpress-subnet-private-1b"
    }
  )
}