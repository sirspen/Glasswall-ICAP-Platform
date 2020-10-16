## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| rancher2 | 1.10.3 |

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |
| rancher2.bootstrap | 1.10.3 |
| random | n/a |
| time | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_region | Set the Azure Region | `string` | n/a | yes |
| custom\_data\_file\_path | Bootstrap the virtual machine with this file | `string` | n/a | yes |
| environment | Metadata Environment | `string` | n/a | yes |
| organisation | Metadata Organisation | `string` | n/a | yes |
| project | Metadata Project | `string` | n/a | yes |
| suffix | Metadata Project Suffix (so that we can create multiple instances) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| admin\_password | n/a |
| admin\_token | n/a |
| admin\_token\_id | n/a |
| admin\_url | n/a |
| admin\_user | n/a |
| linux\_vm\_public\_ips | n/a |
| rancher\_api\_url | n/a |
| tls\_private\_key | n/a |
| tls\_public\_key | n/a |

