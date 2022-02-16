resource "aws_vpc" "vpc-tf" {
  cidr_block = var.vpc_var_map["cidr_block"]
  tags = {
    Name = var.vpc_var_map["name"]
  }
}

resource "aws_subnet" "sbn-tf-public-2a" {
  vpc_id = "${aws_vpc.vpc-tf.id}"
  cidr_block = var.sbn_var_map["cidr_blocks"]["public-2a"]
  tags = {
    Name = var.sbn_var_map["names"]["public-2a"]
  }
}