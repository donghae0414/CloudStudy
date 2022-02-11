## Cloudformation for Lambda (backup ec2 when it stopped or terminated)
![image](https://user-images.githubusercontent.com/48152411/153643710-15e5ab41-c50f-4d64-a257-9174b19b0265.png)

### 생성 Resource 목록
1. Lambda에 부여하는 Role (LambdaExecutionRole)
2. Lambda Function (LambdaFunction)
3. EventBridge Rule (Ec2StopEvent)

### 시나리오
1. EC2 stopped, terminated 이벤트 발생
2. Trigger로 Lambda Function 실행
3. AMI 생성

### 실행방법
1. Lambda function에 쓰일 lambda_ec2BackupByEvent.py를 zip으로 압축
2. S3를 생성하고 zip 파일 업로드
3. 템플릿(yaml) 파일 내 Parameters에서 S3 관련 정보 변경
4. 템플릿 파일로 CloudFormation Stack 생성
5. EventBridge Rule(규칙)에서 생성된 규칙 수정 -> 아무것도 수정하지 않고 업데이트\
   (Rule생성 및 Lambda 대상 등록이 정상적으로 이루어지지만, Lambda Trigger에는 Rule이 적용되지 않는 부분을 해결하지 못하였음)
6. EC2 stop, terminate로 실험
