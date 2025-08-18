module "repos" {
  source   = "./modules/dev-repos"
  repo_max = 2
  env      = "dev"
  repos = {
    infra = {
      lang      = "terraform"
      filename  = "main.tf"
      pages     = false
      auto_init = true
      visibility = "private"
    }
    frontend = {
      lang      = "python"
      filename  = "main.py"
      pages     = true
      auto_init = true
      visibility = "public"
    }
  }
}