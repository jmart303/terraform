

variable "db_ingress" {
  type = map(object({
    port        = number
    protocol    = string
    security_groups = list(string)
  }))
}

variable "mgmt_ingress_ip" {}

variable "vpc_id" {}

variable "db_ingress_cidr" {}

variable "environment" {}