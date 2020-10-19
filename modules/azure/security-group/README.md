## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Metadata Environment | `string` | n/a | yes |
| organisation | Metadata Organisation | `string` | n/a | yes |
| project | Metadata Project | `string` | n/a | yes |
| region | The Azure Region | `string` | n/a | yes |
| service\_name | This is a consolidated name based on org, environment, region | `string` | n/a | yes |
| service\_type | This is consolidated based on the project, type and suffix | `string` | n/a | yes |
| type | Metadata Type | `string` | n/a | yes |

## Outputs

No output.

