provider "aws" {
  profile                 = "app-dev"
  region                  = "us-east-1"
}

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  tags = {
    Name = "vpc"
  }
}