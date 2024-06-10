# AWS Dynamodb with Terraform

## Introduction

When building serverless applications with AWS, a go-to choice is DynamoDB due to its automatic scaling to meet request demands.
This project builds a simple CRUD api with Node.js using Dynamodb NoSql database.

With Terraform as "Infrastructure as Code" tool to provision and manage our cloud infrastructure.

## Why DynamoDb with Terraform?

Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp to provision and manage cloud infrastructure, and dynamoDB pairs well with Terraform.

Why? It allows you to create your DynamoDb table with your required options using minimal code to enforce quick development times.
Moreover, it integrates seamlessly with other AWS infrastructure (AWS Lambda, API Gateway), allowing you to automate the entire build and deploy process to build
full-fledged applications (that interact with DynamoDB) quickly.

## Project demonstration

### Step 1 - Prerequisites

Make sure you have:

- Set up your AWS Profile
- Node.JS
- Homebrew (Mac) (brew install hashicorp/tap/terraform) / Chocolatey (Windows) (choco install terraform)
- Terraform

You should be able to run the following command with no issue.

`

# check if AWS credentials are set up

aws sts get-caller-identity

# return installed terraform version if successful

terraform version

`

### Step 2 - Initialize AWS Provider in Terraform

Create a new folder in a directory that you prefer.

`
mkdir terraform-dynamodb
cd terraform-dynamodb

`
Afterward, create a file - main.tf
Open your main.tf file and add the code shown below.

code `
    terraform {
      required_providers {
        aws = {
            source = "hashicorp/aws"
        }
      }
    }

    provider "aws" {
        region = "us-east-1"
        shared_credentials_files = ["$HOME/.aws/credentials"]
    }
`

Call the Lambda function: 

aws lambda invoke --function-name=$(terraform output -raw function_name) --profile=app-dev output.json 