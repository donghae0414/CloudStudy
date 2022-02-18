module "my_module_vpc" {
    source = "./vpc"

    vpc_cidr_block = "10.0.0.0/26"
    vpc_name = "VPC-MyModule"

    public_subnet_cidrs = ["10.0.0.0/28", "10.0.0.16/28"]
    public_subnet_azs = ["ap-northeast-2a", "ap-northeast-2c"]
    public_subnet_names = ["sbn-MyModule-public-2a", "sbn-MyModule-public-2c"]

    create_igw = true

    private_subnet_cidrs = ["10.0.0.32/28", "10.0.0.48/28"]
    private_subnet_azs = ["ap-northeast-2a", "ap-northeast-2c"]
    private_subnet_names = ["sbn-MyModule-private-2a", "sbn-MyModule-private-2c"]

    create_external_nat = true
    one_external_nat_per_az = true
}