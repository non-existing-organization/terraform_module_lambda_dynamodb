module "security_group_checker" {
    source = "../../"
    source_file = "../../aws-lambda-script/sg-checker.py"
    output_path = "sg-checker.zip"
    function_name =  "security_group_checker_lambda"
    table_name = "sg-checker-table"
    attribute_name = "SecurityGroupId"
    schedule_expression = "rate(1 minute)"
    handler = "sg-checker.handler"
    dynamodb_policy_name = "sg-checker-dynamodb-policy"
    cloudwatch_event_rule_name = "trigger-sg-checker-lambda"
    lambda_role_name = "iam_for_lambda"
}