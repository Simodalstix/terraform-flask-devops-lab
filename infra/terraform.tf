terraform {
  cloud {
    organization = "simodalstix-org"

    workspaces {
      name = "flask-devops-lab"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.45.0"
    }
  }

  required_version = "~> 1.2"
}
