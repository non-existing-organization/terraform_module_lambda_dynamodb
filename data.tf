data "aws_caller_identity" "current" {}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "aws-lambda-script/sg-checker.py"
  output_path = "sg-checker.zip"
}