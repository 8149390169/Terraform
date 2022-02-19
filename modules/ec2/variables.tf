/*
variable "instance_type" {
  default = "t2.micro"
}
# iam role
variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
  type        = string
  default     = ""
}

variable "number_of_instances" {
  type    = string
  default = 2
}
*/

variable "environmet" {
  default = "UAT"
}

variable "instance_details" {
  description = "instance_details separate by :"
  default     = [
    {
      name        = "Web-101"
      sg_id       = ["sg-077918b26ce7fde48"]
      i_profile   =  "instance_profile"
      subnet_id   = "subnet-02ead23240fcdd085"
      disk_size   = "8"
      disk_type   = "gp2"
      disk_tp     = true
      ami_id      = ""    ## ""|null take value from variable
      az          = "ap-south-1a"
      i_type      = "t2.micro"
      tags        = { "Name" = "Web-101" }
      key_pair    = "a"
    },
    {
      name        = "Web-102"
      sg_id       = ["sg-077918b26ce7fde48"]
      i_profile   =  "instance_profile"
      subnet_id   = "subnet-0f9a6ee7bed1bb480"
      disk_size   = "8"
      disk_type   = "gp2"
      disk_tp     = true
      ami_id      = ""    ## ""|null take value from variable
      az          = "ap-south-1b"
      i_type      = "t2.micro"
      tags        = { "Name"="Web-102" }
      key_pair    = "a"
    }
  ]
}
