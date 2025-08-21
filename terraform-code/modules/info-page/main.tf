data "data terraform_remote_state" "repos" {
  backend = "remote"

  config {
    organization = "Terraform-hamza-kurs"
    workspaces = {
      name = "terraform"
    }
  }

}

locals {
  repos = { for k, v in data.terraform_remote_state.repos.outputs.clone_urls["prod"].clone-urls : k => v}
}

resource "github_repository" "this" {
  name        = "new-repo-info-page"
  description = "Repository Information for new repo"
  visibility  = "public"
  auto_init   = true
  pages {
    source {
      branch = "main"
      path   = "/"
    }
  }
  provisioner "local-exec" {
    command = var.run_provisoners ? " gh repo view ${self.name} --web" : "echo 'Provisioners are disabled'"
  }


}

data "github_user" "current" {
  username = ""
}

resource "time_static" "this" {
}

resource "github_repository_file" "this" {
  repository = github_repository.this.name
  branch     = "main"
  file       = "index.md"
  content = templatefile("${path.module}/templates/index.tftpl", {
    name   = data.github_user.current.name
    avatar = data.github_user.current.avatar_url
    date   = time_static.this.year
    repos  = local.repos
  })
}

