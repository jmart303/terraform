
data "template_file" "instance_config" {
  template = var.template
  vars = {
    environment  = var.environment
    set_hostname = var.set_hostname
  }
}

resource "aws_key_pair" "infra-key" {
  key_name   = "${var.environment}"
  public_key = var.public_key_path
}

resource "aws_instance" "generic" {
  count = length(var.aws_subnet_ids)
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.aws_subnet_ids[count.index]
  vpc_security_group_ids      = [var.aws_security_group_id]
  associate_public_ip_address = true
  user_data                   = data.template_file.instance_config.template
  key_name                    = aws_key_pair.infra-key.id
  security_groups             = [var.aws_security_group_id]


  ebs_block_device {
    device_name = "/dev/sdg"
    volume_size = 85
    volume_type = "gp2"
    encrypted = true
    delete_on_termination = false
  }

  tags = {
    Name     = var.name
  }
}