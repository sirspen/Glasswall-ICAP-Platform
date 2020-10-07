## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.6 |
| azurerm | ~> 2.30.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 2.30.0 |
| random | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_username | Virtual Machine Admin Username | `string` | `"azure-user"` | no |
| azure\_region | Azure Region | `string` | `"euwest"` | no |
| custom\_data\_file\_path | Custom data filepath | `string` | n/a | yes |
| environment | Metadata Environment | `string` | n/a | yes |
| http\_port | HTTP Port | `number` | `80` | no |
| https\_port | HTTPS Port | `number` | `443` | no |
| network\_cidr\_range | Azure Virtual Network CIDR range | `list(string)` | n/a | yes |
| network\_subnet\_names | Azure Subnet Names | `list(string)` | n/a | yes |
| network\_subnet\_prefixes | Azure Subnet Prefixes | `list(string)` | n/a | yes |
| organisation | Metadata Organisation | `string` | n/a | yes |
| os\_offer | Linux OS Offer | `string` | n/a | yes |
| os\_publisher | Linux OS Publisher | `string` | n/a | yes |
| os\_sku | Linux OS SKU | `string` | n/a | yes |
| os\_version | Linux OS Version | `string` | `"latest"` | no |
| project | Metadata Project | `string` | n/a | yes |
| size | AZ Pipeline Runner VM image name | `string` | `"Standard_DS1_v2"` | no |
| ssh\_port | SSH Port | `number` | `22` | no |

## Outputs

| Name | Description |
|------|-------------|
| linux\_vm\_private\_ips | n/a |
| linux\_vm\_public\_ips | n/a |
| tls\_private\_key | n/a |

