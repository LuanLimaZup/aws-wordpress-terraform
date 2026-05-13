resource "aws_internet_gateway" "wordpress_gw" {
  vpc_id = aws_vpc.wordpress_vpc.id

  tags = merge(
    local.tags,
    {
      Name = "project-wordpress-igw"
    }
  )
}

resource "aws_route_table" "wordpress_public_route_table" {
  vpc_id = aws_vpc.wordpress_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wordpress_gw.id
  }

  tags = merge(
    local.tags,
    {
      Name = "project-wordpress-public-route-table"
    }
  )
}


resource "aws_route_table" "wordpress_private_route_table" {
  vpc_id = aws_vpc.wordpress_vpc.id

  tags = merge(
    local.tags,
    {
      Name = "project-wordpress-private-route-table"
    }
  )
}
