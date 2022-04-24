terraform {
    required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~> 3.27"
      }
    }
    required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_key_pair" "ec2-key" {
  key_name = "ec2-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIIThuzoWW8wjmKPGDIgXatnHtOCAUvH51J0R+4DNrrQRDKmlXOg+C2TMzG4dOZjS4MCyS7gdAjTJx+CK/tkSKBsh23iHFjzap491InZsS9X8XDtafAHpN97sY2uB8QwW7WcdBONqnYPlXlaB8UB2gH9dFVEQIpWhHOynJNe9PZtnnms0ePOzzEweHUZ2twC+03tSBPlB8PaGKRk0v6oB5HWlPjhY8Mbc/7pQXSYJHjlQb2eBIN6jaQaloT8PEp7YUNUrlij4cBbttz4pChgpyLRbLuLCRO1xTn838DUEqt5gtf4Hu2+D3vFiGyCFbQ2uYpiGveyI+51C6C20uhhZp1xLfPCA3Y3WZ+XpAV3rjMf+YNen9lc15Fuj/KsF4Dc6q0xh61KhyNyojMDfREO9PVdhDhdaQ5MVmrgJQnSn+8z64CBwJ+FYFUWFMsZCHTWwe2VbEYqKtIn55B2ZMBy4kwoQ9AJSTW8XLg9pmuB1IigXZaZFGKrI3Hmyb7KlCOC0="
  
  tags = {
    "Name" = "Conexão ssh"
  }
}

resource "aws_instance" "Ec2-Terraform" {
  ami = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  key_name = "ec2-key"
  tags = {
    Name = "Testando com /bin/bash"
  }
  security_groups = [ "${aws_security_group.Ec2-sg.name}" ]
}

resource "aws_security_group" "Ec2-sg" {
  ingress  {
    from_port =0
    to_port =0
    protocol ="-1"
    self = true
  } 

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
}