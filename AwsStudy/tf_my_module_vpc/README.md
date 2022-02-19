## Terraform for simple custom vpc module



### 실행방법
module = ./vpc
1. secret.auto.tfvars 생성 후 아래 변수 입력 후 저장  
```
    access_key = "your AWS access key"
    secret_key = "your AWS secret key"
``` 
2. main.tf 작성 example
```
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
```
3. 작동방식  
| 변수 | 설명 |  
| :------------- | :------------- |  
| subnet_cidrs, subnet_azs, subnet_names | 는 각각 list index에 따라 일대일 대응된다. |  
| create_external_nat(bool) | private subnet에 외부 nat를 연결시킬 지 |  
| one_external_nat_per_az(bool) | AZ별로 nat를 생성할 것인지 |  

4. 한계점  
subnet의 갯수가 distinct(가용영역) 보다 많으며, 가용영역이 마구잡이로 섞여서 입력된다면 가용영역에 맞는 nat가 연결될 수 없다😅  
처음부터 모든 경우를 포괄하고자 만든 것이 아니었기 때문에 모든 경우를 해결할 수는 없었다.
