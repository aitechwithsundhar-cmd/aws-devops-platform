module "vpc" {
  source = "../../modules/vpc"

  project     = var.project
  environment = var.environment
}

module "security_group" {
  source = "../../modules/security-group"

  project     = var.project
  environment = var.environment
  sg_names    = var.sg_names

  depends_on = [module.vpc]
}

module "security_group_rules" {
  source = "../../modules/security-group-rules"

  project     = var.project
  environment = var.environment

  depends_on = [
    module.security_group
  ]
}

module "bastion" {
  source = "../../modules/bastion"

  project     = var.project
  environment = var.environment

  depends_on = [
    module.security_group_rules
  ]
}

module "databases" {
  source = "../../modules/databases"

  project     = var.project
  environment = var.environment
  zone_id     = var.zone_id
  domain_name = var.domain_name

  depends_on = [
    module.bastion
  ]
}

module "backend_alb" {
  source = "../../modules/backend-alb"

  project     = var.project
  environment = var.environment
  zone_id     = var.zone_id
  domain_name = var.domain_name

  depends_on = [
    module.databases
  ]
}