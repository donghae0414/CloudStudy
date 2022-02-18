module "my_module_vpc" {
    source = "./vpc"

    vpc_cidr_block = "10.0.0.0/26"
    vpc_name = "VPC-MyModule"
}