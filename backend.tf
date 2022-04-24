terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.11.0"
    }
    archive = {
      source = "hashicorp/archive"
      version = "2.2.0"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}
