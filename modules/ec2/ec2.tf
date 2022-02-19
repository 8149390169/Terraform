resource "aws_instance" "myec2" {
#  count         = var.number_of_instances 
#  ami           = data.aws_ami.app_ami.id
#  instance_type = var.instance_type
#  availability_zone      = var.instance_details[count.index].az
  count                   = length(var.instance_details)
  availability_zone       = var.instance_details[count.index].az
  ami                     = data.aws_ami.app_ami.id
  instance_type           = var.instance_details[count.index].i_type
  iam_instance_profile    = var.instance_details[count.index].i_profile
  root_block_device {
    volume_size           = var.instance_details[count.index].disk_size
    volume_type           = var.instance_details[count.index].disk_type
    delete_on_termination = var.instance_details[count.index].disk_tp
  }
  subnet_id               = var.instance_details[count.index].subnet_id
  key_name                = var.instance_details[count.index].key_pair
  vpc_security_group_ids  = var.instance_details[count.index].sg_id
  tags                    = var.instance_details[count.index].tags
  volume_tags             = var.instance_details[count.index].tags
  user_data               = "${file("user_data.sh")}"
}


data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}
