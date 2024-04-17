variable "email" {
  description = "Email address for owner tag"
}

variable "aws_instance" {
  default = ""
}

variable "aws_subnet_id_1" {
  description = "Subnet ID"
}

variable "aws_subnet_id_2" {
  description = "Subnet ID"
}

variable "aws_security_group_id" {
  default = ""
}

variable "vpc_id" {
  default = ""
}
