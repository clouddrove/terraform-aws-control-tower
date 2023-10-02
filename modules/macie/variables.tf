variable "region" {
  default = "us-east-1" 
}

variable "lambda_function_name" {
  default = "Lambda-Enable-Macie"
}

variable "lambda_handler" {
  default = "index.lambda_handler"
}

variable "function_description" {
  default = "Lambda Function that is triggered by CloudFormation Custom Resource to Enable Amazon Macie by Default"
}

variable "lambda_layer_name" {
  default = "cfnresponse"
}

variable "s3_source_bucket" {
  description = " S3 bucket location containing the function's deployment package."
  default = "s3_bucket_name"
}

variable "s3_key" {
  description = "S3 key of an object containing the function's deployment package. "  
  default = "cfnresponse.zip"
}

variable "version_description" {
  default = "v1.1.2 of cfnresponse"
}