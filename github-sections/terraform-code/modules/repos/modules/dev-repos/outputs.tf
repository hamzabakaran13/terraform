output "clone-urls" {
  value = { for i in github_repository.new_repo : i.name => {
    http-clone-url = i.http_clone_url,
    ssh-clone-url  = i.ssh_clone_url,
    pages-url      = try(i.pages[0].html_url, "no page")
    }
  }
  description = "Repository names and their respective clone URLs."
  sensitive   = false

}