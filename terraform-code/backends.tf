#terraform {
#  backend "local" {
#  }
#}
terraform { 
  cloud { 
    
    organization = "Terraform-hamza-kurs" 

    workspaces { 
      name = "hamza-terraform-kurs" 
    } 
  } 
}