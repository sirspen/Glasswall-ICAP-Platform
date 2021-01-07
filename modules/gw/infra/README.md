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
| azure\_region | The cloud region | `string` | n/a | yes |
| backend\_port | Backend Port | `string` | n/a | yes |
| client\_id | Service Principal ClientID | `string` | n/a | yes |
| client\_secret | Service Principal Secret | `string` | n/a | yes |
| cluster\_address\_space | Subnet ID | `list(string)` | n/a | yes |
| cluster\_internal\_services | Ports to open on the internal load balancer | <pre>map(object({<br>      protocol                        = string<br>      frontend_port                   = number<br>      backend_port                    = number<br>  }))</pre> | n/a | yes |
| cluster\_subnet\_cidr | Subnet CIDR | `list(string)` | n/a | yes |
| dns\_zone | The name of the dns zone to add records to | `string` | n/a | yes |
| environment | Metadata Environment | `string` | n/a | yes |
| organisation | Metadata Organisation | `string` | n/a | yes |
| public\_key\_openssh | The Node SSH key | `string` | n/a | yes |
| public\_port | Public Port | `string` | n/a | yes |
| rancher\_admin\_token | The Rancher Admin Token | `string` | n/a | yes |
| rancher\_admin\_url | The Rancher API | `string` | n/a | yes |
| rancher\_internal\_api\_url | The Rancher API | `string` | n/a | yes |
| rancher\_network | The Network name | `string` | n/a | yes |
| rancher\_network\_id | The Network ID | `string` | n/a | yes |
| rancher\_resource\_group | The Rancher Resource Group | `string` | n/a | yes |
| service\_name | The name of the service | `string` | n/a | yes |
| subscription\_id | Service Principal Subscription ID | `string` | n/a | yes |
| suffix | The Suffix | `string` | n/a | yes |
| tenant\_id | Service Principal tenantID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| int\_worker\_ingress\_probe\_id | n/a |
| int\_worker\_ingress\_rules\_ids | n/a |
| int\_worker\_lb\_dns\_name | n/a |
| int\_worker\_lb\_id | n/a |
| int\_worker\_lb\_ip\_address | n/a |
| int\_worker\_lbap\_id | n/a |
| network\_id | n/a |
| network\_name | n/a |
| resource\_group\_name | n/a |
| subnet\_id | n/a |
| subnet\_name | n/a |
| worker\_ingress\_probe\_id | n/a |
| worker\_ingress\_rule\_1\_id | n/a |
| worker\_lb\_dns\_name | n/a |
| worker\_lb\_id | n/a |
| worker\_lb\_ip\_address | n/a |
| worker\_lbap\_id | n/a |

