locals {
  table_name          = "sg-checker-table"
  attribute_name      = "SecurityGroupId"
  schedule_expression = "rate(10 minutes)"
}

#Lambda definition
resource "aws_lambda_function" "check_sgs" {
  filename         = "sg-checker.zip"
  function_name    = "security_group_checker_lambda"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "sg-checker.handler"
  runtime          = "python3.8"
  timeout          = 10

  environment {
    variables = {
      table_name     = local.table_name
      attribute_name = local.attribute_name
    }
  }
}

#Iam permissions
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "basic_execution_policy" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "ec2_read_only" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "dynamodb_full" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.dynamodb-policy.arn
}


resource "aws_iam_policy" "dynamodb-policy" {
  name        = "sg-checker-dynamodb-policy"
  description = "Sg checker dynamodb policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:BatchWriteItem",
          "dynamodb:GetItem",
          "dynamodb:BatchGetItem",
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:ConditionCheckItem"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/${aws_dynamodb_table.sg_dynamo_table.name}"
      },
    ]
  })
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.check_sgs.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.event_rule.arn
}

#DynamoDB table definition
resource "aws_dynamodb_table" "sg_dynamo_table" {
  name           = local.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = "30"
  write_capacity = "30"
  attribute {
    name = local.attribute_name
    type = "S"
  }
  hash_key = local.attribute_name
  point_in_time_recovery { enabled = true }
  server_side_encryption { enabled = false }
  lifecycle { ignore_changes = ["write_capacity", "read_capacity"] }
}

#Cloudwatch rule definition
resource "aws_cloudwatch_event_rule" "event_rule" {
  name                = "trigger-sg-checker-lambda"
  description         = "Rule that triggers the sg checker lambda"
  schedule_expression = local.schedule_expression
}

resource "aws_cloudwatch_event_target" "sg_checker_target" {
  depends_on = [
    aws_cloudwatch_event_rule.event_rule
  ]
  rule      = aws_cloudwatch_event_rule.event_rule.name
  target_id = "lambda"
  arn       = aws_lambda_function.check_sgs.arn
}