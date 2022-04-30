# Usage
<!--- BEGIN_TF_DOCS --->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| archive | n/a |
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attribute\_name | Name of the DynamoDB attribute | `string` | n/a | yes |
| cloudwatch\_event\_rule\_name | Name of the CW event rule | `string` | n/a | yes |
| dynamodb\_policy\_name | Name of the DynamoDB iam policy | `string` | n/a | yes |
| function\_name | Name of the aws lambda function | `string` | n/a | yes |
| handler | Handler for the aws lambda function, the structure should be the following --> filename.mainfunction | `string` | n/a | yes |
| lambda\_role\_name | Name of the aws lambda execution role | `string` | n/a | yes |
| output\_path | The path and name of the resulting zip file | `string` | n/a | yes |
| region | n/a | `string` | `"us-east-1"` | no |
| schedule\_expression | Cloudwatch rule rate expression for how frequent you want the lambda function to run | `string` | n/a | yes |
| source\_file | The path in your filesystem where your script is located | `string` | n/a | yes |
| table\_name | Name of the DynamoDB table | `string` | n/a | yes |

## Outputs

No output.

<!--- END_TF_DOCS --->
