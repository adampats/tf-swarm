variable "key" {
  default = "adamthepatterson_rsa"
}

provider "aws" {
    region = "us-west-2"
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  description = "Allow SSH inbound traffic"
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "allow_ssh"
  }
}

resource "aws_instance" "example" {
    ami = "ami-5189a661"
    instance_type = "t2.micro"
    tags {
      Name = "App"
    }
    key_name = "${var.key}"
    security_groups = ["allow_ssh"]
    user_data = "!#/bin/bash ; touch /tmp/foo"
}
