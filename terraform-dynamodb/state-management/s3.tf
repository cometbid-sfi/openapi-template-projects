resource "aws_s3_bucket" "bucket" {
  bucket = "sam-note-article-terraform-state-backend"

  tags = {
    Name = "S3 Remote Terraform State Store"
  }
}
