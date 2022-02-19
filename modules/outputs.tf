#OUTPUT OF VPC-ID
output "vpc-id" {
  description = "The ID of the VPC"
  value = module.vpc.vpc-id
}

#OUTPUT OF IGW
output "igw" {
  value = module.vpc.igw
}

#OUTPUT OF PUBLIC SUBNET IDS
output "public-subnet-ids" {
  description = "Public Subnets IDS"
  value = module.vpc.public-subnet-ids
}

#OUTPUT OF EIP FOR NAT GATEWAYS
output "eip-ngw" {
  value = module.vpc.eip-ngw
}

#OUTPUT OF NAT-GATEWAYS
output "ngw" {
  value = module.vpc.ngw
}

#OUTPUT OF PRIVATE SUBNET IDS
output "private-subnet-ids" {
  description = "Private Subnets IDS"
  value = module.vpc.private-subnet-ids
}

#OUTPUT OF PUBLIC SUBNET ASSOCIATION WITH PUBLIC ROUTE TABLES
output "public-association" {
  value = module.vpc.public-association
}

#OUTPUT OF PUBLIC ROUTES ID
output "aws-route-table-public-routes-id" {
  value = module.vpc.aws-route-table-public-routes-id
}

#OUTPUT OF REGION AZS
output "aws-availability-zones" {
  value = module.vpc.aws-availability-zones
}

#OUTPUT OF PRIVATE ROUTE TABLE IDS
output "aws-route-table-private-routes-id" {
  value = module.vpc.aws-route-table-private-routes-id
}

/*
output "instance_1" {
  description = "List of IDs of instances"
  value       = "${element(module.ec2module.instance_ids, 1)}"
}

output "instance_2" {
  description = "List of IDs of instances"
#  value       = module.ec2module.instance_ids
  value       = "${element(module.ec2module.instance_ids, 2)}"
}

output "public_1" {
  description = "List of IDs of instances"
  value       = "${element(module.ec2module.public_ip, 1)}"
}

output "public_2" {
  description = "List of IDs of instances"
  value       = "${element(module.ec2module.public_ip, 2)}"
}
output "private_1" {
  description = "List of IDs of instances"
  value       = module.ec2module.private_ips
}

output "private_2" {
  description = "List of IDs of instances"
#  value       = "${element(module.ec2module.private_ips, 2)}"
  value       = module.ec2module.private_ips
}
*/
output "lb_arn" {
  description = "The ID and ARN of the load balancer we created."
  value       = module.alb.lb_arn

}

output "lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = module.alb.lb_dns_name
}

output "target_group_arns" {
  description = "ARNs of the target groups. Useful for passing to your Auto Scaling group."
  value       = module.alb.target_group_arns
}

##Security Group
output "security"{
  value = module.vpc.security
}

