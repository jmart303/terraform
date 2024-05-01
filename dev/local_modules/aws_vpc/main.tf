# assigning names using setproduct to get all possible combinations.

locals {
  region  = "us-east-1"
  subnets = {
    for i, v in setproduct(["a", "b"], ["web", "db"]) :
    "${local.region}${v[0]}-${v[1]}" =>
    {
      az   = "${local.region}${v[0]}"
      Name = "${local.region}${v[0]}-${v[1]}"
      cidr = cidrsubnet("10.16.0.0/16", 2, i)
    }
  }
}

resource "aws_vpc" "aws_vpc" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"
  tags = {
    owner = var.common_tags.owner
    team = var.common_tags.team
    Name = var.common_tags.Name
  }
}

resource "aws_subnet" "aws_subnets" {
  for_each          = local.subnets
  vpc_id            = aws_vpc.aws_vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = {
    owner = var.common_tags.owner
    team = var.common_tags.team
    Name = each.value.Name
  }
}

# ignore red.. IDE not mapping properly