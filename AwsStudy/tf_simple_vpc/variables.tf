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
    },
    names = {
      public-2a = "sbn-tf-public-2a"
      public-2c = "sbn-tf-public-2c"
    }
  }
}
