resource "aws_vpc" "three_tier" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "three-tier-vpc"
  }
}

# -------------------------
# Internet Gateway
# -------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.three_tier.id

  tags = {
    Name = "three-tier-igw"
  }
}

# -------------------------
# Public Subnets
# -------------------------
resource "aws_subnet" "public" {
  for_each = toset(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.three_tier.id
  cidr_block              = each.value
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, index(var.public_subnet_cidrs, each.value))

  tags = {
    Name = "public-${each.value}"
  }
}

# -------------------------
# Private Subnets
# -------------------------
resource "aws_subnet" "private" {
  for_each = toset(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.three_tier.id
  cidr_block        = each.value
  availability_zone = element(data.aws_availability_zones.available.names, index(var.private_subnet_cidrs, each.value))

  tags = {
    Name = "private-${each.value}"
  }
}

# -------------------------
# Elastic IP for NAT
# -------------------------
resource "aws_eip" "nat" {
  domain = "vpc"
}

# -------------------------
# NAT Gateway (in public subnet)
# -------------------------
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.public)[0].id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "three-tier-nat"
  }
}

# -------------------------
# Public Route Table
# -------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.three_tier.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# -------------------------
# Private Route Table (via NAT)
# -------------------------
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.three_tier.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

# -------------------------
# AZ Data Source
# -------------------------
data "aws_availability_zones" "available" {}