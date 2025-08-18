resource "github_repository" "new_repo" {
  for_each = var.repos
  name        = "new-repo-${each.key}"
  description = "${each.value.lang} repository."
  auto_init   = true
  visibility = each.value.visibility

  dynamic "pages" {
    # Only enable pages if requested AND repo is public
    for_each = (each.value.pages && each.value.visibility == "public") ? [1] : []
    content {
      source {
        branch = "main"
        path   = "/"
      }
    }
  }

provisioner "local-exec" {
    command = "gh repo view ${self.name} --web"
  }

provisioner "local-exec" {
    when    = destroy
    command = "rm -rf ${self.name}"
  }

}

resource "terraform_data" "repo-clone" {
  for_each = var.repos
  depends_on = [ github_repository_file.main, github_repository_file.readme ]

  provisioner "local-exec" {
    command = "gh repo clone ${github_repository.new_repo[each.key].name}"
  }
  
}

resource "github_repository_file" "readme" {
  for_each = var.repos
  repository = github_repository.new_repo[each.key].name
  file       = "README.md"
  branch     = "main"
  content =  templatefile("${path.module}/templates/README.md.tmpl", {
    env         = var.env,
    lang        = each.value.lang,
    repo        = each.key,
    authorname  = data.github_user.current.name
  })
  overwrite_on_create = true
  #lifecycle {
   # ignore_changes = [content,]
  #}
  
}

resource "github_repository_file" "main" {
  for_each = var.repos
  repository = github_repository.new_repo[each.key].name
  file       = each.value.filename
  content    = "<h1>Welcome to the ${each.value.lang} repository!</h1>"
  branch     = "main"
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [content,]
  }
}
  
 moved {
  from = github_repository_file.index
  to   = github_repository_file.main
 } 


