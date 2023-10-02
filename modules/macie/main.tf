provider "aws" {
  region = var.region
}

resource "aws_lambda_function" "lambda_enable_macie" {
  function_name = var.lambda_function_name
  runtime = ["python3.9"]   
  handler = var.lambda_handler
  memory_size = 128
  timeout =  600
  description = var.function_description

}

resource "aws_lambda_layer_version" "lambda_layer_cfn_response" {
  layer_name = var.lambda_layer_name
  s3_bucket = var.s3_source_bucket
  s3_key = var.s3_key
  description = var.version_description
  compatible_runtimes = ["python3.9"]

}