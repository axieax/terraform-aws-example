# Configure VPC
resource "aws_vpc" "lab_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "lab_vpc"
  }
}

# Configure subnets and route table associations
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.lab_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = var.AWS_AZ_1
  tags = {
    Name = "public_subnet_1"
  }
}
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.lab_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.AWS_AZ_1
  tags = {
    Name = "private_subnet_1"
  }
}
resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.lab_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.AWS_AZ_2
  tags = {
    Name = "public_subnet_2"
  }
}
resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.lab_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.AWS_AZ_2
  tags = {
    Name = "private_subnet_2"
  }
}
resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}
