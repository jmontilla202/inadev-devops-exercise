terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.47.0"
    }
    utils = {
      source = "cloudposse/utils"
      version = "1.22.0"
    }
  }
}

provider "aws" {
  region  = "${var.region}"

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

}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "utils" {

}
