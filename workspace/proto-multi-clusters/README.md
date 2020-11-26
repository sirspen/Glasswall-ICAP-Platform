## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azurerm | ~> 2.30.0 |
| rancher2 | 1.10.3 |

## Providers

| Name | Version |
|------|---------|
| terraform | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| az\_client\_id | Service Principal ClientID | `string` | n/a | yes |
| az\_client\_secret | Service Principal Secret | `string` | n/a | yes |
| az\_subscription\_id | Service Principal Subscription ID | `string` | n/a | yes |
| azure\_region | Metadata Azure Region | `string` | n/a | yes |
| environment | Metadata Environment | `string` | n/a | yes |
| organisation | Metadata Organisation | `string` | n/a | yes |
| project | Metadata Project | `string` | n/a | yes |
| suffix | Metadata Suffix | `string` | n/a | yes |

## Outputs

No output.

