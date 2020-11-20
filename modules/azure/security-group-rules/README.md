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
| network\_security\_group\_name | The network security group name | `string` | n/a | yes |
| resource\_group\_name | The resource group name | `string` | n/a | yes |
| security\_group\_rules | The rules to add as an object | <pre>map(object({<br>    name                                        = string<br>    priority                                    = string<br>    direction                                   = string<br>    access                                      = string<br>    protocol                                    = string<br>    source_port_range                           = string<br>    destination_port_range                      = string<br>    source_address_prefix                       = string<br>    destination_address_prefix                  = string<br>  }))</pre> | <pre>{<br>  "ssh": {<br>    "access": "Disallow",<br>    "destination_address_prefix": "*",<br>    "destination_port_range": "22",<br>    "direction": "Inbound",<br>    "name": "RestrictedToSSH",<br>    "priority": 100,<br>    "protocol": "Tcp",<br>    "source_address_prefix": "*",<br>    "source_port_range": "22"<br>  }<br>}</pre> | no |

## Outputs

No output.

