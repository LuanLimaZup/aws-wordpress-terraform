resource "aws_cloudfront_distribution" "wordpress_cdn" {
  web_acl_id = aws_wafv2_web_acl.wordpress_waf.arn
  origin {
    domain_name = aws_lb.wordpress_alb.dns_name
    origin_id   = "wordpress-alb-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }


  enabled         = true
  is_ipv6_enabled = true
  comment         = "Cloundfront para wordpress ALB"


  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "wordpress-alb-origin"

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }

    #WordPress dinâmico costuma quebrar fácil com cache agressivo. ttl desativado
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = merge(
    local.tags, {
      Name = "wordpress-cloudfront"
    }
  )

}
