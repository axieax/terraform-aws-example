# network ACL


# security group
resource "aws_security_group" "ec2_security_group" {
  name        = "Web Security Group"
  description = "Enable HTTP access"
  vpc_id      = aws_vpc.lab_vpc.id

  # add inbound rule
  ingress {
    description      = "Allow web requests"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
