output "target_group_arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.test_elb_v2_tg.arn
}

output "aws_lb_name" {
  description = "name of elbv2"
  value       = aws_lb.test_elb_v2.name
}
