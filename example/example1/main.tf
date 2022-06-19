module "security_group_checker" {
  //source                     = "git::https://github.com/non-existing-organization/terraform_module_security_group_checker.git?ref=master"
  source                     = "../../"
  output_path                = "aws-lambda-script/sg-checker.zip"
  function_name              = "security_group_checker_lambda"
  table_name                 = "sg-checker-table"
  attribute_name             = "SecurityGroupId"
  schedule_expression        = "rate(1 minute)"
  handler                    = "sg-checker.handler"
  dynamodb_policy_name       = "sg-checker-dynamodb-policy"
  cloudwatch_event_rule_name = "trigger-sg-checker-lambda"
  lambda_role_name           = "iam_for_lambda"
  lambda_runtime             = "python3.8"
  source_code_hash           = data.archive_file.lambda_zip.output_base64sha256
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "aws-lambda-script/sg-checker.py"
  output_path = "aws-lambda-script/sg-checker.zip"
}