terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
  }

  required_version = "~> 1.1"
}

provider "aws" {
  region                   = var.aws_region
  profile                  = var.aws_profile
  shared_credentials_files = ["$HOME/.aws/credentials"]
}

resource "aws_dynamodb_table" "tf_notes_table" {
  name           = "tf-notes-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = "30"
  write_capacity = "30"
  hash_key       = "noteId"
  attribute {
    name = "noteId"
    type = "S"
  }

  // adding the TTL on DynamoDB Table
  ttl {
    // enabling TTL
    enabled = true

    // the attribute name which enforces TTL, must be a Number (Timestamp)
    attribute_name = "expiryPeriod"
  }

  // configuring Point in Time Recovery 
  point_in_time_recovery {
    enabled = true
  }

  // configure encryption at REST
  server_side_encryption {
    enabled = true
    // false -> use AWS Owned CMK 
    // true -> use AWS Managed CMK 
    // true + key arn -> use custom key
  }

  lifecycle { ignore_changes = [write_capacity, read_capacity] }
}

module "table_autoscaling" {
  source     = "snowplow-devops/dynamodb-autoscaling/aws" // add the autoscaling module
  table_name = aws_dynamodb_table.tf_notes_table.name     // apply autoscaling for the tf_notes_table
}

// Provisioning Lambda CRUD API

// Creates an Claudia API with Basic Execution role for Lambda
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

// Creates a Policy to allow all DynamoDb actions on the created table
// for all resources usng the created role
resource "aws_iam_role_policy" "dynamodb-lambda-policy" {
  name = "dynamodb_lambda_policy"
  role = aws_iam_role.iam_for_lambda.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : ["dynamodb:*"],
        "Resource" : "${aws_dynamodb_table.tf_notes_table.arn}"
      }
    ]
  })
}

resource "aws_lambda_function" "iam_for_lambda" {
  environment {
    variables = {
      NOTES_TABLE = aws_dynamodb_table.tf_notes_table.name
    }
  }
  memory_size      = "128"
  timeout          = 10
  runtime          = "nodejs16.x"
  architectures    = ["arm64"]
  filename         = "${path.module}/tmp/notes-api.zip"
  function_name    = var.lambda_function_name
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.notes_api.output_base64sha256
}

resource "aws_cloudwatch_log_group" "lambda_cloudwatch_log_group" {
  name = "/aws/lambda/${aws_lambda_function.iam_for_lambda.function_name}"

  retention_in_days = 30
}

/*
data "archive_file" "create-note-archive" {
  source_file = "lambdas/create-note.js"
  output_path = "lambdas/create-note.zip"
  type        = "zip"
}

resource "aws_lambda_function" "create-note" {
  environment {
    variables = {
      NOTES_TABLE = aws_dynamodb_table.tf_notes_table.name
    }
  }
  memory_size   = "128"
  timeout       = 10
  runtime       = "nodejs20.x"
  architectures = ["arm64"]
  handler       = "lambdas/create-note.handler"
  function_name = "create-note"
  role          = aws_iam_role.iam_for_lambda.arn
  filename      = "lambdas/create-note.zip"
}

data "archive_file" "delete-note-archive" {
  source_file = "lambdas/delete-note.js"
  output_path = "lambdas/delete-note.zip"
  type        = "zip"
}

resource "aws_lambda_function" "delete-note" {
  environment {
    variables = {
      NOTES_TABLE = aws_dynamodb_table.tf_notes_table.name
    }
  }
  memory_size   = "128"
  timeout       = 10
  runtime       = "nodejs20.x"
  architectures = ["arm64"]
  handler       = "lambdas/delete-note.handler"
  function_name = "delete-note"
  role          = aws_iam_role.iam_for_lambda.arn
  filename      = "lambdas/delete-note.zip"
}

data "archive_file" "get-all-notes-archive" {
  source_file = "lambdas/get-all-notes.js"
  output_path = "lambdas/get-all-notes.zip"
  type        = "zip"
}

resource "aws_lambda_function" "get-all-notes" {
  environment {
    variables = {
      NOTES_TABLE = aws_dynamodb_table.tf_notes_table.name
    }
  }
  memory_size   = "128"
  timeout       = 10
  runtime       = "nodejs20.x"
  architectures = ["arm64"]
  handler       = "lambdas/get-all-notes.handler"
  function_name = "get-all-notes"
  role          = aws_iam_role.iam_for_lambda.arn
  filename      = "lambdas/get-all-notes.zip"
}
*/
