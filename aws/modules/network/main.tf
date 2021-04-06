
# Create vpc
resource "aws_vpc" "bluecloud_vpc" {
  cidr_block           = var.vpc_cidr 
  enable_dns_hostnames = false
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "bluecloud_vpc"
  }
}

data "aws_availability_zones" "available" {}

# Create subnet1
resource "aws_subnet" "user-subnet" {
  vpc_id                  = aws_vpc.bluecloud_vpc.id
  cidr_block              = "10.100.30.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "bluecloud_user-subnet"
  }
}

# Create subnet2
resource "aws_subnet" "server-subnet" {
  vpc_id                  = aws_vpc.bluecloud_vpc.id
  cidr_block              = "10.100.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "bluecloud_server-subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "bluecloud-igw" {
  vpc_id = aws_vpc.bluecloud_vpc.id

  tags = {
    Name = "bluecloud_Internet_Gateway"
  }
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.bluecloud_vpc.id
  route_table_id = aws_route_table.bluecloud-rt.id
}

# Route Table
resource "aws_route_table" "bluecloud-rt" {
  vpc_id = aws_vpc.bluecloud_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bluecloud-igw.id
  }

  tags = { 
    Name = "bluecloud_Routing_Table"
  }
}
