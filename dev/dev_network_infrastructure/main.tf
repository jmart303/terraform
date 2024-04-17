provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_access_key
  region     = var.region
}

locals {
  common_tags = {
    owner = "jason Martin"
    team  = "my team"
    Name = "dev-vpc"
  }
}

module "vpc" {
  source         = "../local_modules/aws_vpc"
  vpc_cidr_block = var.vpc_cidr_block
  common_tags    = local.common_tags
}
