## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_username | Virtual Machine Admin Username | `string` | `"azure-user"` | no |
| custom\_data\_file\_path | Custom data filepath | `string` | n/a | yes |
| environment | Metadata Environment | `string` | n/a | yes |
| lb\_backend\_address\_pool\_id | Load Balancer Backend Address Pool | `string` | n/a | yes |
| lb\_probe\_id | Load Balancer Probe ID | `string` | n/a | yes |
| organisation | Metadata Organisation | `string` | n/a | yes |
| os\_offer | Linux OS Offer | `string` | n/a | yes |
| os\_publisher | Linux OS Publisher | `string` | n/a | yes |
| os\_sku | Linux OS SKU | `string` | n/a | yes |
| os\_version | Linux OS Version | `string` | `"latest"` | no |
| public\_key\_openssh | SSH Public Key | `string` | n/a | yes |
| region | Azure Region | `string` | `"euwest"` | no |
| resource\_group | Azure Resource Group | `string` | n/a | yes |
| service\_name | This is a consolidated name based on org, environment, region | `string` | n/a | yes |
| service\_role | This is the instance role, used to identity a master or worker node | `string` | n/a | yes |
| size | AZ Pipeline Runner VM image name | `string` | `"Standard_DS1_v2"` | no |
| subnet\_id | ID from Subnet module | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| name | n/a |

