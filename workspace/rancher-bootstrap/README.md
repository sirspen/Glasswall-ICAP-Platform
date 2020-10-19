## Requirements

| Name | Version |
|------|---------|
| azurerm | =2.30.0 |

## Providers

No provider.

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

| Name | Description |
|------|-------------|
| linux\_vm\_public\_ips | n/a |
| rancher\_admin\_token | n/a |
| rancher\_api\_url | n/a |
| rancher\_password | n/a |
| rancher\_token\_id | n/a |
| rancher\_user | n/a |
| tls\_private\_key | n/a |

