## Terraform for Simple VPC

### 생성 Resource 목록
1. VPC
2. Subnets (2 public subnets, 2 private subnets)
3. Internet Gateway
4. Nat Gateway, eip

### 실행방법
1. secret.auto.tfvars 생성
2. terraform validate 로 유효성 확인
3. terraform plan 으로 생성 리소스 확인
4. terraform apply 으로 생성
