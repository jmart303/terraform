
module "gitlab_runner_instance" {
  source                = "git::ssh://git@github.com:jmart303/terraform_modules.git//infrastructure_instances"
  template              = file("${path.module}/templates/instance_config.sh.tpl")
  environment           = var.environment
  namespace             = var.namespace
  public_key_path       = file(var.public_key_path)
  private_key_path      = file(var.private_key_path)
  ami                   = var.ami
  instance_type         = var.instance_type
  aws_subnet_id         = var.aws_subnet_id
  aws_security_group_id = module.infrastructure_security_groups.infrastructure_security_group_id
  email                 = var.email
  iam_instance_profile  = var.iam_instance_profile
}


module "infrastructure_security_groups" {
  source                 = "git::ssh://git@github.com:jmart303/terraform_modules.git//infrastructure_security"
  vpc_id                 = var.vpc_id
  environment            = var.environment
  cidr_block_pub         = var.cidr_block_pub
  aws_security_group_id  = ""
  email                  = var.email
  namespace              = var.namespace
  ingress_port_mgmt      = var.ingress_port_mgmt
  ingress_port_service   = var.ingress_port_service
  ingress_port_service_2 = var.ingress_port_service_2
}
