locals {
  table_name          = var.table_name
  attribute_name      = var.attribute_name
  schedule_expression = var.schedule_expression
}

#Lambda definition
resource "aws_lambda_function" "lambda_function" {
  filename         = var.output_path
  function_name    = var.function_name
  source_code_hash = var.source_code_hash
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = var.handler
  runtime          = var.lambda_runtime
  timeout          = 10

  environment {
    variables = merge(
      {
        table_name     = local.table_name
        attribute_name = local.attribute_name
      },
      var.lambda_vars
    )
  }
}

#Iam permissions
resource "aws_iam_role" "iam_for_lambda" {
  name = var.lambda_role_name

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
  name        = var.dynamodb_policy_name
  description = "Dynamodb policy"
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
        Resource = "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/${aws_dynamodb_table.dynamodb_table.name}"
      },
    ]
  })
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.event_rule.arn
}

#DynamoDB table definition
resource "aws_dynamodb_table" "dynamodb_table" {
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
  name                = var.cloudwatch_event_rule_name
  description         = "Rule that triggers lambda function"
  schedule_expression = local.schedule_expression
  is_enabled = var.cw_event_is_enabled
}

resource "aws_cloudwatch_event_target" "cloudwatch_event_target" {
  depends_on = [
    aws_cloudwatch_event_rule.event_rule
  ]
  rule      = aws_cloudwatch_event_rule.event_rule.name
  target_id = "lambda"
  arn       = aws_lambda_function.lambda_function.arn
}