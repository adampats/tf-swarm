variable "key" {
  default = "adamkeys"
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
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "allow_ssh"
  }
}

#resource "aws_instance" "chef_server" {
resource "aws_spot_instance_request" "chef_server" {
  spot_price = "0.03"
  instance_type = "m4.large"

  ami = "ami-f7a2bf96"
  tags {
    Name = "App"
  }
  key_name = "${var.key}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  user_data = "${file("./chef-server.sh")}"
}

/*#resource "aws_instance" "nodes" {
resource "aws_spot_instance_request" "nodes" {
  spot_price = "0.03"
  instance_type = "m4.large"

  count = 2
  ami = "ami-f7a2bf96"
  tags {
    Name = "App"
  }
  key_name = "${var.key}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  user_data = "${file("./swarm-node.sh")}"
}*/
