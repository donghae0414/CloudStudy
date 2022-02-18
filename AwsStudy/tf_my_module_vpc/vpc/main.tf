resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
      Name = var.vpc_name
  }
}