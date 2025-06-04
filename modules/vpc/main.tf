resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    project = "two-tier-project"
  }
}

resource "aws_subnet" "pub_subnet_1" {
  cidr_block = "10.0.0.0/18"
  vpc_id = aws_vpc.vpc.id
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = true
  tags = {
    project = "two-tier-project"
  }
}

resource "aws_subnet" "pub_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.64.0/18"
    availability_zone = "ap-northeast-1c"
  map_public_ip_on_launch = true
  tags = {
    project = "two-tier-project"
  }
}

resource "aws_subnet" "pvt_subnet_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.128.0/18"
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = false
  tags = {
    project = "two-tier-project"
  }
}

resource "aws_subnet" "pvt_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.192.0/18"
  availability_zone = "ap-northeast-1c"
  map_public_ip_on_launch = false
  tags = {
    project = "two-tier-project"
  }
}

resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    project = "two-tier-project"
  }
}

resource "aws_route_table" "route_tbl" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-igw.id
  }
  tags = {
    project = "two-tier-project"
  }
}

resource "aws_route_table_association" "route_tbl_assoc_1" {
  subnet_id = aws_subnet.pub_subnet_1.id
  route_table_id = aws_route_table.route_tbl.id
}

resource "aws_route_table_association" "route_tbl_assoc_2" {
  subnet_id = aws_subnet.pub_subnet_2.id
  route_table_id = aws_route_table.route_tbl.id
}

