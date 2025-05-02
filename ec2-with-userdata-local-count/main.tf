provider "aws" {
  region = "us-east-1"
  access_key = 
  secret_key = 
}

# List of instance names and corresponding content
locals {
  instance_names = ["frontend", "backend", "database"]
  instance_content = [
    "Hello Frontend",
    "Hello Backend",
    "Hello Database"
  ]
}

# Create instances
resource "aws_instance" "ec2_instances" {
  count         = length(local.instance_names)
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = local.instance_names[count.index]
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y apache2
    sudo systemctl start apache2
    sudo systemctl enable apache2
    echo "${local.instance_content[count.index]}" | sudo tee /var/www/html/index.html
  EOF
}
