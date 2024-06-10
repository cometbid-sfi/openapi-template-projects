# Output value definitions

output "function_name" {
  description = "Name of the Lambda function."

  value = aws_lambda_function.iam_for_lambda.function_name
}

output "function_url" {
  description = "Endpoint of the Lambda function."

  value = aws_lambda_function.iam_for_lambda.arn
}
