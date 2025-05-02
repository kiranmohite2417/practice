variable "instance_count" {
  type    = number
  default = 3
}

variable "ami" {
  type    = string
  default = "ami-084568db4383264d4"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "az_list" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
