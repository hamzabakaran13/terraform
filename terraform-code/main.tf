resource "random_id" "random" {
    byte_length = 2
    count = var.repo_count
}

resource "github_repository" "mtc_repo" {
    count = var.repo_count
    name  = "mtc-repo-${random_id.random[count.index].dec}"
    visibility = "private"
    auto_init = true
  
}
resource "github_repository_file" "readme" {
    count = var.repo_count
    repository = github_repository.mtc_repo[count.index].name
    branch = "main"
    file = "README.md"
    content = "This is a README file for mtc-repo-${random_id.random[count.index].dec}"
    commit_message = "Add README file"
  
}

resource "github_repository_file" "index" {
    count = var.repo_count
    repository = github_repository.mtc_repo[count.index].name
    branch = "main"
    file = "index.html"
    content = "<html><body><h1>Welcome to mtc-repo-${random_id.random[count.index].dec}</h1></body></html>"
    commit_message = "Add index.html file"
  
}
