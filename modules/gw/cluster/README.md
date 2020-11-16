## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
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
| linux\_vm\_public\_ips | n/a |
| tls\_private\_key | n/a |
| tls\_public\_key | n/a |

