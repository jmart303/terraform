
data "template_file" "instance_config" {
  template = var.template
  vars = {
    environment  = var.environment
    set_hostname = var.set_hostname
  }
}

resource "aws_instance" "generic" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.aws_subnet_ids
  vpc_security_group_ids      = [var.aws_security_group_id]
  associate_public_ip_address = true
  user_data                   = data.template_file.instance_config.template
  key_name                    = var.key_name
  security_groups             = [var.aws_security_group_id]

  ebs_block_device {
    device_name = "/dev/sdg"
    volume_size = 85
    volume_type = "gp2"
    encrypted = true
    delete_on_termination = false
  }

  tags = {
    owner = var.common_tags.owner
    team = var.common_tags.team
    Name = var.name
  }
}