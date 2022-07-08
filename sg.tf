################
#
# VPC SG
#
################

resource "aws_vpc" "sg" {
  provider = aws.sg

  cidr_block       = local.sg_vpc_cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "SG-VPC"
    Project = local.projecttag
  }
}

resource "aws_subnet" "private_1a_sg" {
  provider = aws.sg

  vpc_id     = aws_vpc.sg.id
  cidr_block = local.sg_private_subnet_cidr_1a
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Private Subnet 1a"
    Project = local.projecttag
  }
}

resource "aws_subnet" "private_1b_sg" {
  provider = aws.sg

  vpc_id     = aws_vpc.sg.id
  cidr_block = local.sg_private_subnet_cidr_1b
  availability_zone = "ap-southeast-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Private Subnet 1b"
    Project = local.projecttag
  }
}

resource "aws_subnet" "private_1c_sg" {
  provider = aws.sg

  vpc_id     = aws_vpc.sg.id
  cidr_block = local.sg_private_subnet_cidr_1c
  availability_zone = "ap-southeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "Private Subnet 1c"
    Project = local.projecttag
  }
}

resource "aws_subnet" "public_1a_sg" {
  provider = aws.sg

  vpc_id     = aws_vpc.sg.id
  cidr_block = local.sg_public_subnet_cidr_1a
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 1a"
    Project = local.projecttag
  }
}

resource "aws_subnet" "public_1b_sg" {
  provider = aws.sg

  vpc_id     = aws_vpc.sg.id
  cidr_block = local.sg_public_subnet_cidr_1b
  availability_zone = "ap-southeast-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 1b"
    Project = local.projecttag
  }
}

resource "aws_subnet" "public_1c_sg" {
  provider = aws.sg

  vpc_id     = aws_vpc.sg.id
  cidr_block = local.sg_public_subnet_cidr_1c
  availability_zone = "ap-southeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 1c"
    Project = local.projecttag
  }
}

# Private Route Table SG

resource "aws_route_table" "private_subnet_sg" {
  provider = aws.sg

  vpc_id = aws_vpc.sg.id

  tags = {
    Name = "Private RT"
    Project = local.projecttag
  }
}

# Public Route Table SG

resource "aws_route_table" "public_subnet_sg" {
  provider = aws.sg

  vpc_id = aws_vpc.sg.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_sg.id
  }

  tags = {
    Name = "Public RT"
    Project = local.projecttag
  }
}

# Route Table Association

resource "aws_route_table_association" "private_routetable_sg_a" {
  provider = aws.sg

  route_table_id = aws_route_table.private_subnet_sg.id
  subnet_id = aws_subnet.private_1a_sg.id
}

resource "aws_route_table_association" "private_routetable_sg_b" {
  provider = aws.sg

  route_table_id = aws_route_table.private_subnet_sg.id
  subnet_id = aws_subnet.private_1b_sg.id
}

resource "aws_route_table_association" "private_routetable_sg_c" {
  provider = aws.sg

  route_table_id = aws_route_table.private_subnet_sg.id
  subnet_id = aws_subnet.private_1c_sg.id
}

resource "aws_route_table_association" "public_routetable_sg_a" {
  provider = aws.sg

  route_table_id = aws_route_table.public_subnet_sg.id
  subnet_id = aws_subnet.public_1a_sg.id
}

resource "aws_route_table_association" "public_routetable_sg_b" {
  provider = aws.sg

  route_table_id = aws_route_table.public_subnet_sg.id
  subnet_id = aws_subnet.public_1b_sg.id
}

resource "aws_route_table_association" "public_routetable_sg_c" {
  provider = aws.sg

  route_table_id = aws_route_table.public_subnet_sg.id
  subnet_id = aws_subnet.public_1c_sg.id
}

# EIP Nat Gateway SG

resource "aws_eip" "eip_ngw_sg" {
  provider = aws.sg

  vpc      = true

  tags = {
    Name = "SG NAT Gateway EIP"
    Project = local.projecttag
  }
}

# Nat Gateway SG

resource "aws_nat_gateway" "natgw_sg" {
  provider = aws.sg

  allocation_id = aws_eip.eip_ngw_sg.id
  subnet_id     = aws_subnet.public_1a_sg.id

  tags = {
    Name = "SG NAT Gateway"
    Project = local.projecttag
  }
}

# Internet Gateway - SG

resource "aws_internet_gateway" "igw_sg" {
  provider = aws.sg

  vpc_id = aws_vpc.sg.id

  tags = {
    Name = "SG Internet Gateway"
    Project = local.projecttag
  }
}