resource "aws_eip" "elastic_ip_nat" {
  domain = "vpc"

  tags = {
    Name = "wordpress-nat-eip"
  }
}

#-----------------------------------------------------------------------------------------------

resource "aws_nat_gateway" "nat_gateway_main" {
  allocation_id = aws_eip.elastic_ip_nat.id
  subnet_id     = aws_subnet.wordpress_subnet_public_1a.id

  tags = merge(
    local.tags, {
      Name = "wordpress-natgw"
    }
  )

  depends_on = [aws_internet_gateway.wordpress_gw]
}