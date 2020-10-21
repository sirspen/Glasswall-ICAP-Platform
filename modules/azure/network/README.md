## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azurerm | ~> 2.30.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 2.30.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| address\_space | Azure Virtual Network CIDR range | `list(string)` | n/a | yes |
| environment | Metadata Environment | `string` | n/a | yes |
| organisation | Metadata Organisation | `string` | n/a | yes |
| region | The Azure Region | `string` | n/a | yes |
| resource\_group | Azure Resource Group | `string` | n/a | yes |
| service\_name | This is a consolidated name based on org, environment, region | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| name | n/a |

