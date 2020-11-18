## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_region | Azure Region | `string` | n/a | yes |
| lb\_probe\_port | ID from Public IP module | `string` | n/a | yes |
| resource\_group | Azure Resource Group | `string` | n/a | yes |
| service\_name | This is a consolidated name based on org, environment, region | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| public\_ip\_address | n/a |

