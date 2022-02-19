##Environment
variable "environment" {
  default = "Dev"
}
### Key
variable "AWS_ACCESS_KEY" {
  type = string
  default = ""
}
variable "AWS_SECRET_KEY" {
  type = string
  default = ""
}
variable "AWS_REGION" {
  type = string
  default = "ap-south-1"
}
#######

#VPC
variable "instance-tenancy" {
  default = ""
}
variable "enable-dns-support" {
  default = ""
}

variable "enable-dns-hostnames" {
  default = ""
}
##############################
#VPC TAGS
#-----------
#VPC NAME
variable "vpc-name" {
  default = ""
}
#VPC LOCATION
variable "vpc-location" {
  default = ""
}
############################
#VPC Region
variable "region" {
  default = ""
}
############################
#INTERNET-GATEWAY TAGS
variable "internet-gateway-name" {
  default = ""
}

##############################
#PUBLIC-SUBNET TAGS
variable "map_public_ip_on_launch" {
  default = ""
}
variable "public-subnets-name" {
  default = ""
}
variable "public-subnets-location" {
  default = ""
}
variable "public-subnet-routes-name" {
  default = ""
}

#######################################
#PRIVATE-SUBNETS TAGS
variable "private-subnets-location-name" {
  default = ""
}
######################################
#NAT-GATEWAYS REQUIRED
variable "total-nat-gateway-required" {
  default = ""
}

#EIP TAGS
variable "eip-for-nat-gateway-name" {
  default = ""
}

#NAT-GATEWAY TAGS
variable "nat-gateway-name" {
  default = ""
}


#PRIVATE ROUTES CIDR
variable "private-route-cidr" {
  default = ""
}

#PRIVATE ROUTE TAGS
variable "private-route-name" {
  default = ""
}
###########################################################################
#VPC CIDR BLOCK
variable "vpc-cidr" {
  default = ""
}

#PRIVATE SUBNETS TAGS
variable "private-subnet-name" {
  default = ""
}

#FETCH AZS FROM REGION
data "aws_availability_zones" "azs" {}

##Security Groups
variable "sg_name" {
  default = ""
}

variable "security-group" {
  default = ""
}

variable "instance-profile" {
  default = ""
}



