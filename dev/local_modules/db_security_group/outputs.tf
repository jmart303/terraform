output "infrastructure_security_group_id" {
  value = aws_security_group.db_infrastructure_sg.id
}