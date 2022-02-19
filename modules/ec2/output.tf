output "instance_ids" {
  description = "List of IDs of instances"
  value       = aws_instance.myec2.*.id
}

output "private_ips" {
  description = "List of private IP addresses assigned to the instances"
# value       = aws_instance.myec2.*.private_ip
  value       = element(concat(aws_instance.myec2.*.id, [""]), 0)
}

output "public_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = aws_instance.myec2.*.public_ip
}

