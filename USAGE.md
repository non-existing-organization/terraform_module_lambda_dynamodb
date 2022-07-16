# Usage
<!--- BEGIN_TF_DOCS --->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attribute\_name | Name of the DynamoDB attribute | `string` | n/a | yes |
| cloudwatch\_event\_rule\_name | Name of the CW event rule | `string` | n/a | yes |
| cw\_event\_is\_enabled | Mark if CW event rule is enabled or not | `bool` | n/a | yes |
| dynamodb\_policy\_name | Name of the DynamoDB iam policy | `string` | n/a | yes |
| function\_name | Name of the aws lambda function | `string` | n/a | yes |
| handler | Handler for the aws lambda function, the structure should be the following --> filename.mainfunction | `string` | n/a | yes |
| lambda\_role\_name | Name of the aws lambda execution role | `string` | n/a | yes |
| lambda\_runtime | Lambda runtime i.e <python3.8> | `string` | `"python3.8"` | no |
| output\_path | The path and name of the resulting zip file | `string` | n/a | yes |
| region | n/a | `string` | `"us-east-1"` | no |
| schedule\_expression | Cloudwatch rule rate expression for how frequent you want the lambda function to run | `string` | n/a | yes |
| source\_code\_hash | hash of the current zip file, changes in the function code will produce an update of the lambda function | `string` | n/a | yes |
| table\_name | Name of the DynamoDB table | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| function\_arn | n/a |
| function\_invoke\_arn | n/a |

<!--- END_TF_DOCS --->
