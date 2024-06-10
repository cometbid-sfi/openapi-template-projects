# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  type    = string
  default = "app-dev"
}

variable "lambda_function_name" {
  type    = string
  default = "Dynamodb-crudtest"
}
