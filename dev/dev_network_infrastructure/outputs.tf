output "vpc_id" {
  value = module.vpc.aws_vpc_id
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value = module.vpc.subnet_ids
}

output "subnet_details" {
  value = module.vpc.subnet_details
}