module "repos" {
  source          = "./modules/dev-repos"
  for_each        = var.environments
  repo_max        = 9
  env             = each.key
  repos           = local.repos
  run_provisoners = false
}

module "deploy_keys" {
  for_each = var.deply_key ? toset(flatten([for k, v in module.repos : keys(v.clone-urls) if k == "dev"])) : []

  source    = "./modules/deploy-keys"
  repo_name = each.key
}

output "repo_info" {
  value = { for k, v in module.repos : k => v.clone-urls }
}
output "repo-list" {
  value = flatten([for k, v in module.repos : keys(v.clone-urls) if k == "dev"])
}

module "info_page" {
  source          = "./modules/info-page"
  repos           = { for k, v in module.repos["prod"].clone-urls : k => v }
  run_provisoners = false
}