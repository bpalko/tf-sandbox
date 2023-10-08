terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" { #TODO bucket is created manually. no init setup yet
    bucket         = "palko-tfstate-648903480055" # account-id
    key            = "tf-state/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}