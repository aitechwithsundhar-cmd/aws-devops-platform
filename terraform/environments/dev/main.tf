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