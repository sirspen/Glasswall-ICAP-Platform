## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| rancher2 | 1.10.3 |

## Providers

| Name | Version |
|------|---------|
| rancher2.admin | 1.10.3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_region | The Cloud Region | `string` | n/a | yes |
| client\_id | Service Principal ClientID | `string` | n/a | yes |
| client\_secret | Service Principal Secret | `string` | n/a | yes |
| cluster\_name | Bootstrap the virtual machine with this file | `string` | n/a | yes |
| cluster\_network\_plugin | Set the network plugin | `string` | `"canal"` | no |
| environment | Metadata Environment | `string` | n/a | yes |
| kubernetes\_version | The Kubernetes version | `string` | `"v1.19.2-rancher1-1"` | no |
| organisation | Metadata Organisation | `string` | n/a | yes |
| rancher\_admin\_token | The Rancher Admin Token | `string` | n/a | yes |
| rancher\_admin\_url | The Rancher API | `string` | n/a | yes |
| resource\_group | n/a | `string` | n/a | yes |
| service\_name | The Service Name | `string` | n/a | yes |
| subnet\_name | Subnet Name | `string` | n/a | yes |
| subscription\_id | Service Principal Subscription ID | `string` | n/a | yes |
| tenant\_id | Service Principal TenantID | `string` | n/a | yes |
| virtual\_network\_name | Virtual Network Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_id | n/a |
| cluster\_name | n/a |
| kubernetes\_version | n/a |

