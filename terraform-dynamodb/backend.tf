terraform {
  backend "s3" {
    bucket         = "sam-note-article-terraform-state-backend"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state"
  }
}

