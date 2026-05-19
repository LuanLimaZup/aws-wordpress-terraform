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
  alb_security_group_id = aws_security_group.alb_sg.id
  certificate_arn       = aws_acm_certificate.cert.arn
  tags                  = local.tags
}