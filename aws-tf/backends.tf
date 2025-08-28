terraform {
  cloud {

    organization = "Terraform-hamza-kurs"

    workspaces {
      name = "terraform-aws"
    }
  }
}

# terraform {
#  backend "s3" {
#    bucket = "aws-terraform-hamza13-state"
#    key    = "terraform.tfstate"
#    region = "us-east-1"
#    use_lockfile = true
#  }
 
#   }
