
variable "aws_access_key" {
  description = "AWS access key for account"
}

variable "aws_secret_access_key" {
  description = "AWS secret key for account"
}

variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  default = "10.16.0.0/16"
}

