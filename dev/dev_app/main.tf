provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_access_key
  region     = var.region
}

locals {
  common_tags = {
    owner = "jason Martin"
    team  = "my team"
  }
}

resource "aws_key_pair" "infra-key" {
  key_name   = var.environment
  public_key = file(var.public_key_path)
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnets" "test-subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "example" {
  for_each = toset(data.aws_subnets.test-subnets.ids)
  id       = each.value
}

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.example : s.cidr_block]
}

output "subnet_details" {
  value = [for s in data.aws_subnet.example : s.tags.Name]
}

module "web_security_group" {
  source      = "../local_modules/web_security_group"
  vpc_id      = data.aws_vpc.selected.id
  web_ingress = var.web_ingress
  environment = "myenv"
}

module "db_security_group" {
  source          = "../local_modules/db_security_group"
  vpc_id          = data.aws_vpc.selected.id
  db_ingress      = var.db_ingress
  mgmt_ingress_ip = var.mgmt_ingress_ip
  db_ingress_cidr = module.web_security_group.infrastructure_security_group_id
  environment     = "myenv"
}

#module "web_instance" {
#  source           = "../local_modules/aws_web_instance"
#  template         = file("${path.module}/templates/web_instance_config.sh.tpl")
#  public_key_path  = file(var.public_key_path)
#  private_key_path = file(var.private_key_path)
#  ami              = var.ami
#  aws_subnet_ids   = var.aws_subnet_ids
#  for_each         = var.instance_type
#  environment      = each.key
#  instance_type    = each.value
#  name             = each.key
#  common_tags      = local.common_tags
#}
#
module "database_instance" {
  source           = "../local_modules/aws_database_instance"
  template         = file("${path.module}/templates/instance_config.sh.tpl")
  public_key_path  = file(var.public_key_path)
  private_key_path = file(var.private_key_path)
  ami              = var.ami
#  name = subnet_details
  key_name         = aws_key_pair.infra-key.id
  for_each         = toset(data.aws_subnets.test-subnets.ids)
  aws_subnet_ids   = each.value
  name = each.value
  environment           = var.environment
  instance_type         = var.instance_type
  common_tags           = local.common_tags
  aws_security_group_id = module.db_security_group.infrastructure_security_group_id
}
