provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}

resource "aws_security_group" "webserver_sg" {
  name        = "webserver-sg"
  description = "Webserver Security Group"

  dynamic "ingress" {
    for_each = ["80", "443", "22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

#  Create Instance

resource "aws_instance" "webserver_instances" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]

  tags = {
    Name = "Webserver"
  }
}

resource "null_resource" "webserver" {
  provisioner "local-exec" {
    command = "echo Instace IP: ${aws_instance.webserver_instances.public_ip} > public_ip.txt"
  }

  depends_on = [aws_instance.webserver_instances]
}
