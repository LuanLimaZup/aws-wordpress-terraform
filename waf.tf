resource "aws_wafv2_web_acl" "wordpress_waf" {
  name        = "wordpress-waf"
  description = "Waf para proteger cloudfront wordpress."
  scope       = "CLOUDFRONT"

  default_action {
    allow {}
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet" #protege contra Sql injections e ataques comuns
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "wordpress-common-rules"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "wordpress-waf"
    sampled_requests_enabled   = true
  }

  tags = merge(
    local.tags, {
      Name = "wordpress-waf"
    }
  )
}