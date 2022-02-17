variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "vpc_var_map" {
  type = map(string)
  default = {
    cidr_block = "10.0.0.0/26"
    name       = "vpc_tf"
  }
}

variable "sbn_var_map" {
  type = map(map(string))
  default = {
    cidr_blocks = {
      public-2a = "10.0.0.0/28"
      public-2c = "10.0.0.16/28"
      private-2a = "10.0.0.32/28"
      private-2c = "10.0.0.48/28"
    },
    az = {
      public-2a = "ap-northeast-2a"
      public-2c = "ap-northeast-2c"
      private-2a = "ap-northeast-2a"
      private-2c = "ap-northeast-2c"
    },
    names = {
      public-2a = "sbn-tf-public-2a"
      public-2c = "sbn-tf-public-2c"
      private-2a = "sbn-tf-private-2a"
      private-2c = "sbn-tf-private-2a"
    }
  }
}

variable "igw_name" {
  type = string
  default = "igw-tf"
}

variable "rt_public_name" {
  type = string
  default = "rt-tf-public"
}

variable "rt_private_name" {
  type = string
  default = "rt-tf-private"
}