# TODO: src code for sample web app (with RDS)

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = "0.14.11"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  # ALT: set AWS_PROFILE to the name of the profile from ~/.aws/credentials
  # profile = "burner"
  region = var.AWS_REGION
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/instance
resource "aws_instance" "bot" {
  # EC2 configuration
  # NOTE: ami region specific
  ami                         = "ami-0bd2230cfb28832f7"
  instance_type               = "t2.micro"
  associate_public_ip_address = true

  # setup permissions
  subnet_id = aws_subnet.public_subnet_1.id
  # security groups
  security_groups = [
    aws_security_group.ec2_web_security.id,
    # aws_security_group.ec2_ssh_security.id
  ]

  tags = {
    Name = "bot"
  }
}

# elastic IP: allows one to mask the failure of an instance by rapidly remapping the address to another instance
resource "aws_eip" "elastic_ip" {
  # PROBLEM: https://github.com/hashicorp/terraform-provider-aws/issues/709#issuecomment-447043516
  # instance = aws_instance.bot.id
  vpc = true
}
