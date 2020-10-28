## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| lb\_probe\_port | ID from Public IP module | `string` | `6443` | no |
| public\_ip\_id | ID from Public IP module | `string` | n/a | yes |
| resource\_group | Azure Resource Group | `string` | n/a | yes |
| service\_name | This is a consolidated name based on org, environment, region | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bap\_id | n/a |
| id | n/a |
| probe\_id | n/a |

