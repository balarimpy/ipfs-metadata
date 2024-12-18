provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "ipfs-metadata-task"
    key            = "terraform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ipfs-metadata"
    encrypt        = true
  }
}
