resource "local_file" "repos" {
  content = jsonencode(local.repos)
  filename = "${path.module}/repos.json"


  }

module "repos" {
  source          = "./modules/dev-repos"
  for_each        = var.environments
  repo_max        = 9
  env             = each.key
  repos           = jsondecode(file("repos.json"))
  run_provisoners = false
}

module "deploy_keys" {
  for_each = var.deply_key ? toset(flatten([for k, v in module.repos : keys(v.clone-urls) if k == "dev"])) : []

  source    = "./modules/deploy-keys"
  repo_name = each.key
}

output "repo-list" {
  value = flatten([for k, v in module.repos : keys(v.clone-urls) if k == "dev"])
}

output "clone_urls" {
  value = module.repos
}
