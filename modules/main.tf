module "vpc" {
  source = "./vpc"
  ###VPC###
  environment = "Dev"
  instance-tenancy = "default"
  enable-dns-support = "true"
  enable-dns-hostnames = "true"
  vpc-name = "mumbai-vpc"
  vpc-location = "mumbai"
  region = "ap-south-1"
  internet-gateway-name = "Test-igw"
  map_public_ip_on_launch = "true"
  public-subnets-name = "public-subnets"
  public-subnets-location = "mumbai"
  public-subnet-routes-name = "public-subnet-routes"
  private-subnets-location-name = "mumbai"
  private-subnet-name = "private-subnets"
  total-nat-gateway-required = "1"
  eip-for-nat-gateway-name = "eip-nat-gateway"
  nat-gateway-name = "nat-gateway"
  private-route-cidr = "0.0.0.0/0"
  private-route-name = "private-route"
  vpc-cidr = "10.11.0.0/16"
  vpc-public-subnet-cidr = ["10.11.1.0/24","10.11.2.0/24","10.11.3.0/24"]
  vpc-private-subnet-cidr = ["10.11.4.0/24","10.11.5.0/24","10.11.6.0/24"]
  sg_name = "mumbai-vpc-sg"
}
###################################################
/*
module "ec2module" {
  source = "/root/shubham/Terraform-aws/modules/ec2"
}
*/
###################################################
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.3.0"

  name = "my-alb"
  environment = "Dev"
  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc-id
  subnets        =  module.vpc.public-subnet-ids
  security_groups = [ module.vpc.security ]

  target_groups = [
    {
      name_prefix      = "Target-Group"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Name = "Test"
  }
}
###################################################
module "auto-scaling" {
  source = "./autoscaling"
  region = "ap-south-1"
  #Launch Configuration
  environment = "Dev"
  launch-configuration-name = "Web"
  instance-type = "t2.micro"
  launch-configuration-security-groups = module.vpc.security
  launch-configuration-public-key-name = "a"
  instance-profile = "instance_profile"

  #Auto-Scaling

  autoscaling-group-name = "Test-asg"
  max-size = "3"
  min-size = "2"
  health-check-grace-period = "200"
  desired-capacity = "2"
  force-delete = "true"
  #A list of subnet IDs to launch resources in
  vpc-zone-identifier = module.vpc.public-subnet-ids
  target-group-arns = module.alb.target_group_arns
  health-check-type = "ELB"
  tag-key = "Name"
  tag-value = "${var.environment}"

  #Auto-Scaling Policy-Scale-up
  auto-scaling-policy-name-scale-up = "cpu-policy-scale-up"
  adjustment-type-scale-up = "ChangeInCapacity"
  scaling-adjustment-scale-up = "1"
  cooldown-scale-up = "120"
  policy-type-scale-up = "SimpleScaling"

  #Auto-Scaling Policy Cloud-Watch Alarm-Scale-Up
  alarm-name-scale-up = "cpu-alarm-scale-up"
  comparison-operator-scale-up = "GreaterThanOrEqualToThreshold"
  evaluation-periods-scale-up = "2"
  metric-name-scale-up = "CPUUtilization"
  namespace-scale-up = "AWS/EC2"
  period-scale-up = "120"
  statistic-scale-up = "Average"
  threshold-scale-up = "20"

  #Auto-Scaling Policy-Scale-down
  auto-scaling-policy-name-scale-down = "cpu-policy-scale-down"
  adjustment-type-scale-down = "ChangeInCapacity"
  scaling-adjustment-scale-down = "-1"
  cooldown-scale-down = "120"
  policy-type-scale-down = "SimpleScaling"

  #Auto-Scaling Policy Cloud-Watch Alarm-Scale-down
  alarm-name-scale-down = "cpu-alarm-scale-down"
  comparison-operator-scale-down = "LessThanOrEqualToThreshold"
  evaluation-periods-scale-down = "2"
  metric-name-scale-down = "CPUUtilization"
  namespace-scale-down = "AWS/EC2"
  period-scale-down = "120"
  statistic-scale-down = "Average"
  threshold-scale-down = "10"

}

