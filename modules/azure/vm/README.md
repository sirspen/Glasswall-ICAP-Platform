## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azurerm | ~> 2.30.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 2.30.0 |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_username | Virtual Machine Admin Username | `string` | `"azure-user"` | no |
| custom\_data\_file\_path | Custom data filepath | `string` | n/a | yes |
| disk\_size | AZ Pipeline Runner VM image name | `string` | `120` | no |
| environment | Metadata Environment | `string` | n/a | yes |
| http\_port | HTTP Port | `number` | `80` | no |
| https\_port | HTTPS Port | `number` | `443` | no |
| organisation | Metadata Organisation | `string` | n/a | yes |
| os\_offer | Linux OS Offer | `string` | n/a | yes |
| os\_publisher | Linux OS Publisher | `string` | n/a | yes |
| os\_sku | Linux OS SKU | `string` | n/a | yes |
| os\_version | Linux OS Version | `string` | `"latest"` | no |
| public\_ip\_id | ID from Public IP module | `string` | n/a | yes |
| public\_key\_openssh | SSH Public Key | `string` | n/a | yes |
| region | Azure Region | `string` | `"euwest"` | no |
| resource\_group | Azure Resource Group | `string` | n/a | yes |
| security\_group\_rules | n/a | <pre>map(object({<br>    name                                        = string<br>    priority                                    = string<br>    direction                                   = string<br>    access                                      = string<br>    protocol                                    = string<br>    source_port_range                           = string<br>    destination_port_range                      = string<br>    source_address_prefix                       = string<br>    destination_address_prefix                  = string<br>    source_application_security_group_ids       = list(string)<br>    destination_application_security_group_ids  = list(string)<br>  }))</pre> | <pre>{<br>  "http": {<br>    "access": "Allow",<br>    "destination_address_prefix": "*",<br>    "destination_application_security_group_ids": [<br>      "*"<br>    ],<br>    "destination_port_range": "80",<br>    "direction": "Inbound",<br>    "name": "http",<br>    "priority": "1003",<br>    "protocol": "tcp",<br>    "source_address_prefix": "*",<br>    "source_application_security_group_ids": [<br>      "*"<br>    ],<br>    "source_port_range": "80"<br>  },<br>  "https": {<br>    "access": "Allow",<br>    "destination_address_prefix": "*",<br>    "destination_application_security_group_ids": [<br>      "*"<br>    ],<br>    "destination_port_range": "443",<br>    "direction": "Inbound",<br>    "name": "https",<br>    "priority": "1002",<br>    "protocol": "tcp",<br>    "source_address_prefix": "*",<br>    "source_application_security_group_ids": [<br>      "*"<br>    ],<br>    "source_port_range": "443"<br>  },<br>  "ssh": {<br>    "access": "Allow",<br>    "destination_address_prefix": "*",<br>    "destination_application_security_group_ids": [<br>      "*"<br>    ],<br>    "destination_port_range": "22",<br>    "direction": "Inbound",<br>    "name": "ssh",<br>    "priority": "1001",<br>    "protocol": "tcp",<br>    "source_address_prefix": "*",<br>    "source_application_security_group_ids": [<br>      "*"<br>    ],<br>    "source_port_range": "22"<br>  }<br>}</pre> | no |
| service\_name | This is a consolidated name based on org, environment, region | `string` | n/a | yes |
| service\_type | This is consolidated based on the project, type and suffix | `string` | n/a | yes |
| size | AZ Pipeline Runner VM image name | `string` | `"Standard_DS1_v2"` | no |
| ssh\_port | SSH Port | `number` | `22` | no |
| subnet\_id | ID from Subnet module | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| linux\_vm\_private\_ips | n/a |
| linux\_vm\_public\_ips | n/a |
| security\_group\_id | n/a |

