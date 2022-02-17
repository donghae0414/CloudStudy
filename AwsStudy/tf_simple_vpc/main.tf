resource "aws_vpc" "vpc-tf" {
  cidr_block = var.vpc_var_map["cidr_block"]
  tags = {
    Name = var.vpc_var_map["name"]
  }
}


###
### public subnet
###
resource "aws_subnet" "sbn-tf-public-2a" {
  vpc_id     = aws_vpc.vpc-tf.id
  cidr_block = var.sbn_var_map["cidr_blocks"]["public-2a"]
  availability_zone = var.sbn_var_map["az"]["public-2a"]
  tags = {
    Name = var.sbn_var_map["names"]["public-2a"]
  }
}

resource "aws_default_route_table" "rt-public" {
  default_route_table_id = aws_vpc.vpc-tf.default_route_table_id
  tags = {
    Name = var.rt_public_name
  }
}

resource "aws_route_table_association" "rtas-tf-public-2a" {
  subnet_id = aws_subnet.sbn-tf-public-2a.id
  route_table_id = aws_default_route_table.rt-public.id
}

resource "aws_internet_gateway" "igw-tf" {
  vpc_id = aws_vpc.vpc-tf.id
  tags = {
    Name = var.igw_name
  }
}

resource "aws_route" "route-public" {
  route_table_id = aws_default_route_table.rt-public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw-tf.id
}


###
### private subnet
###
resource "aws_subnet" "sbn-tf-private-2a" {
  vpc_id     = aws_vpc.vpc-tf.id
  cidr_block = var.sbn_var_map["cidr_blocks"]["private-2a"]
  tags = {
    Name = var.sbn_var_map["names"]["private-2a"]
  }
}

resource "aws_route_table" "rt-tf-private" {
  vpc_id = aws_vpc.vpc-tf.id
  tags = {
    Name = var.rt_private_name
  }
}

resource "aws_route_table_association" "rtas-tf-private-2a" {
  subnet_id = aws_subnet.sbn-tf-private-2a.id
  route_table_id = aws_route_table.rt-tf-private.id
}

resource "aws_eip" "eip-nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-tf" {
  allocation_id = aws_eip.eip-nat.id
  subnet_id = aws_subnet.sbn-tf-private-2a.id
}

resource "aws_route" "route-private" {
  route_table_id = aws_route_table.rt-tf-private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.nat-tf.id
}
