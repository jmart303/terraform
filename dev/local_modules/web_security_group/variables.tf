

variable "web_ingress" {
  type = map(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "vpc_id" {}

variable "environment" {}