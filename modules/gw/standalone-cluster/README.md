## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azurerm | ~> 2.30.0 |
| rancher2 | 1.10.3 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 2.30.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_region | The cloud region | `string` | n/a | yes |
| client\_id | Service Principal ClientID | `string` | n/a | yes |
| client\_secret | Service Principal Secret | `string` | n/a | yes |
| cluster\_backend\_port | Backend Port | `string` | n/a | yes |
| cluster\_network\_name | Subnet Name | `string` | n/a | yes |
| cluster\_public\_port | Public Port | `string` | n/a | yes |
| cluster\_stage1\_apps | A list of apps | <pre>map(object({<br>    namespace = string<br>    catalog_name = string<br>    template_name = string<br>    create_namespace = bool<br>    system_app = bool<br>  }))</pre> | n/a | yes |
| cluster\_stage2\_apps | A list of apps | <pre>map(object({<br>    namespace = string<br>    catalog_name = string<br>    template_name = string<br>    create_namespace = bool<br>    system_app = bool<br>  }))</pre> | n/a | yes |
| cluster\_subnet\_id | Subnet ID | `string` | n/a | yes |
| cluster\_subnet\_name | Subnet Name | `string` | n/a | yes |
| environment | Metadata Environment | `string` | n/a | yes |
| master\_scaleset\_admin\_user | The Instance Admin User | `string` | n/a | yes |
| master\_scaleset\_size | The Instance Size | `string` | n/a | yes |
| master\_scaleset\_sku\_capacity | Total instances to begin with | `string` | n/a | yes |
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
| rancher\_resource\_group | The rancher resource group | `string` | n/a | yes |
| service\_name | The name of the service | `string` | n/a | yes |
| subscription\_id | Service Principal Subscription ID | `string` | n/a | yes |
| suffix | The Suffix | `string` | n/a | yes |
| tenant\_id | Service Principal tenantID | `string` | n/a | yes |
| worker\_scaleset\_admin\_user | The Instance Size | `string` | n/a | yes |
| worker\_scaleset\_size | The Instance Size | `string` | n/a | yes |
| worker\_scaleset\_sku\_capacity | The Instance Size | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cloud\_credentials\_id | n/a |
| cluster\_access\_key | n/a |
| cluster\_id | n/a |
| cluster\_name | n/a |
| cluster\_secret\_key | n/a |
| cluster\_token\_enabled | n/a |
| cluster\_worker\_lb\_dns\_name | n/a |
| crt\_cluster\_id | n/a |
| crt\_cluster\_node\_command | n/a |
| crt\_cluster\_token | n/a |
| kubernetes\_version | n/a |
| network\_name | n/a |
| project\_ids | n/a |
| resource\_group\_name | n/a |
| subnet\_name | n/a |
| system\_ids | n/a |
| worker\_lb\_ip\_address | n/a |

