provider "aws" {
  region  = var.region
  profile = var.profile
}

module "vpc" {
  source = "./vpc-module"

  vpc_cidr           = var.vpc_cidr
  vpc_name           = var.vpc_name
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
}

module "ec2" {
  source = "./ec2-module"

  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnets[0]
  instance_name = var.instance_name
}

