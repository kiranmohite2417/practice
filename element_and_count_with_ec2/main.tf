resource "aws_instance" "first_ec2_creation" {
  count              = var.instance_count
  ami                = var.ami
  instance_type      = var.instance_type
  availability_zone = element(var.az_list, count.index)

  tags = {
    Name = "first_ec2_creationInstance-${count.index}"
  }
}
