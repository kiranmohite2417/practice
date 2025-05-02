provider "aws" { 
  region  = "ap-south-1"
  profile = "default"
}

# Terraform Variable Block
variable "instance_type" {
  type = map(any)

  default = {
    dev  = "t2.micro"
    prod = "t3.micro"
  }
}

# Terraform Datasource Block: Default VPC
data "aws_vpc" "default_vpc" {
  default = true
}

# ✅ Filtered to a specific Availability Zone to avoid multiple matches
data "aws_subnet" "default_subnet" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }

  filter {
    name   = "availability-zone"
    values = ["ap-south-1a"]  # Choose a specific AZ here
  }
}

# Terraform Datasource Block: Default Security Group
data "aws_security_group" "default_sg" {
  filter {
    name   = "group-name"
    values = ["default"]
  }

  vpc_id = data.aws_vpc.default_vpc.id
}

# Terraform Resource Block: EC2 Instance
resource "aws_instance" "example_instance" {
  ami                    = "ami-0e35ddab05955cf57"
  instance_type          = var.instance_type[terraform.workspace]
  subnet_id              = data.aws_subnet.default_subnet.id
  vpc_security_group_ids = [data.aws_security_group.default_sg.id]
}

