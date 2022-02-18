module "vpc" {
  source = "../../modules/vpc"
  application_name = ""
  cidr_block = ""
  enable_dns_hostnames = false
  enable_dns_support = false
  environment = ""
  key_name = ""
  tags = {}
}


module "sg" {
  count = length(var.security_groups)
  source = "../../modules/security_groups"
  description = var.security_groups[count.index].description
  egress_rules = var.security_groups[count.index].name
  ingress_rules = var.security_groups[count.index].ingress_rules
#  name = var.security_groups[count.index].name
  vpc_id = module.vpc.vpc_id
  application_name = var.application_name
  environment = var.environment
  tags = var.tags
}