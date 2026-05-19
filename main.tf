module "vpc" {
  source = "./modules/vpc"

  cidr_block = var.cidr_block
  region     = data.aws_region.current.region
  vpc_name   = "wordpress-vpc"
  tags       = local.tags
}

module "alb" {
  source = "./modules/alb"

  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.security_group.alb_security_group_id
  certificate_arn       = aws_acm_certificate.cert.arn
  tags                  = local.tags
}

module "security_group" {
  source = "./modules/security-group"

  vpc_id = module.vpc.vpc_id
  tags   = local.tags
}

module "launch_template" {
  source = "./modules/launch-template"

  efs_id                    = module.efs.efs_id
  ec2_security_group_id     = module.security_group.ec2_security_group_id
  iam_instance_profile_name = aws_iam_instance_profile.ec2_ssm_profile.name
  tags                      = local.tags
}

module "auto_scaling_group" {
  source = "./modules/auto-scaling-group"

  launch_template_id = module.launch_template.launch_template_id
  private_subnet_ids = module.vpc.private_subnet_ids
  target_group_arn   = module.alb.target_group_arn
  tags               = local.tags
}

module "efs" {
  source = "./modules/efs"

  private_subnet_ids    = module.vpc.private_subnet_ids
  efs_security_group_id = module.security_group.efs_security_group_id
  tags                  = local.tags
}

module "cloudfront" {
  source = "./modules/cloudfront"

  alb_dns_name = module.alb.alb_dns_name
  web_acl_arn  = module.waf.web_acl_arn
  tags         = local.tags
}

module "waf" {
  source = "./modules/waf"

  tags = local.tags
}