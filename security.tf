# TODO: network ACL


# security group
resource "aws_security_group" "ec2_web_security" {
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

resource "aws_security_group" "ec2_ssh_security" {
  name        = "SSH Security Group"
  description = "Enable SSH access"
  vpc_id      = aws_vpc.lab_vpc.id

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
