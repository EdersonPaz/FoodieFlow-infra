terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41"
    }
  }



  required_version = ">= 1.3"
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.6.0"
    }
  }
  backend "s3" {
    bucket = "terraform-foodieflow-db"
    key    = "api/terraform.tfstate"
    region = "us-east-1"
  }
  required_version = "~> 1.0"
}
