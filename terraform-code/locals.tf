locals {
  repos = {
    infra = {
      lang       = "terraform"
      filename   = "main.tf"
      pages      = false
      auto_init  = true
      visibility = "private"
    }
  }
}