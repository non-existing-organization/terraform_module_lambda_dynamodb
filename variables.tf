variable "region" {
  type    = string
  default = "us-east-1"
}

variable "output_path" {
  type        = string
  description = "The path and name of the resulting zip file"
}

variable "function_name" {
  type        = string
  description = "Name of the aws lambda function"
}

variable "lambda_runtime" {
  type        = string
  description = "Lambda runtime i.e <python3.8>"
  default     = "python3.8"
}

variable "source_code_hash" {
  type        = string
  description = "hash of the current zip file, changes in the function code will produce an update of the lambda function"
}

variable "table_name" {
  type        = string
  description = "Name of the DynamoDB table"
}

variable "attribute_name" {
  type        = string
  description = "Name of the DynamoDB attribute"
}

variable "schedule_expression" {
  type        = string
  description = "Cloudwatch rule rate expression for how frequent you want the lambda function to run"
}

variable "handler" {
  type        = string
  description = "Handler for the aws lambda function, the structure should be the following --> filename.mainfunction"
}

variable "dynamodb_policy_name" {
  type        = string
  description = "Name of the DynamoDB iam policy"
}

variable "cloudwatch_event_rule_name" {
  type        = string
  description = "Name of the CW event rule"
}

variable "lambda_role_name" {
  type        = string
  description = "Name of the aws lambda execution role"
}

variable "is_enabled" {
  type = bool
  description = "Mark if CW event rule is enabled or not"
}