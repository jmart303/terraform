
output "aws_vpc_id" {
  description = "The ID of the VPC"
  value       = try(aws_vpc.aws_vpc.id, null)
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = try(aws_subnet.aws_subnets.*.id, null)
}

output "subnet_details" {
  value = toset([
    for sub_name in aws_subnet.aws_subnets : sub_name.tags.Name
  ])
}