terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.11.0"
    }

    github = {
      source  = "integrations/github"
      version = "4.23"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "github" {
  token = "xxxxxxxxxxxxxxxxx"

}

resource "github_repository" "myrepo" {
  name       = "docker-bookstore-repo"
  auto_init  = true
  visibility = "private"


}

variable "files" {
  default = ["bookstore-api.py", "docker-compose.yaml", "Dockerfile", "requirements.txt"]

}

resource "github_repository_file" "phonebook_app_files" {
  for_each            = toset(var.files)
  repository          = github_repository.myrepo.name
  file                = each.value
  content             = file(each.value)
  branch              = "main"
  commit_message      = "phonebook app files"
  overwrite_on_create = true
}

resource "aws_security_group" "tf-docker-sec-group-203" {
  name = "tf-docker-sec-group-203"
  tags = {
    Name = "tf-docker-sec-group-203"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}

resource "aws_instance" "tf-docker-ec2" {
  ami             = "ami-0f9fc25dd2506cf6d"
  instance_type   = "t2.micro"
  key_name        = "burakawskey"
  security_groups = ["tf-docker-sec-group-203"]
  tags = {
    "Name" = "web server of phonebook"
  }

  user_data  = <<-EOF
            #!/bin/bash
            yum update -y
            amazon-linux-extras install docker -y
            systemctl start docker
            systemctl enable docker
            usermod -a -G docker ec2-user
            curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" \
            -o /usr/local/bin/docker-compose
            chmod +x /usr/local/bin/docker-compose
            mkdir -p /home/ec2-user/bookstore-api/
            TOKEN="xxxxxxxxxxxxxxxxxxxxxxxxx"
            FOLDER="https://$TOKEN@raw.githubusercontent.com/burakkoban/docker-bookstore-repo/main/"
            curl -s --create-dirs -o "/home/ec2-user/bookstore-api/bookstore-api.py" -L "$FOLDER"bookstore-api.py
            curl -s --create-dirs -o "/home/ec2-user/bookstore-api/requirements.txt" -L "$FOLDER"requirements.txt
            curl -s --create-dirs -o "/home/ec2-user/bookstore-api/Dockerfile" -L "$FOLDER"Dockerfile
            curl -s --create-dirs -o "/home/ec2-user/bookstore-api/docker-compose.yml" -L "$FOLDER"docker-compose.yaml
            cd /home/ec2-user/bookstore-api
            docker build -t burakkoban/bookstoreapi:latest .
            docker-compose up -d
            EOF
  depends_on = [github_repository.myrepo, github_repository_file.phonebook_app_files]

}

output "website" {

  value = "http://${aws_instance.tf-docker-ec2.public_dns}"

}

