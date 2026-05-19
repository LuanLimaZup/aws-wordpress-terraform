output "alb_dns_name" {
  value = aws_lb.wordpress_alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.wordpress_alb.zone_id
}

output "target_group_arn" {
  value = aws_lb_target_group.wordpress_target_group.arn
}