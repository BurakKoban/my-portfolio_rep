# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# unzip awscliv2.zip
# sudo ./aws/install

aws ec2 create-security-group --group-name Roman_numbers_SG \
      --description "This Sec Group is to allow ssh and http from anywhere"

aws ec2 describe-security-groups --group-names Roman_numbers_SG # to see the SG

aws ec2 authorize-security-group-ingress \
    --group-name Roman_numbers_SG \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
    --group-name Roman_numbers_SG \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0

LATEST_AMI=$(aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --region us-east-1 \
    --query "Parameters[0].[Value]" \
    --output text)

echo   "#!/bin/bash \
        yum update -y \
        yum install python3 -y \
        pip3 install flask \
        cd /home/ec2-user \
        FOLDER="https://raw.githubusercontent.com/BurakKoban/my-portfolio_rep/main/Project-001-Roman-Numerals-Converter" \
        wget $FOLDER/app.py \
        mkdir templates && cd templates \
        wget $FOLDER/templates/index.html \
        wget $FOLDER/templates/result.html \
        cd .. \
        python3 app.py" >  userdata.sh
           

aws ec2 run-instances \
    --image-id ${LATEST_AMI} \
    --instance-type t2.micro \
    --key-name burakawskey \
    --security-groups Roman_numbers_SG \
    --user-data file:///home/ec2-user/userdata.sh \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=roman_numbers}]'

aws ec2 describe-instances --query 'Reservations[0].Instances[].InstanceId' # to get the instance Id

aws ec2 describe-instances --query 'Reservations[2].Instances[].PublicIpAddress' # to get the instance public IP

# aws ec2 describe-instances --filters "Name=tag:Name,Values=roman_numbers" --query 'Reservations[].Instances[].InstanceId[]' --output text



