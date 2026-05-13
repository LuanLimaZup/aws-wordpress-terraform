resource "aws_subnet" "wordpress_subnet_public_1a" {
  vpc_id                  = aws_vpc.wordpress_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 1)
  availability_zone       = "${data.aws_region.current.region}a"
  map_public_ip_on_launch = true

  tags = merge(
    local.tags,
    {
      Name = "wordpress-subnet-public-1a"
    }
  )
}

resource "aws_subnet" "wordpress_subnet_public_1b" {
  vpc_id                  = aws_vpc.wordpress_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 2)
  availability_zone       = "${data.aws_region.current.region}b"
  map_public_ip_on_launch = true

  tags = merge(
    local.tags,
    {
      Name = "wordpress-subnet-public-1b"
    }
  )
}