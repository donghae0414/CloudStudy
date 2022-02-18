resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

###
### public subnet
###
resource "aws_subnet" "sbn-public" {
  vpc_id = aws_vpc.vpc.id

  count = length(var.public_subnet_cidrs)

  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.public_subnet_azs[count.index]
  tags = {
    Name = element(var.public_subnet_names, count.index)
  }
}

resource "aws_internet_gateway" "igw" {
  count = var.create_igw ? 1 : 0

  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.igw_name
  }
}

resource "aws_default_route_table" "rt-public" {
  count                  = var.create_igw && length(var.public_subnet_cidrs) > 0 ? 1 : 0
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }

  tags = {
    Name = var.rt_public_name
  }
}

###
### private subnet
###
resource "aws_subnet" "sbn-private" {
  count = length(var.private_subnet_cidrs)

vpc_id = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.private_subnet_azs[count.index]
  tags = {
    Name = var.private_subnet_names[count.index]
  }
}

locals { # az당 생성 true 면 az 수, false면 1
  nat_gateway_count = var.one_external_nat_per_az ? length(distinct(var.private_subnet_azs)) : 1
}

resource "aws_eip" "eip-nat" {
  count = var.create_external_nat == false ? 0 : local.nat_gateway_count
  vpc   = true
}

resource "aws_nat_gateway" "nat" {
  count = var.create_external_nat == false ? 0 : local.nat_gateway_count

  allocation_id = element(aws_eip.eip-nat[*].id, count.index)
  subnet_id     = element(aws_subnet.sbn-private[*].id, count.index)
}

resource "aws_route_table" "rt-private" {
  count = var.create_external_nat == false ? 0 : local.nat_gateway_count

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = element(aws_nat_gateway.nat[*].id, count.index)
  }

  tags = {
    Name = "${var.rt_private_name}-${count.index}"
  }
}

resource "aws_route_table_association" "private" {
    count = length(var.private_subnet_cidrs) > local.nat_gateway_count ? length(var.private_subnet_cidrs) : local.nat_gateway_count

    subnet_id = element(aws_subnet.sbn-private[*].id, count.index)
    route_table_id = element(aws_route_table.rt-private[*].id, var.one_external_nat_per_az ? count.index : 0)
}