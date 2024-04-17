
variable "template" {
  description = "instance specific data"
}

variable "environment" {
  description = "instance environment"
}

variable "set_hostname" {
  description = "Whether or not to change the instance hostname"
  default = "true"
}

variable "public_key_path" {
  description = "The absolute path on disk to the SSH public key."
}

variable "private_key_path" {
  description = "The absolute path on disk to the SSH private key."
}

variable "ami" {
  description = "AWS Image"
}

variable "common_tags" {
  type = map(string)
}

variable "instance_type" {
  description = "AWS Instance type"
}

variable "aws_subnet_ids" {

}

variable "aws_security_group_id" {
  default = ""
}

variable "region" {
  default = ""
}


variable "name" {
  default = ""
}
