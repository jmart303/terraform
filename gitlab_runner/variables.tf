variable "aws_access_key" {
  description = "AWS access key for account"
}

variable "aws_secret_access_key" {
  description = "AWS secret key for account"
}

variable "environment" {
  description = "instance environment"
  default = "development"
}

variable "namespace" {
  description = "Service Naming"
}

variable "public_key_path" {
  description = "The absolute path on disk to the SSH public key."
  default     = "~/.ssh/automation.pub"
}

variable "iam_instance_profile" {}

variable "private_key_path" {
  description = "The absolute path on disk to the SSH private key."
  default     = "~/.ssh/automation"
}

variable "ami" {
  description = "AWS Image"
}

variable "region" {
  default = ""
  description = "select region"
}

variable "instance_type" {
  description = "AWS Instance type"
}

variable "availability_zone" {
  description = "az us-east-2c, us-east-1c"
}

variable "owner" {
  description = "Instance Owner"
  default = "jason martin"
}

variable "cidr_block_pub" {
  description = "private access"
}

variable "email" {
  description = "Email address for owner tag"
}

variable "os" {
  description = "os of instance"
}

variable "aws_subnet_id" {
  description = "Subnet ID"
}

variable "vpc_id" {
  description = "vpc ID"
}

variable "ingress_port_mgmt" {}

variable "ingress_port_service" {}

variable "ingress_port_service_2" {
  description = "Application port 2"
}
#variable "volume_id" {}

