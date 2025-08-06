resource  "github_repository" "backend_repo" {
  name        = "backend"
  description = "This is an example backend repository created for Lab"
  visibility  = "public"
  auto_init = true


topics = ["terraform", "github", "example"]

has_issues     = true
has_projects   = true
has_wiki       = true
allow_squash_merge = true

}

resource "github_branch" "backend_feature" {
    repository = github_repository.backend_repo.name
    branch     = "develop"
}

resource "github_repository" "frontend_repo" {
    depends_on = [github_repository.backend_repo]
    name        = "frontend"
    description = "This is an example frontend repository created for Lab"
    visibility  = "public"
    auto_init = true

    topics = ["terraform", "github", "example"]

    has_issues     = true
    has_projects   = true
    has_wiki       = true
    allow_squash_merge = true
}

resource "github_branch" "frontend_feature" {
    repository = github_repository.frontend_repo.name
    branch     = "develop"
}
