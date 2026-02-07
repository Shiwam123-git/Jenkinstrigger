provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Owner       = "DevOps Team"
      Environment = "Production"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "terrabucket135"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}