resource "aws_eip" "eip-nat" {
    vpc = true
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

    name = "vpc-name"
    cidr = "10.0.0.0/26"

    azs = ["ap-northeast-2a", "ap-northeast-2c"]
    private_subnets = ["10.0.0.32/28", "10.0.0.48/28"]
    public_subnets = ["10.0.0.0/28", "10.0.0.16/28"]

    create_igw = true

    enable_nat_gateway = true
    single_nat_gateway = true
    one_nat_gateway_per_az = false
    external_nat_ip_ids = [aws_eip.eip-nat.id]
}

