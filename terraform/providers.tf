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
