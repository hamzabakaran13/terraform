output "cloud_repo_url" {
  value = { for i in github_repository.new_repo : i.name => [i.http_clone_url, i.ssh_clone_url] }
  description = "Repository names and their respective clone URLs."
  sensitive = false
  
}