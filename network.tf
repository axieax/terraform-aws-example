# Attach internet gateway to VPC
resource "aws_internet_gateway" "lab_igw" {
  vpc_id = aws_vpc.lab_vpc.id
  tags = {
    Name = "lab_igw"
  }
}

# setup NAT gateway for traffic from private to public subnet (which will then be forwarded to the internet)
resource "aws_nat_gateway" "lab_natgw_primary" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    Name = "lab_natgw_primary"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency on the Internet Gateway for the VPC
  depends_on = [aws_eip.elastic_ip, aws_internet_gateway.lab_igw]
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.lab_vpc.id
  tags = {
    Name = "public_route_table"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab_igw.id
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.lab_vpc.id
  tags = {
    Name = "private_route_table"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.lab_natgw_primary.id
  }
}
