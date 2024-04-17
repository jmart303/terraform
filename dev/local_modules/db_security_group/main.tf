
resource "aws_security_group" "db_infrastructure_sg" {
  name        = "${var.environment}-database"
  vpc_id      = var.vpc_id

  dynamic "ingress"{
    for_each = var.db_ingress
    content {
      from_port = ingress.value.port
      to_port = ingress.value.port
      protocol = ingress.value.protocol
      security_groups = [var.db_ingress_cidr]
    }
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = var.mgmt_ingress_ip
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    environment = var.environment
  }
}