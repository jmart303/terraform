
variable "vpc_id" {
  default = "vpc-0653b12db2def35c6"
}

variable "web_ingress" {
  type = map(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {
    "22" = {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["76.154.13.26/32"]
    }
    "80" = {
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["76.154.13.26/32"]
    }
  }
}

variable "db_ingress" {
  type = map(object({
    description = string
    port        = number
    protocol    = string
    security_groups = list(string)
  }))
  default = {
    "5432" = {
      description = "db_port"
      port        = 5432
      protocol    = "tcp"
      security_groups = [""]
    }
  }
}

variable "mgmt_ingress_ip" {
  type = list(string)
   default = ["76.154.13.26/32"]
}

# instance keys for ssh access
variable "public_key_path" {
  description = "The absolute path on disk to the SSH public key."
  default     = "~/.ssh/iso-forensics.pub"
}

variable "private_key_path" {
  description = "The absolute path on disk to the SSH private key."
  default     = "~/.ssh/iso-forensics"
}

variable "ami" {
  description = "AWS Image"
  default = "ami-008677ef1baf82eaf"
}

variable "aws_access_key" {
  description = "AWS access key for account"
}

variable "aws_secret_access_key" {
  description = "AWS secret key for account"
}

variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}
variable "environment" {
  default = "test"
}

variable "name" {
  default = "jmart-test"
}
