variable "vpc_cidr_block" {
  type = string
}

variable "vpc_name" {
  type    = string
  default = "my_vpc"
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "public_subnet_azs" {
  type = list(string)
}

variable "public_subnet_names" {
  type = list(string)
}

variable "igw_name" {
  type    = string
  default = "my_igw"
}

variable "create_igw" {
  type    = bool
  default = true
}

variable "rt_public_name" {
  type    = string
  default = "rt_my_public"
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_azs" {
  type = list(string)
}

variable "private_subnet_names" {
  type = list(string)
}

variable "create_external_nat" {
    type = bool
    default = true
}

variable "one_external_nat_per_az" {
    type = bool
    default = true
}

variable "rt_private_name" {
    type = string
    default = "rt-private"
}