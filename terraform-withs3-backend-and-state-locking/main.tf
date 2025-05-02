terraform {
  backend "s3" {
    bucket         = "kiran-terraform-tfstate"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "Terrafor-State-Locking"
  }
}

provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}

resource "aws_instance" "example_instance" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "S3_Backend_with_State_Locking"
  }
}
