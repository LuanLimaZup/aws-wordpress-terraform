resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = merge(
    var.tags,
    {
      Name = var.vpc_name
    }
  )
}

resource "aws_subnet" "public_1a" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 1)
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "wordpress-subnet-public-1a"
    }
  )
}

resource "aws_subnet" "public_1b" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 2)
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "wordpress-subnet-public-1b"
    }
  )
}

resource "aws_subnet" "private_1a" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 3)
  availability_zone = "${var.region}a"

  tags = merge(
    var.tags,
    {
      Name = "wordpress-subnet-private-1a"
    }
  )
}

resource "aws_subnet" "private_1b" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 4)
  availability_zone = "${var.region}b"

  tags = merge(
    var.tags,
    {
      Name = "wordpress-subnet-private-1b"
    }
  )
}