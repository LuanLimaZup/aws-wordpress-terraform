variable "alb_dns_name" {
  description = "ALB DNS name used as CloudFront origin"
  type        = string
}

variable "web_acl_arn" {
  description = "WAF Web ACL ARN associated with CloudFront"
  type        = string
}

variable "tags" {
  description = "Tags to apply to CloudFront"
  type        = map(string)
}