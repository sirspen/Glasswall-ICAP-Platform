## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azurerm | ~> 2.30.0 |
| rancher2 | 1.10.3 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_region | The cloud region | `string` | n/a | yes |
| client\_id | Service Principal ClientID | `string` | n/a | yes |
| client\_secret | Service Principal Secret | `string` | n/a | yes |
| cluster\_address\_space | Address Space | `list(string)` | n/a | yes |
| cluster\_backend\_port | Backend Port | `number` | n/a | yes |
| cluster\_internal\_services | Ports to open on the internal load balancer | <pre>map(object({<br>      protocol                        = string<br>      frontend_port                   = number<br>      backend_port                    = number<br>  }))</pre> | n/a | yes |
| cluster\_public\_port | Public Port | `number` | n/a | yes |
| cluster\_quantity | Quantity of clusters in Region | `number` | n/a | yes |
| cluster\_stage1\_apps | A list of apps | <pre>map(object({<br>    namespace = string<br>    catalog_name = string<br>    template_name = string<br>    create_namespace = bool<br>    system_app = bool<br>  }))</pre> | n/a | yes |
| cluster\_subnet\_cidr | Subnet CIDR | `list(string)` | n/a | yes |
| cluster\_subnet\_prefix | Subnet Prefix | `string` | n/a | yes |
| environment | Metadata Environment | `string` | n/a | yes |
| infra\_module | The Suffix | `string` | `0` | no |
| master\_scaleset\_admin\_user | The Instance Admin User | `string` | n/a | yes |
| master\_scaleset\_size | The Instance Size | `string` | n/a | yes |
| master\_scaleset\_sku\_capacity | Total instances to begin with | `number` | n/a | yes |
| organisation | Metadata Organisation | `string` | n/a | yes |
| os\_offer | OS Offer | `string` | n/a | yes |
| os\_publisher | OS Publisher | `string` | n/a | yes |
| os\_sku | OS SKU | `string` | n/a | yes |
| os\_version | OS Version | `string` | n/a | yes |
| public\_key\_openssh | The Node SSH key | `string` | n/a | yes |
| rancher\_admin\_token | The Rancher Admin Token | `string` | n/a | yes |
| rancher\_admin\_url | The Rancher API | `string` | n/a | yes |
| rancher\_internal\_api\_url | The Rancher API | `string` | n/a | yes |
| rancher\_network | The Rancher Network | `string` | n/a | yes |
| rancher\_network\_id | The Network ID | `string` | n/a | yes |
| rancher\_projects | The Projects to create on a base k8s Cluster | `string` | n/a | yes |
| rancher\_resource\_group | The Rancher Resource Group | `string` | n/a | yes |
| service\_name | The name of the service | `string` | n/a | yes |
| subscription\_id | Service Principal Subscription ID | `string` | n/a | yes |
| suffix | The Suffix | `string` | n/a | yes |
| tenant\_id | Service Principal tenantID | `string` | n/a | yes |
| worker\_scaleset\_admin\_user | The Instance Size | `string` | n/a | yes |
| worker\_scaleset\_size | The Instance Size | `string` | n/a | yes |
| worker\_scaleset\_sku\_capacity | The Instance Size | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cloud\_credentials\_id | n/a |
| cluster\_worker\_lb\_dns\_name | n/a |
| network\_id | n/a |
| network\_name | n/a |
| project\_ids | n/a |
| resource\_group\_name | n/a |
| subnet\_name | n/a |
| system\_ids | n/a |
| worker\_lb\_ip\_address | n/a |

