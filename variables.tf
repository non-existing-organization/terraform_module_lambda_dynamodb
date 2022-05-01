variable "region" {
  type    = string
  default = "us-east-1"
}

variable "source_file" {
  type = string
  description = "The path in your filesystem where your script is located"
}

variable "output_path" {
  type = string
  description = "The path and name of the resulting zip file"
}

variable "function_name" {
  type = string
  description = "Name of the aws lambda function"
}

variable "table_name" {
  type = string
  description = "Name of the DynamoDB table"
}

variable "attribute_name" {
  type = string
  description = "Name of the DynamoDB attribute"
}

variable "schedule_expression" {
  type = string
  description = "Cloudwatch rule rate expression for how frequent you want the lambda function to run"
}

variable "handler" {
  type = string 
  description = "Handler for the aws lambda function, the structure should be the following --> filename.mainfunction"
}

variable "dynamodb_policy_name" {
  type = string
  description = "Name of the DynamoDB iam policy"
}

variable "cloudwatch_event_rule_name" {
  type = string
  description = "Name of the CW event rule"
}

variable "lambda_role_name" {
  type = string
  description = "Name of the aws lambda execution role"
}