resource "aws_route53_zone" "main" {
  name = "wordpress-lab.online"
}

resource "aws_route53_record" "domain_route53" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "wordpress-lab.online"
  type    = "A"

  alias {
    name                   = module.alb.alb_dns_name
    zone_id                = module.alb.alb_zone_id
    evaluate_target_health = true
  }
}