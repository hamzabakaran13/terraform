terraform { 
  cloud { 
    
    organization = "Terraform-hamza-kurs" 

    workspaces { 
      name = "terraform-aws" 
    } 
  } 
}