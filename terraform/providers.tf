terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.47.0"
    }
  }
}

provider "aws" {
  region  = "${var.region}"
  #assume_role {
  #  role_arn = "arn:aws:iam::*********:role/wtw-admin"
  #}
  default_tags {
    tags = {
    #   component = var.component
      created-by = "terraform"
      env = var.env
    }
  }  
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "inodev-exercise"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
