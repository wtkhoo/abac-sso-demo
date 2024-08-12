# VPC
resource "aws_vpc" "demo" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-vpc"
  }
}

# Private subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.demo.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 1)
  availability_zone = element(data.aws_availability_zones.az.names, 0)

  tags = {
    Name = "${var.name}-private-subnet"
  }
}

# Route table and association
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = "${var.name}-private-rt"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

