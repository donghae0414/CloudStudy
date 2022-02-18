## Terraform for Simple VPC

![image](https://user-images.githubusercontent.com/48152411/154681885-c4969d54-c593-436c-a2e5-85db9e89aeba.png)

### 생성 Resource 목록
1. VPC
2. Subnets (2 public subnets, 2 private subnets)
3. Internet Gateway
4. Nat Gateway, eip
5. Routing tables

### 실행방법
1. secret.auto.tfvars 생성 후 아래 변수 입력 후 저장  
```
    access_key = "your AWS access key"
    secret_key = "your AWS secret key"
``` 
2. terraform validate 로 유효성 확인
3. terraform plan 으로 생성 리소스 확인
4. terraform apply 으로 생성
