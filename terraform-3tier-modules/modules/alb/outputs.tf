output "alb_arn" {
  value = aws_lb.three_tier.arn
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "target_group_arn" {
  value = aws_lb_target_group.three_tier.arn
}

output "alb_dns_name" {
  value = aws_lb.three_tier.dns_name
}