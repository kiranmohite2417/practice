output "instance_id1" {
  description = "The ID of the first EC2 instance"
  value       = aws_instance.first_ec2_creation[0].id
}

output "instance_id2" {
  description = "The ID of the second EC2 instance"
  value       = aws_instance.first_ec2_creation[1].id
}

output "instance_id3" {
  description = "The ID of the third EC2 instance"
  value       = aws_instance.first_ec2_creation[2].id
}

output "instance_ids" {
  description = "The IDs of all EC2 instances"
  value       = aws_instance.first_ec2_creation[*].id
}
