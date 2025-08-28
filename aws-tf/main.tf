#Root module

locals {
  apps = {
    ui = {
      ecr_repositpry_name = "ui"
      app_path            = "ui"
      image_version       = "1.0.3"
      app_name            = "ui"
      port                = 80
      is_public           = true
      path_pattern        = "/*"
    }
    api = {
      ecr_repositpry_name = "api"
      app_path            = "api"
      image_version       = "1.0.3"
      app_name            = "api"
      port                = 80
      is_public           = false
      path_pattern        = "/api/*"
    }
  }
}


module "infra" {
  source      = "./modules/infra"
  vpc_cidr    = "10.0.0.0/16"
  num_subnets = 2
  allowed_ips = ["0.0.0.0/0"]
}

module "app" {
  source                = "./modules/app"
  for_each              = local.apps
  ecr_repositpry_name   = each.value.ecr_repositpry_name
  app_path              = each.value.app_path
  image_version         = each.value.image_version
  app_name              = each.value.app_name
  port                  = each.value.port
  execution_role_arn    = module.infra.execution_role_arn
  app_security_group_id = module.infra.app_security_group_id
  cluster_arn           = module.infra.cluster_arn
  subnets               = module.infra.public_subnets
  is_public             = each.value.is_public
  vpc_id                = module.infra.vpc_id
  path_pattern          = each.value.path_pattern
  alb_listener_arn      = module.infra.alb_listener_arn
}